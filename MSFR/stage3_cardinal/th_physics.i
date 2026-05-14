# =============================================================
# th_physics.i
# MSFR 熱液壓子程式 — 第二版（Physics Action 架構）
#
# 【本檔案的角色】
#   Cardinal 耦合框架中的 TH SubApp（子程式）
#   main.i 透過 MultiApp 呼叫本檔案，負責：
#     OpenMC 傳來的 power_density → 計算 T_fluid, vel_x/y/z → 回傳 OpenMC
#
# 【為什麼要重寫】
#   舊版 th_run4b_energy.i 的根本問題：
#     1. 手動 SIMPLE FVKernels：壓力修正法分離求解
#        → Sliver Elements（SJ<0.1，體積→0）使矩陣對角線→0
#        → 速度飆升到 3.39e6 m/s（實際應為 ~1 m/s）
#     2. T_clipped 防火牆（1K~1800K）只是掩蓋問題
#        → avg_T=1234K（應為~1000K），keff=0.877（應為~1.047）
#        → Stage 3a run12 的假收斂就是這個原因
#
# 【新架構的解決方案】
#     1. [Physics] 系統：自動啟用 skewness-corrected + Rhie-Chow 插值
#        → 幾何偏斜梯度誤差消除，壓力棋盤格震盪消除
#     2. Pseudo-Transient（Transient NEWTON 模式）：
#        → ∂(ρu)/∂t 項在對角線加入 ρ×V_c/Δt
#        → 即使 V_c 極小（Sliver），小 Δt 也能補充對角優勢
#        → 隨 Δt 逐漸增大逼近穩態解
#     3. k-ε 湍流模型（Physics Action 自動生成所有 kernels）
#        → 取代 12+ 行手動 FVKernels，避免遺漏或錯誤
#
# 【幾何資訊】
#   網格：msr_with_sidesets.e（35186 TETRA4，9245 nodes）
#   已知缺陷：313 個 Sliver Elements（SJ < 0.1，最差 SJ=0.01912）
#   位置：入口槽與球壁銳角交界處
#   決策：不重建網格，靠新架構的穩定機制應對
#
# 【邊界組】
#   gap_enter_boundary：16 個入口槽的下截面（燃料鹽入口）
#   gap_exit_boundary ：16 個出口槽的上截面（燃料鹽出口）
#   wall              ：球體內壁（no-slip 壁面）
#
# 【燃料鹽物性】（來源：Rouch et al. 2014 + ANL Cardinal tutorial）
#   ρ  = 4147.3 kg/m³      密度（常數）
#   μ  = 0.011266321 Pa·s  動黏度
#   cp = 1524.86 J/kg·K    比熱
#   k  = 1.0 W/m·K         熱傳導係數
#
# 【入口條件】
#   速度：U_z = 1.1838 m/s（+z 方向，垂直入口截面）
#   溫度：T_in = 898 K
#   Re = ρUL/μ ≈ 4147.3 × 1.1838 × 0.5 / 0.01127 ≈ 218,000
#
# 【Cardinal 變數介面】
#   main.i 寫入本檔案：power_density（[W/m³]，來自 OpenMC）
#   main.i 讀取本檔案：T_fluid（[K]，回傳更新截面用）
#   [Physics] 自動宣告的變數：vel_x, vel_y, vel_z, pressure, T_fluid, k, epsilon
#
# 日期：2026-05-14
# =============================================================


# ─────────────────────────────────────────────────────────────
# [Mesh]：載入幾何網格
#
# FileMesh 直接讀取 Exodus II 格式（.e）
# 路徑相對於本檔案位置（../  = MSFR/ 目錄）
# ─────────────────────────────────────────────────────────────
[Mesh]
  type = FileMesh
  file = '../msr_with_sidesets.e'
[]


# ─────────────────────────────────────────────────────────────
# [FunctorMaterials]：流體物性定義
#
# ADGenericFunctorMaterial：
#   - AD = Automatic Differentiation，支援 Newton 求解器的 Jacobian 自動計算
#   - Functor = 可以是常數、函數、或其他變數的通用包裝器
#   - 這裡全部定義為常數（燃料鹽在 850-1000K 範圍內物性變化不大）
#
# prop_names 的字串必須與 [Physics] 中引用的名稱完全一致：
#   density              = 'rho'
#   dynamic_viscosity    = 'mu'
#   thermal_conductivity = 'k_fluid'
#   specific_heat        = 'cp'
# ─────────────────────────────────────────────────────────────
[FunctorMaterials]
  [fluid_props]
    type = ADGenericFunctorMaterial
    prop_names  = 'rho    mu      k_fluid  cp'
    prop_values = '4147.3 0.7373  1.0      1524.86'
    # mu = 固定有效黏度 μ_eff = μ_mol + μ_t
    # μ_t = ρ Cμ k²/ε = 4147.3 × 0.09 × 0.00264²/0.00362 = 0.726 Pa·s
    # μ_eff = 0.0113 + 0.726 ≈ 0.7373 Pa·s
    # 注意：此版本 Cardinal (2025-10) 的 [Physics] 不支援 [Turbulence] 模組
    # 暫以固定 μ_eff 替代 k-ε，先驗證 Sliver Element 問題是否解決
    # 後續待辦：Cardinal 升級後恢復真正的 k-ε（見工作日誌 2026-05-14）
  []
[]


# ─────────────────────────────────────────────────────────────
# [AuxVariables]：輔助變數
#
# power_density：來自 Cardinal 的 OpenMC 功率密度 [W/m³]
#   - main.i 透過 MultiAppGeneralFieldShapeEvaluationTransfer 寫入
#   - [Physics/FluidHeatTransfer] 將它作為熱源項 Q‴ 加入能量方程
#   - 單獨跑 TH 測試時：power_density = 0（等溫流動，只驗證速度場）
#   - MooseVariableFVReal = 有限體積的 cell-centered 變數（一個值對應一個 cell）
# ─────────────────────────────────────────────────────────────
[AuxVariables]
  [power_density]
    type = MooseVariableFVReal
    initial_condition = 0.0   # 單獨跑 TH 時為 0，Cardinal 耦合時由 Transfer 覆蓋
  []
[]


# ─────────────────────────────────────────────────────────────
# [Physics]：MOOSE 新一代物理方程系統（2024/2025 標準）
#
# 【為什麼用 [Physics] 而不是手動 [FVKernels]】
#   舊版 [Modules]/NSFVAction 已棄用（Deprecated）
#   [Physics] 是現行標準，自動完成：
#     - 變數宣告（vel_x/y/z, pressure, T_fluid, k, epsilon）
#     - 所有 FVKernels（動量、質量、能量、湍流方程）
#     - 所有 FVBCs（入口、出口、壁面）
#     - Rhie-Chow 插值 UserObject
#     - 壁函數 UserObject
#   手動寫這些需要 80+ 行且容易漏寫或拼錯，[Physics] 只需 ~50 行
#
# 架構：[Physics] → [NavierStokes] → [Flow] / [FluidHeatTransfer] / [Turbulence]
# ─────────────────────────────────────────────────────────────
[Physics]
  [NavierStokes]

    # ──────────────────────────────────────────────
    # [Flow]：不可壓縮動量方程 + 質量守恆
    #
    # 對應的偏微分方程：
    #   質量：∇·u = 0
    #   動量：ρ ∂u/∂t + ρ(u·∇)u = -∇p + ∇·[(μ+μ_t)∇u]
    #                               ↑壓力梯度 ↑黏性+湍流擴散
    # ──────────────────────────────────────────────
    [Flow]
      [flow_physics]
        compressibility = 'incompressible'
        # incompressible = 密度不隨壓力/溫度變化（∇·u = 0 嚴格成立）
        # 對 MSFR 熔鹽（液態，Ma << 1）是合理假設

        # ── 穩定插值方案（三重保護，對付 Sliver Elements）──

        velocity_interpolation = 'rc'
        # rc = Rhie-Chow 插值
        # 【問題】同位網格（colocated grid）：速度和壓力定義在同一個 cell 中心
        #         標準插值產生「棋盤格」壓力震盪（checkerboard instability）
        # 【RC 解法】面速度插值加入壓力梯度修正：
        #            u_face = avg(u_L, u_R) - f(∇p_L, ∇p_R)
        # 【效果】壓力場光滑，消除人工振盪

        pressure_face_interpolation = 'skewness-corrected'
        # 【問題】Sliver Elements 的面中心與兩側 cell 中心連線嚴重偏斜
        #         標準梯度估算 (φ_R - φ_L)/d 有很大幾何誤差
        # 【解法】∇φ_face = 標準差分 + 偏斜修正項（投影到實際面法向量方向）
        # 【效果】即使 SJ=0.019 的極端 Sliver，梯度估算仍然合理

        momentum_advection_interpolation = 'upwind'
        # 【問題】中央差分（'average'）對高 Re 流動（Re~218,000）產生數值振盪
        # 【解法】上風格式：從上游 cell 取值，天然加入數值擴散
        # 【代價】一階精度（比二階低），但對 Sliver 問題更穩定
        # 【未來】流場收斂後可改回 'average'（二階）提高精度

        # ── 流體物性（引用 FunctorMaterials 的 prop_names）──
        density = 'rho'
        dynamic_viscosity = 'mu'

        # ── 邊界條件：入口 ──
        inlet_boundaries = 'gap_enter_boundary'
        # gap_enter_boundary = 16 個入口槽的下截面（Cubit 定義的 sideset）

        momentum_inlet_types = 'fixed-velocity'
        # Dirichlet BC：強制指定入口速度向量

        momentum_inlet_functors = '0 0 1.1838'
        # 格式：'vx vy vz'（單位 m/s）
        # vz = +1.1838 m/s：燃料鹽沿 +z 方向（向上）流入球心
        # vx = vy = 0：入口無橫向分量（垂直入口截面）

        # ── 邊界條件：壁面 ──
        wall_boundaries = 'wall'
        momentum_wall_types = 'noslip'
        # noslip = 壁面速度 = 0（黏著條件，物理上正確）
        # 搭配 [Turbulence] 的 standard-wall-function 使用

        # ── 邊界條件：出口 ──
        outlet_boundaries = 'gap_exit_boundary'
        momentum_outlet_types = 'fixed-pressure'
        # Dirichlet BC on pressure
        pressure_functors = '0'
        # 錶壓 p = 0（參考壓力）
        # 不可壓縮流只關心壓力差，絕對值不影響速度場

        # ── 初始條件 ──
        initial_velocity = '0 0 0'
        # 靜止起步：全場速度 = 0
        # Pseudo-Transient 從靜止逐漸建立流場（比非零 IC 更穩定）
        initial_pressure = 0.0
      []
    []

    # ──────────────────────────────────────────────
    # [FluidHeatTransfer]：流體能量方程
    #
    # 對應的偏微分方程：
    #   ρ cp ∂T/∂t + ρ cp (u·∇)T = ∇·[(k+k_t)∇T] + Q‴
    #   ↑瞬態         ↑對流          ↑熱擴散（含湍流）  ↑熱源
    #
    # Q‴ = power_density（[W/m³]，來自 OpenMC 的裂變熱沉積）
    # k_t = μ_t × cp / Pr_t（湍流熱擴散，由湍流模型提供 μ_t）
    # ──────────────────────────────────────────────
    [FluidHeatTransfer]
      [energy_physics]
        coupled_flow_physics = 'flow_physics'
        fluid_heat_transfer_physics = 'energy_physics'
        turbulence_handling = 'k-epsilon'
        # 耦合到 [Flow] 的流動物理
        # Physics 系統透過這個連結自動取得速度場，建立對流項 ρ cp (u·∇)T

        energy_advection_interpolation = 'upwind'
        # 與動量方程一致，高 Re 用上風防止溫度場振盪

        energy_face_interpolation = 'skewness-corrected'
        # 與動量方程一致，消除 Sliver 幾何偏斜誤差

        # ── 流體物性 ──
        thermal_conductivity = 'k_fluid'
        specific_heat = 'cp'

        # ── 邊界條件：入口 ──
        energy_inlet_types = 'fixed-temperature'
        # Dirichlet BC：固定入口溫度
        energy_inlet_functors = '898.0'
        # T_in = 898 K（與 Stage 2 OpenMC 的假設溫度一致）

        # ── 邊界條件：壁面 ──
        energy_wall_types = 'heatflux'
        # Neumann BC：指定熱通量
        energy_wall_functors = '0'
        # 熱通量 = 0：絕熱壁
        # 物理意義：MSFR 球壁無外部冷卻，熱量靠燃料鹽流動從出口帶走

        # ── 外部熱源（耦合的關鍵）──
        external_heat_source = 'power_density'
        # 引用 [AuxVariables] 中的 power_density AuxVariable
        # 作為能量方程的體積熱源項 Q‴ [W/m³]
        # 單獨跑 TH：power_density=0 → 等溫流動（只驗證速度場）
        # Cardinal 耦合：power_density = OpenMC 裂變熱沉積（非零）
        external_heat_source_coeff = 1.0
        # 無需縮放（已是正確單位 W/m³）

        # ── 初始條件 ──
        initial_temperature = 898.0
        # 全場初始溫度 = 入口溫度，減少初始暫態時間
      []
    []

    # ──────────────────────────────────────────────
    # [Turbulence]：k-ε 湍流模型
    #
    # 【為什麼需要湍流模型】
    #   Re ≈ 218,000 >> 臨界 Re ~2300 → 充分發展湍流
    #   有效黏度 μ_eff = μ + μ_t（μ_t 可達分子黏度的 100~1000 倍）
    #   若用層流模型（no turbulence），動量擴散嚴重低估，速度場完全錯誤
    #
    # 【k-ε 模型的兩個輸運方程】
    #   k 方程（湍流動能）：
    #     ∂(ρk)/∂t + ∇·(ρuk) = ∇·[(μ+μ_t/σ_k)∇k] + P_k - ρε
    #     P_k = μ_t |∇u + (∇u)^T|²（速度梯度驅動的湍流生成）
    #
    #   ε 方程（湍流耗散率）：
    #     ∂(ρε)/∂t + ∇·(ρuε) = ∇·[(μ+μ_t/σ_ε)∇ε]
    #                           + C1ε(ε/k)P_k - C2ε ρ(ε²/k)
    #
    #   湍流黏度：μ_t = ρ Cμ k²/ε   （Cμ = 0.09，標準常數）
    #
    # 【為什麼選 k-ε 而不是 k-ω SST】
    #   RTXWS 的 Cardinal（2025-10 commit）的 [Physics] 只支援：
    #   'mixing-length'、'k-epsilon'、'none'
    #   k-ω SST 是更新版本才加入的功能，驗證時出現 Invalid option 錯誤
    #   k-ε 對大尺度湍流主導的流場（本案）已足夠，
    #   Cardinal MSFR tutorial 和 Tano et al. 2025 論文都使用 k-ε
    # ──────────────────────────────────────────────
    # [Turbulence] 已移除：此版本 Cardinal (2025-10) 不支援 [Physics/Turbulence]
  # 改用固定 μ_eff=0.7373（見 FunctorMaterials）。Git 歷史保有完整原始碼。

  [] # end NavierStokes
[] # end Physics


# ─────────────────────────────────────────────────────────────
# [Postprocessors]：後處理器
#
# 兩個用途：
#   1. 收斂監控：每個 timestep 輸出到 CSV，觀察物理量趨勢
#   2. Cardinal 讀取：avg_T 供 Picard 收斂判斷
#
# 【如何用這些數值判斷計算健康狀態】
#   max_vel_z > 1000 m/s → Sliver Element 仍有異常（舊版：3.39e6 m/s）
#   max_vel_z ~1–10 m/s  → 速度場物理合理
#   avg_T ≈ 898K         → 單獨測試（power_density=0）的正常值
#   avg_T ~950–1100K     → Cardinal 耦合時的合理範圍
#   avg_T > 1200K        → Sliver 問題未解決，假收斂
# ─────────────────────────────────────────────────────────────
[Postprocessors]

  [avg_T]
    # 全場體積平均溫度
    # 目標：~1000K（Tano et al. 假設均勻 936K）
    # run12 錯誤值：1234K（Sliver 污染）
    # Cardinal Picard 迭代的收斂判斷讀取此值
    type = ElementAverageValue
    variable = T_fluid
    execute_on = 'timestep_end'
  []

  [max_vel_z]
    # 速度 z 分量最大值
    # 【最重要的診斷指標】監控 Sliver Element 是否仍有異常速度
    # 舊版最大值：3,388,682 m/s（完全不物理）
    # 新版期望值：< 10 m/s（入口速度 1.1838 m/s，加速後合理範圍）
    type = ElementExtremeValue
    variable = vel_z
    value_type = max
    execute_on = 'timestep_end'
  []

  [min_vel_z]
    # 速度 z 分量最小值（負值 = 回流）
    # MSFR 16 噴嘴幾何會產生複雜渦流，預期有部分負值（回流區）
    # 若 min_vel_z << -100 m/s → 異常訊號
    type = ElementExtremeValue
    variable = vel_z
    value_type = min
    execute_on = 'timestep_end'
  []

  [outlet_avg_T]
    # 出口截面平均溫度（驗證能量守恆用）
    # 單獨測試（power_density=0）：outlet_T 應 ≈ 898K
    # Cardinal 耦合後：outlet_T > inlet_T = 898K（熱量被帶走）
    type = SideAverageValue
    variable = T_fluid
    boundary = 'gap_exit_boundary'
    execute_on = 'timestep_end'
  []

  [power_density_avg]
    # 全場平均功率密度
    # 驗證 Cardinal Transfer 是否有效寫入 power_density AuxVariable
    # 單獨測試時 = 0.0（正常）
    # Cardinal 耦合後應為 ~10^7–10^8 W/m³（視功率設定）
    type = ElementAverageValue
    variable = power_density
    execute_on = 'timestep_end'
  []

[]


# ─────────────────────────────────────────────────────────────
# [Executioner]：執行器（求解策略）
#
# 【Pseudo-Transient 的核心原理】
#
#   穩態問題（直接求解）：R(u) = 0
#   困境：Sliver Elements 使 Jacobian 對角線→0，Newton 發散
#
#   Pseudo-Transient 策略（求解暫態問題逼近穩態）：
#     M × (u^{n+1} - u^n)/Δt + R(u^{n+1}) = 0
#     其中 M = 質量矩陣，對角線含 ρ × V_cell / Δt
#
#   關鍵效果：
#     Jacobian 對角 ≈ ρ × V_cell / Δt + ∂R/∂u
#     即使 V_cell 極小（Sliver），足夠小的 Δt 使 ρV/Δt 主導對角
#     → 矩陣從病態恢復對角佔優 → Newton 穩定收斂
#
#   Δt 逐漸增大（IterationAdaptiveDT）：
#     小 Δt → ρV/Δt 大 → 穩定 → 慢慢建立流場
#     大 Δt → ρV/Δt 小 → 趨近真正穩態解
#     Δt → ∞ → 等同直接穩態，即我們的目標
# ─────────────────────────────────────────────────────────────
[Executioner]
  type = Transient
  # Transient 框架 = Pseudo-Transient
  # 用時間積分逼近穩態，不是真正的物理暫態計算

  solve_type = 'NEWTON'
  # 完整 Newton（完整 Jacobian）
  # 比 PJFNK（近似 Jacobian）更穩定，適合病態問題

  # ── PETSc 線性求解器設定 ──
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_type -pc_factor_shift_type -snes_linesearch_type'
  petsc_options_value  = 'lu      mumps                       NONZERO               bt'
  #
  # pc_type = lu：LU 直接分解（Direct Solver）
  #   比 Krylov 迭代法更穩定，適合首次調試
  #   代價：記憶體需求大，但本機 V100S 32GB×2 + 35186 元素可負擔
  #
  # mumps：Multifrontal Massively Parallel Sparse direct Solver
  #   支援 MPI 並行（16 核）的分散式 LU 分解
  #   對非結構網格的病態矩陣比 SuperLU 更穩定
  #
  # NONZERO：遇到零主元時自動加小擾動，防止除零
  #
  # bt：backtracking line search
  #   Newton 步過大時自動縮小步長，直到殘差確實下降
  #   對 Re~218,000 的高非線性問題尤其重要

  # ── Newton 收斂標準 ──
  nl_abs_tol = 1e-8    # ||R||_2 < 1e-8（絕對殘差）
  nl_rel_tol = 1e-6    # ||R||_2 / ||R_0||_2 < 1e-6（相對殘差）
  nl_max_its = 20      # 每時間步最多 20 次 Newton 迭代
  l_tol = 1e-5         # 線性求解相對殘差
  l_max_its = 100      # 每次 Newton 步最多 100 次線性迭代

  # ── 自適應時間步長 ──
  [TimeStepper]
    type = IterationAdaptiveDT
    # 根據 Newton 迭代次數自動調整 Δt

    dt = 1e-4
    # 初始 Δt = 0.0001 s（極小，確保初始穩定）
    # 此時對角補充量 ρV/Δt 足以穩定最惡劣的 Sliver

    cutback_factor = 0.5    # 不收斂時：Δt 減半
    growth_factor = 1.2     # 收斂良好時：Δt 增大 20%

    optimal_iterations = 6
    # 目標 Newton 迭代次數
    # 實際 < 6 → Δt 增大（步長太保守）
    # 實際 > 6 → Δt 減小（步長太激進）

    dtmax = 1.0
    # 最大 Δt = 1.0 s
    # 對應燃料鹽流過球形爐心的對流時間尺度 ~L/U = 1m/1.2m/s ~0.8s
  []

  # ── 穩態偵測 ──
  steady_state_detection = true
  # 自動偵測穩態，不需等到 end_time

  steady_state_tolerance = 1e-6
  # ||u^{n+1} - u^n||_2 / ||u^n||_2 < 1e-6 → 判斷為穩態

  steady_state_start_time = 10.0
  # t < 10s 不啟用穩態偵測（初始場建立期，殘差自然快速下降，避免假穩態）

  end_time = 1e5
  # 安全上限：100,000 s（正常情況下 steady_state_detection 早已觸發）
[]


# ─────────────────────────────────────────────────────────────
# [Outputs]：輸出控制
#
# Exodus：場變數（vel_x/y/z, pressure, T_fluid, k, epsilon）
#         用 ParaView 可視化，time_step_interval=10 減少 I/O
# CSV：後處理器數值（avg_T, max_vel_z 等），每步輸出，用於畫收斂曲線
# ─────────────────────────────────────────────────────────────
[Outputs]

  [exodus]
    type = Exodus
    file_base = 'th_physics_out'
    execute_on = 'timestep_end'
    time_step_interval = 10
    # 每 10 個時間步輸出一次場變數
    # （注意：舊版用 'interval'，已 Deprecated，新版改用 'time_step_interval'）
  []

  [csv]
    type = CSV
    file_base = 'th_physics_out'
    execute_on = 'timestep_end'
    # 每步輸出後處理器數值（avg_T, max_vel_z 等）
    # 開銷極小，不需設 time_step_interval
  []

  print_linear_residuals = false
  # 關閉線性殘差輸出（Krylov 迭代每步都輸出很冗長）
  # 調試時可設為 true，觀察線性求解器收斂行為
[]
