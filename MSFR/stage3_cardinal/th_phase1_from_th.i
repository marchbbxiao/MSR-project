# ============================================================
# MOOSE RANS TH 熱流計算輸入檔 (th.i)
# ============================================================
# 目的：求解燃料鹽的速度場 v(r) 和溫度場 T(r)
# 接收來自 neutronics.i 的功率密度 q‴(r) 作為熱源
#
# 求解的物理方程式：
#   1. 質量守恆（連續方程式）：∇⋅v = 0
#   2. 動量守恆（RANS N-S）：ρ Dv/Dt = -∇p + ∇⋅[(μ+μt)∇v] + ρg
#   3. 能量守恆：ρcp DT/Dt = ∇⋅[(k+kt)∇T] + q‴
#   4. TKE 輸送方程式：ρ Dk/Dt = ∇⋅[(μ+μt/σk)∇k] + Pk - ρε
#   5. TKED 輸送方程式：ρ Dε/Dt = ∇⋅[(μ+μt/σε)∇ε] + C1(ε/k)Pk - C2ρε²/k
#
# 為什麼用 RANS 而非直接求解 N-S？
#   MSFR 雷諾數 Re ≈ 958,000（強湍流），直接求解（DNS）計算量
#   約需 10^13 個網格點，超級電腦也無法負荷。
#   RANS 對速度做時間平均 v = v̄ + v'，把湍流效果打包成
#   湍流黏度 μt = Cμ * k²/ε，大幅降低計算成本。
#
# 求解器架構：SIMPLE（分離式穩態求解器）
#   不使用 Transient executioner，因此所有時間項 kernel 已停用。
#   SIMPLE 把速度-壓力耦合拆成多個獨立系統，分別迭代求解。
#
# 來源參考：Tano et al. 2025, Progress in Nuclear Energy 178, 105503
#           channel_ERCOFTAC.i（Dr. Tano 本人的 RANS k-ε 範本）

# ============================================================
# 全域參數定義（頂層變數，可用 ${} 引用）
# ============================================================
# SIMPLE 壓力梯度標籤：讓 Rhie-Chow 物件能單獨提取壓力項
pressure_tag = "pressure_grad"

# 燃料鹽物性（來源：Rouch et al. 2014，ANL Cardinal tutorial）
rho = 4147.3        # 密度 [kg/m³]
mu = 0.011266321    # 動力黏度 [Pa·s]
cp = 1524.86  # 比熱容 [J/kg/K]（INSFVEnergyAdvection 內建處理，暫時未用）
k = 1.0             # 熱傳導係數 [W/m·K]（暫用，待確認正確值）

# ============================================================
# [GlobalParams]：全域參數（所有 kernel 自動繼承）
# ============================================================
# 把重複出現的參數集中在這裡，避免每個 kernel 都要寫一遍。
# 任何 kernel 只要有這些參數名稱，就會自動套用這裡的值。
#
# rhie_chow_user_object = 'rc'：
#   指向 [UserObjects] 定義的 Rhie-Chow 插值物件
#   所有速度、壓力相關 kernel 都需要它消除棋盤格振盪
#
# advected_interp_method = 'upwind'：
#   對流項的面插值方法
#   upwind（一階迎風）：穩定性好，適合強對流的湍流問題（Re≈958000）
#   average（中央差分）：精度較高但容易振盪，不適合高 Re 流
#
# velocity_interp_method = 'rc'：
#   速度的面插值用 Rhie-Chow（rc）方法
#   目的：在同位網格上消除壓力棋盤格振盪（checkerboard instability）
[GlobalParams]
  rhie_chow_user_object = 'rc'
  advected_interp_method = 'upwind'
  velocity_interp_method = 'rc'
[]

# ============================================================
# [Problem]：求解系統定義
# ============================================================
# SIMPLE 分離式求解器的核心設定：
#   把 7 個變數分配到 7 個獨立的求解系統
#   每個系統可以獨立設定鬆弛因子、收斂條件、求解器參數
#
# 為什麼要分離？
#   全耦合（monolithic）：7個變數組成一個大矩陣，記憶體需求巨大
#   分離式（segregated）：每次只解一個小矩陣，記憶體友善
#   代價：需要反覆迭代直到各系統收斂（SIMPLE 迭代）
#
# previous_nl_solution_required = true：
#   每次非線性迭代開始前，保留上一次的解作為初始猜測
#   對 SIMPLE 演算法的收斂至關重要
#
# type = FEProblem：
#   Cardinal 需要明確指定 Problem type，否則預設 NekInitAction
#   會要求 NekRS 相關參數而報錯
[Problem]
  type = FEProblem
  restart_file_base = 'th_stokes_checkpoint_cp/0001'
  allow_initial_conditions_with_restart = true
  nl_sys_names = 'u_system v_system w_system pressure_system'
  previous_nl_solution_required = true
[]

# ============================================================
# [UserObjects]：Rhie-Chow 插值物件
# ============================================================
# INSFVRhieChowInterpolatorSegregated：
#   SIMPLE 分離式求解器專用的 Rhie-Chow 插值
#
# 為什麼需要 Rhie-Chow？
#   同位網格（collocated grid）：速度和壓力存在同一個網格中心
#   問題：用標準中央差分計算壓力梯度時，
#         相鄰奇數和偶數格點的壓力解耦，
#         產生鋸齒狀「棋盤格振盪」（checkerboard instability）
#   Rhie-Chow 修正：在計算網格面的速度時，
#         加入壓力修正項，重新耦合相鄰格點的速度和壓力
#
# 注意：3D 問題需要提供 u、v、w 三個速度分量
[UserObjects]
  [rc]
    type = INSFVRhieChowInterpolatorSegregated
    u = vel_x
    v = vel_y
    w = vel_z
    pressure = pressure
  []
[]

# ============================================================
# [Mesh]：載入幾何網格
# ============================================================
# msr_with_sidesets.e 由 read_mesh.py 從原始 msr.e 產生
# 包含三個 side sets（面集合，供邊界條件使用）：
#   - gap_exit_boundary（334面，上方截斷面 Z > 0）：燃料鹽流出口
#   - gap_enter_boundary（336面，下方截斷面 Z < 0）：燃料鹽流入口
#   - wall（11304面，球形爐心外壁）：無滑移壁面
#
# ⚠️ 注意：原始 msr.e 只有節點集合（node sets），無法用於 FVBCs。
#    read_mesh.py 已修正為用 element+side 定義正確的 side sets。
# 格式：Exodus II（.e）
[Mesh]
  [file]
    type = FileMeshGenerator
    file = ../msr_with_sidesets.e
  []
[]

# ============================================================
# [Variables]：求解目標變數（MOOSE 直接求解這些未知量）
# ============================================================
# 共 7 個變數，對應 5 組方程式：
#   vel_x, vel_y, vel_z → 動量方程式（3條）
#   pressure            → 質量守恆（連續方程式）
#   TKE, TKED           → k-ε 湍流模型（2條）
#   T_fluid             → 能量方程式（1條）
#
# 每個變數的兩個重要參數：
#   solver_sys：指定這個變數屬於哪個求解系統
#     SIMPLE 分離式求解器把每個方程式拆成獨立系統，
#     分別控制鬆弛因子和收斂條件，避免強耦合造成發散
#   two_term_boundary_expansion = false：
#     關閉邊界處的二階外插，提升近壁區域的數值穩定性
#     k-ε 模型在壁面附近梯度很大，高階外插容易產生振盪
#
# 注意：AuxVariables（如 power_density、mu_t）不是求解目標，
#       而是從外部傳入或由 AuxKernel 計算的輔助量，不需要 solver_sys
#
# ── 速度截斷（Velocity Clipping）說明 ────────────────────────
# Test 1~6 的 overflow 根因（Gemini 診斷確認）：
#   某特定迭代步，三個速度分量同時暴衝至 0.5~0.9（非物理值）
#   → 局部對流係數飆高 → A_diag → 0 → A_inv → ∞
#   → 壓力修正量 p' 被放大至無窮大 → overflow 崩潰
#
# 解法：加入 lower_bound / upper_bound 截斷速度場
#   當任何網格的速度超過物理上限時，強制切斷在合理範圍內
#   防止 A_diag 趨近於零
#
# 截斷值選擇依據：
#   入口速度 U_in = 1.1838 m/s
#   爐心內最大合理速度：考慮幾何收縮，估計不超過 5.0 m/s
#   （5.0 / 1.1838 ≈ 4.2 倍入口速度，保守估計）
#   負值：允許回流（球形爐心中心可能有局部回流），設為 -5.0
[Variables]
  [vel_x]
    # x 方向速度分量 [m/s]
    # 對應動量方程式 x 分量：ρ Dvx/Dt = -∂p/∂x + ∇⋅[(μ+μt)∇vx]
    # 初始速度為零（靜止起始），SIMPLE 迭代過程中逐漸建立流場
    #
    # ── 速度截斷（Test 7 新增）────────────────────────────────
    # lower_bound = -5.0：防止非物理負向暴衝
    # upper_bound = 5.0：防止非物理正向暴衝
    # 當 SIMPLE 試圖把速度推超過此範圍時，強制切回邊界值
    # → A_diag 不會趨近於零 → A_inv 不會爆炸 → 避免 overflow
    type = INSFVVelocityVariable
    initial_condition = 0.0
    solver_sys = u_system
    two_term_boundary_expansion = false
    lower_bound = -5.0
    upper_bound = 5.0
  []
  [vel_y]
    # y 方向速度分量 [m/s]
    # MSFR 是球形對稱爐心，主流方向為 z，
    # x、y 方向速度由湍流和幾何不對稱產生，初始為零
    #
    # ── 速度截斷（Test 7 新增）────────────────────────────────
    # 同 vel_x，截斷範圍 [-5.0, 5.0]
    # y 方向同樣可能出現局部回流或橫向速度暴衝
    type = INSFVVelocityVariable
    initial_condition = 0.0
    solver_sys = v_system
    two_term_boundary_expansion = false
    lower_bound = -5.0
    upper_bound = 5.0
  []
  [vel_z]
    # z 方向速度分量 [m/s]，主流方向（向上）
    # 初始為零，入口邊界條件（1.1838 m/s）會驅動流場建立
    #
    # ── 速度截斷（Test 7 新增）────────────────────────────────
    # 主流方向，入口速度 1.1838 m/s
    # upper_bound = 5.0：約為入口速度的 4.2 倍，合理上限
    # lower_bound = -5.0：允許爐心頂部出現局部回流
    type = INSFVVelocityVariable
    initial_condition = 0.0
    solver_sys = w_system
    two_term_boundary_expansion = false
    lower_bound = -5.0
    upper_bound = 5.0
  []
  [pressure]
    # 壓力場 [Pa]（錶壓）
    # 在 SIMPLE 演算法中扮演「調節器」角色：
    #   若某處 ∇⋅v ≠ 0（質量不守恆），求解器調整壓力修正速度，
    #   直到 ∇⋅v = 0 為止。這就是為什麼質量守恆方程式
    #   對應的變數是 pressure 而非速度。
    # 初始值 0.0：壓力以出口為參考點（錶壓），絕對值不影響流場
    type = INSFVPressureVariable
    initial_condition = 0.0
    scaling = 1e-4  # Gemini 建議：速度量級~1，壓力量級~1e5，差距導致 Jacobian 條件數爆炸
                    # scaling = 1e-4 讓壓力項縮放到與速度項同量級，Newton 迭代才能收斂
    solver_sys = pressure_system
    two_term_boundary_expansion = false
  []
  #[TKE] # 移除：Phase 1 不使用 k-ε
  #[TKED] # 移除：Phase 1 不使用 k-ε
  #[T_fluid] # Phase 1 停用能量方程式
[]

# ============================================================
# [AuxVariables]：輔助變數（非求解目標，從外部傳入或計算）
# ============================================================
# AuxVariables 和 Variables 的差異：
#   Variables：MOOSE 直接求解，有對應的方程式（kernel）
#   AuxVariables：不直接求解，由外部傳入或 AuxKernel 計算填值
#
# 這裡定義三個 AuxVariables：
#   power_density：從 OpenMC 傳入的核分裂功率密度
#   mu_t：由 kEpsilonViscosityAux 計算的湍流動黏度
#   yplus：由 RANSYPlusAux 計算的無因次壁面距離（網格品質指標）
[AuxVariables]
  [power_density]
    # 核分裂功率密度 q‴(r) [W/m³]
    # 這是 Cardinal 耦合的關鍵橋樑：
    #   OpenMC 計算中子通量 → 產生功率密度分布
    #   → 透過 MultiApp Transfer 填入此變數
    #   → 能量方程式的熱源項（energy_source kernel）使用它
    # 初始值為 0，等第一次 OpenMC 計算完成後才有非零值
    type = MooseVariableFVReal
    initial_condition = 0.0
  []
  [mixing_len]
    order = CONSTANT
    family = MONOMIAL
    fv = true
  []
  [mu_t]
  # 湍流動黏度 μt [Pa·s]
  #
  # ── 為什麼放在 AuxVariables 而非 FunctorMaterials？──────────────
  # 因為壁面函數（INSFVTurbulentViscosityWallFunction）需要
  # 直接修改近壁處的 μt 值——這只有 AuxVariable 才能做到。
  # FunctorMaterial 是唯讀的計算量，無法被邊界條件覆蓋。
  #
  # ── Phase 1 初始值選擇（Mixing Length 模型）────────────────────
  # 本檔案使用 Mixing Length 代數模型，非 k-ε 兩方程模型。
  #
  # 舊值 0.162 Pa·s（已棄用，版本一）：
  #   來自 k-ε 公式：μt = ρ × Cμ × k²/ε
  #   = 4147.3 × 0.09 × (5.26e-3)² / (6.4e-4) ≈ 0.162 Pa·s
  #   問題：k、ε 是 k-ε 模型專屬變數，
  #         在 Mixing Length 模型中沒有物理意義，不自洽。
  #
  # 舊值 0.56 Pa·s（已棄用，版本二）：
  #   來自 Re 數經驗關係：
  #     μt/μ ≈ 0.001 × Re^0.875 = 0.001 × 48000^0.875 ≈ 50
  #     μt = 50 × 0.01127 ≈ 0.56 Pa·s
  #   Re_eff = 48000 / (1 + 50) ≈ 940
  #   問題：測試結果（th_phase1_test1.log）顯示
  #         Momentum 殘差在 0.05～0.5 震盪，Pressure 在 1～1e-5 跳動，
  #         Re_eff = 940 仍在過渡區，SIMPLE 無法穩定收斂。
  #
  # 當前值 5.6 Pa·s（版本三）：
  #   策略：提高 μt 10 倍，強制降低 Re_eff 至接近層流區
  #     μt/μ = 5.6 / 0.01127 ≈ 497 ≈ 500 倍
  #     μ_eff = μ + μt = 0.01127 + 5.6 ≈ 5.61 Pa·s
  #     Re_eff = 48000 / (1 + 500) ≈ 96
  #   物理意義：人為將流體等效黏度提升 500 倍（類似濃糖漿），
  #             黏性力完全主導，SIMPLE 壓力修正量小且穩定。
  #   代價：初始收斂場與真實 MSFR 物理解距離較遠，
  #         後續開放 μt 動態更新時需要較大調整。
  #         但這是可接受的——Phase 1 目標只是讓流場「活起來」。
  #
  # ── μt 初始值選擇策略總表 ─────────────────────────────────────
  #   μt [Pa·s] │ μt/μ  │ Re_eff │ 收斂難度 │ 與真實解距離
  #   ──────────┼───────┼────────┼──────────┼─────────────
  #   0.162     │  14   │  3200  │ 困難     │ 最近（但模型不自洽）
  #   0.56      │  50   │   940  │ 中等     │ 近
  #   5.6       │ 500   │    96  │ 容易     │ 遠
  #
  # ── 為什麼初始值對 SIMPLE 收斂至關重要？──────────────────────
  # Stokes 熱啟動場速度 ≈ 0 → Mixing Length 算出 μt ≈ 0
  # → execute_on = 'INITIAL' 凍結住 initial_condition 的值
  # → 若 initial_condition 太小，Re_eff 仍高，SIMPLE 震盪發散
  #
  # ── 後續策略 ──────────────────────────────────────────────────
  # 目前 AuxKernel compute_mu_t 設 execute_on = 'INITIAL'
  # → μt 凍結在 5.6，不隨迭代更新（Phase 1 穩定優先）
  # 待 SIMPLE 收斂後，改回 execute_on = 'NONLINEAR'
  # → 開放動態更新，μt 回到真實物理值，進入 Phase 2 k-ε 熱啟動
  type = MooseVariableFVReal
  initial_condition = 5.6
  two_term_boundary_expansion = false
[]
#[yplus] # Phase 1 停用
[]

# ============================================================
# [AuxKernels]：輔助變數的計算方式
# ============================================================
# AuxVariables 只是「容器」，AuxKernels 才是「計算公式」。
# 每個 AuxKernel 對應一個 AuxVariable，告訴 MOOSE 怎麼填值。
#
# ── execute_on 執行時機說明 ──────────────────────────────────
# MOOSE 計算流程中有多個「時間點」可掛載 AuxKernel：
#
#   初始化 → [INITIAL] → 開始迭代 → [NONLINEAR] → ... → 收斂 → [TIMESTEP_END]
#
#   INITIAL     ：只在最開始執行一次，之後凍結不動
#   NONLINEAR   ：每次非線性迭代都重新計算（即時更新）
#   TIMESTEP_END：每個時間步結束才更新一次（精度較低）
#
# ── Phase 1 策略：compute_mu_t 改為 execute_on = 'INITIAL' ──
#
# 舊設定 execute_on = 'NONLINEAR'（已棄用於 Phase 1）：
#   問題：Stokes 熱啟動場速度 ≈ 0
#         → 第一次 NONLINEAR 迭代時速度梯度 ≈ 0
#         → INSFVMixingLengthTurbulentViscosityAux 算出 μt ≈ 0
#         → AuxVariables 中設定的 initial_condition = 0.56 被立即覆蓋
#         → 等效 Re_eff = 48000，SIMPLE 無阻尼震盪發散
#
# 新設定 execute_on = 'INITIAL'（當前使用）：
#   效果：μt 在初始化時算一次後凍結在 0.56 Pa·s
#         → Re_eff ≈ 940，SIMPLE 可穩定收斂
#   注意：mixing_length 仍保持 NONLINEAR，壁面距離場持續更新
#         但因 mu_t 凍結，mixing_length 的更新不影響 mu_t
#
# ── 後續策略 ────────────────────────────────────────────────
# 待 Phase 1 SIMPLE 收斂後：
#   將 compute_mu_t 改回 execute_on = 'NONLINEAR'
#   → μt 開始動態跟隨速度場更新，進入 Phase 2 k-ε 熱啟動
[AuxKernels]
  [mixing_length]
    type = WallDistanceMixingLengthAux
    variable = mixing_len
    walls = 'wall'
    von_karman_const = 0.41
    delta = 1.15
    execute_on = 'NONLINEAR'
  []
  [compute_mu_t]
    type = INSFVMixingLengthTurbulentViscosityAux
    variable = mu_t
    mixing_length = mixing_len
    u = vel_x
    v = vel_y
    w = vel_z
    # 舊值：NONLINEAR（第一步即覆蓋 initial_condition，μt 歸零）
    # 新值：INITIAL（凍結 μt = 0.56 Pa·s，提供 SIMPLE 數值阻尼）
    execute_on = 'INITIAL'
  []
  #[compute_yplus] # Phase 1 停用：無 k-ε
[]
# ============================================================
# [FunctorMaterials]：函子材料（提供 kernel 所需的材料屬性）
# ============================================================
# INSFVEnthalpyFunctorMaterial：
#   提供 rho_h（焓密度）functor，供 INSFVEnergyAdvection 使用
#   rho_h = ρ × cp × T（不可壓縮流的焓密度）
#
# 為什麼需要這個？
#   INSFVEnergyAdvection 預設對流量是 rho_h（焓密度），
#   而不是直接對流溫度 T。這樣才符合能量守恆的物理定義：
#   對流帶走的是焓（enthalpy），不是溫度本身。
[FunctorMaterials]
  #[enthalpy] # Phase 1 停用：無能量方程式不需要焓材料

  # ── 人工阻尼（Artificial Damping）────────────────────────────
  # 目的：防止 Sliver element 速度暴衝導致 SIMPLE 求解器崩潰
  #
  # 物理原理：
  #   SIMPLE 求解壓力修正時，分母含 A_diag（動量方程係數）
  #   當某 cell 速度暴衝 → 對流係數飆高 → A_diag → 0
  #   → A_inv → ∞ → 壓力修正量爆炸 → overflow 崩潰
  #
  # 解法：在動量方程右側加一個體積力 F_body
  #   當 |v| > 5.0 m/s：F_body = -1e5 × v（巨大反向阻力）
  #   當 |v| ≤ 5.0 m/s：F_body = 0（不干擾正常流場）
  #
  # 閾值選擇依據：
  #   入口速度 U_in = 1.1838 m/s
  #   爐心最大合理速度 ≈ 5.0 m/s（約 4.2 倍入口速度）
  #   超過此值視為非物理暴衝，立即施加阻力
  #
  # 注意：ParsedFunctorMaterial 每個 block 只能定義一個 property_name
  #   因此 x/y/z 三個分量必須分開定義為三個獨立 block
  #   這三個 functor 會在 [FVKernels] 的 INSFVBodyForce 中被引用

  [drag_force_x]
    type = ADParsedFunctorMaterial
    property_name = 'drag_force_x'
    # vel_mag：先計算速度大小，判斷是否超過閾值
    # 超過 5.0 m/s：回傳 -1e5 × vel_x（反向阻力）
    # 未超過：回傳 0（不施加任何力）
    expression = 'vel_mag := sqrt(vel_x^2 + vel_y^2 + vel_z^2); if(vel_mag > 5.0, -1e5 * vel_x, 0.0)'
    functor_names = 'vel_x vel_y vel_z'
    use_ad = true  # vel_x/y/z 是 AD 變數，必須用 AD 模式讀取，否則會丟失導數資訊導致 Jacobian 錯誤
  []
  [drag_force_y]
    type = ADParsedFunctorMaterial
    property_name = 'drag_force_y'
    expression = 'vel_mag := sqrt(vel_x^2 + vel_y^2 + vel_z^2); if(vel_mag > 5.0, -1e5 * vel_y, 0.0)'
    functor_names = 'vel_x vel_y vel_z'
    use_ad = true  # vel_x/y/z 是 AD 變數，必須用 AD 模式讀取，否則會丟失導數資訊導致 Jacobian 錯誤
  []
  [drag_force_z]
    type = ADParsedFunctorMaterial
    property_name = 'drag_force_z'
    expression = 'vel_mag := sqrt(vel_x^2 + vel_y^2 + vel_z^2); if(vel_mag > 5.0, -1e5 * vel_z, 0.0)'
    functor_names = 'vel_x vel_y vel_z'
    use_ad = true  # vel_x/y/z 是 AD 變數，必須用 AD 模式讀取，否則會丟失導數資訊導致 Jacobian 錯誤
  []
[]
# ============================================================
# [Executioner]：求解器設定
# ============================================================
# 使用 SIMPLE（Semi-Implicit Method for Pressure-Linked Equations）
# 演算法求解不可壓縮 N-S 方程式。
#
# SIMPLE 的求解順序（每次迭代）：
#   1. 用目前壓力場求解動量方程式 → 得到中間速度場 v*
#   2. 求解壓力修正方程式（Poisson）→ 得到壓力修正量 p'
#   3. 用 p' 修正速度場，使 ∇⋅v = 0（質量守恆）
#   4. 求解 TKE、TKED 方程式（湍流封閉）
#   5. 求解能量方程式（溫度場）
#   6. 檢查收斂，未收斂回第 1 步
#
# 為什麼用 SIMPLENonlinearAssembly 而非 Steady 或 Transient？
#   SIMPLE 是專門為不可壓縮流設計的分離式求解器，
#   把速度-壓力耦合問題拆成多個較小的線性系統，
#   比全耦合（monolithic）方法更節省記憶體，收斂更穩定。
#   ⚠️ 使用 SIMPLE 就不能有時間項 kernel（INSFVMomentumTimeDerivative
#      等），否則會報 "Vector tag TIME does not exist" 錯誤。
[Executioner]
  type = SIMPLENonlinearAssembly
  rhie_chow_user_object = 'rc'

  # 各方程式的求解系統對應（對應 [Problem] 的 nl_sys_names）
  momentum_systems = 'u_system v_system w_system'
  pressure_system = 'pressure_system'

  # 壓力梯度標籤（SIMPLE 內部用來傳遞壓力修正給 Rhie-Chow）
  pressure_gradient_tag = ${pressure_tag}

  # 鬆弛因子（relaxation factors）
  # 控制每次迭代的更新幅度，避免發散
  #
  # ── SIMPLE 鬆弛因子的耦合原理 ────────────────────────────────
  # SIMPLE 的速度修正：v_new = v* + αm × A_inv × ∇p'
  # SIMPLE 的壓力修正：p_new = p* + αp × p'
  #
  # αm 和 αp 必須滿足耦合一致性條件：αm + αp ≈ 1
  # 原因：
  #   αp 太小 → 壓力修正不足 → 質量誤差累積（∇·v ≠ 0）
  #   → 速度場在無壓力約束下自由發展
  #   → 局部速度出現非物理極端值
  #   → 對流項離散化出現數值問題
  #   → A_diag → 0 → A_inv → ∞ → overflow
  #
  #   兩者都壓低（αm=0.01, αp=0.01）時：
  #   速度和壓力完全脫節，誤差累積更快，反而更早崩潰。
  #
  # ── 標準值參考 ────────────────────────────────────────────────
  #   動量標準值：0.7（太大容易震盪，太小收斂慢）
  #   壓力標準值：0.3（通常比動量小以維持穩定）
  #   湍流標準值：0.2（k-ε 方程式非線性強，需保守）
  #   能量標準值：0.9（溫度方程式線性較好，可較大）
  #
  # ── 調試歷程 ──────────────────────────────────────────────────
  # Test 1~3（momentum=0.1, pressure=0.05, αm+αp=0.15）：
  #   iter ~15 overflow 崩潰
  #   Gemini 診斷：問題出在動量過衝導致 A_inv 爆炸
  #   崩潰路徑：速度過衝 → A_diag→0 → A_inv→∞ → p'→inf → overflow
  #
  # Test 4（LU 直接求解器診斷）：
  #   確認壓力求解器不是元兇（壓力殘差=0，LU未執行）
  #   仍然 overflow → 100% 確認是動量過衝問題
  #
  # Test 5（momentum=0.01, pressure=0.05, αm+αp=0.06）：
  #   重大進展：Momentum 從 0.05~0.5 降至 0.003~0.01（↓一個數量級）
  #   Pressure 下包絡線清楚下降（iter 11 達到 1e-8）
  #   但 iter 21 仍然 overflow
  #   問題：αm+αp=0.06，遠低於 1，壓力-速度耦合脫節
  #
  # Test 6（momentum=0.01, pressure=0.01, αm+αp=0.02）：
  #   比 Test 5 更早崩潰（iter 18 vs iter 21）
  #   確認：αp 更小 → 質量誤差累積更快 → 更早觸發 A_diag→0
  #   反直覺教訓：壓低鬆弛因子不等於穩定，耦合關係才是關鍵
  #
  # Test 7（momentum=0.5, pressure=0.3, αm+αp=0.8）：
  #   回歸合理耦合值，αm+αp≈1
  #   速度截斷（lower_bound/upper_bound）語法不支援（unused parameter）
  #   結果：Momentum 退步至 0.2~0.8，αm=0.5 太大速度每步更新過猛
  #   iter 15 overflow 崩潰
  #   教訓：αm+αp≈1 是必要條件但不是充分條件，
  #         αm 本身也不能太大，否則速度場每步變化太劇烈
  #
  # Test 8（當前）：momentum=0.01, pressure=0.05, αm+αp=0.06
  #   回到 Test 5 最佳鬆弛因子組合（Momentum 曾降至 0.003~0.01）
  #   搭配 Velocity Ramping（入口速度從 0.001 線性爬升到 1.1838）
  #   策略：用 Ramping 延緩流場成長速度，推遲觸發奇異點的時機
  #   αm+αp=0.06 雖然低於理想值 1，但在低速 Ramping 期間
  #   流場變化緩慢，壓力-速度脫節的風險相對較低
  momentum_equation_relaxation = 0.01
  pressure_variable_relaxation = 0.05

  # 最大迭代次數
  #
  # 舊值：1000（正常運行上限）
  #
  # Test 10（當前）：改為 14
  #   目的：Gemini「iter 14 攔截法」——在 iter 15 奇異點引爆前強制停止
  #   背景：Gemini 診斷 iter 15 是 MOOSE 內部保護機制解除的時間點
  #         不管 Ramping 如何設定，第 15 步必然引爆
  #         在第 14 步強制停止 → 觸發 Exodus 輸出 → 拿到崩潰前的流場快照
  #         → 丟進 ParaView 用 Threshold 濾鏡找出速度極大值位置
  #         → 定位奇異點網格
  num_iterations = 14

  # 收斂判斷：各方程式的絕對殘差容忍值
  # 1e-8 是工程計算的標準精度，可依需要調整
  pressure_absolute_tolerance = 1e-8
  momentum_absolute_tolerance = 1e-8

  # 線性求解器設定
  #
  # ── 預條件器選擇說明 ──────────────────────────────────────────
  # 預條件器的作用：改善線性系統的條件數，加速內層求解器收斂。
  #
  # 舊設定：hypre boomeramg（代數多重網格）
  #   優點：大型稀疏系統收斂快，適合生產計算
  #   缺點：依賴 MPI 分區（Domain Decomposition）
  #         A電腦 4 核 vs RTXWS 32 核，分區方式不同
  #         → 線性求解收斂路徑完全不同
  #         → 在系統臨界不穩定時，核心數差異可能決定
  #           是驚險過關還是直接發散
  #   另一缺點：Krylov 子空間（GMRES）的迭代誤差
  #             在外層 SIMPLE 不穩定時可能放大壓力修正過衝
  #
  # 新設定（Test 4）：LU 直接求解器
  #   原理：直接對矩陣做 LU 分解，不做近似迭代
  #   優點：完全排除預條件器和 Krylov 迭代誤差這個變數
  #         網格只有 35186 elements，4 核 RAM 撐得住
  #   目的：診斷用——若換 LU 後仍在 iter ~15 崩潰，
  #         則 100% 確認問題出在非線性動量過衝（A_inv 爆炸），
  #         而非壓力線性矩陣解不準。
  #
  # ── A_inv 爆炸的崩潰機制（Gemini 診斷）────────────────────────
  # SIMPLE 中壓力修正方程包含 ∇⋅(A_inv ∇p')
  # A_inv = 1 / A_diag（動量矩陣主對角線係數的倒數）
  # A_diag 包含對流項與擴散項的貢獻
  #
  # 崩潰路徑：
  #   速度過衝 → 局部對流係數飆高
  #   → A_diag → 0
  #   → A_inv → ∞
  #   → 壓力修正量 p' 被放大至無窮大
  #   → overflow：Current value inf > 1.79769e+308
  #
  # ── 預條件器設定 ───────────────────────────────────────────────
  #
  # Test 4 LU 診斷結果：
  #   壓力殘差全部為 0，'No iterations have been performed'
  #   說明 '-pc_type lu -ksp_type preonly' 語法在此版本
  #   MOOSE/PETSc 下壓力求解器未正確啟動
  #   LU 語法問題待後續修正，暫時換回 hypre
  #
  # Test 5（當前）：兩者都用 hypre boomeramg
  #   動量和壓力使用相同預條件器
  #   排除預條件器不一致造成的潛在問題
  #   真正的變數只有 momentum_equation_relaxation = 0.01
  momentum_petsc_options_iname = '-pc_type -pc_hypre_type'
  momentum_petsc_options_value = 'hypre boomeramg'
  pressure_petsc_options_iname = '-pc_type -pc_hypre_type'
  pressure_petsc_options_value = 'hypre boomeramg'

  # 線性求解器容忍值（內層迭代的收斂條件）
  #
  # ── 為什麼這兩個值很重要？────────────────────────────────────
  # SIMPLE 是雙層迭代：
  #   外層：SIMPLE 迭代（壓力-速度耦合）
  #   內層：線性求解器（每個方程式的矩陣求解）
  #
  # 舊值（已棄用）：
  #   momentum_l_tol = 0.0, momentum_l_abs_tol = 1e-14
  #   pressure_l_tol = 0.0, pressure_l_abs_tol = 1e-14
  #   問題：外層 SIMPLE 還在摸索方向時，
  #         內層線性求解器強迫每步達到機器精度，
  #         造成「對錯誤問題的精確解」→ 壓力修正過衝 → overflow
  #
  # 新值（當前使用）：
  #   放寬內層容忍值，讓線性求解器「夠好就好」，
  #   不需要每步都算到極致，避免過衝震盪。
  momentum_l_abs_tol = 1e-10
  pressure_l_abs_tol = 1e-10
  momentum_l_max_its = 30
  pressure_l_max_its = 30
  momentum_l_tol = 1e-6
  pressure_l_tol = 1e-6

  print_fields = false
[]

# ============================================================
# [FVKernels]：有限體積法方程式核心
# ============================================================
# 每個 kernel 對應方程式裡的一項（積木式組合）。
# 這是 MOOSE 框架設計哲學的核心：
#   「把每一項物理機制做成獨立 kernel，使用者自由組合。」
#
# 所有守恆定律的共同結構：
#   對流 = 擴散 + 源項
#   （帶走項）（傳遞項）（產生項）
#
# ⚠️ 時間項說明：
#   SIMPLE 穩態求解器不使用 Transient executioner，
#   因此所有時間項 kernel 已停用（加 # 註解）。
#   若未來改用 Transient 求解器，可取消對應的註解。
[FVKernels]

  # ----------------------------------------------------------
  # 1. 質量守恆方程式（SIMPLE 版本）
  # ----------------------------------------------------------
  # SIMPLE 不直接求解 ∇⋅v = 0，而是用「壓力修正」間接滿足：
  #   Step 1：用目前壓力求解動量 → 得到 v*（不一定滿足連續）
  #   Step 2：求解壓力修正方程式（Poisson）→ 得到 p'
  #   Step 3：用 p' 修正 v*，使 ∇⋅v = 0
  #
  # 壓力修正方程式：∇⋅(Ainv ∇p') = ∇⋅(HbyA)
  #   Ainv：動量矩陣對角線的倒數（Rhie-Chow 物件提供）
  #   HbyA：中間速度場（Rhie-Chow 物件提供）
  #
  # 需要兩個 kernel：
  #   FVAnisotropicDiffusion：左邊的 ∇⋅(Ainv ∇p') 項
  #   FVDivergence：右邊的 ∇⋅(HbyA) 源項

  [p_diffusion]
    # ∇⋅(Ainv ∇p')：壓力修正方程式的擴散項
    # Ainv 由 Rhie-Chow 物件在每次迭代時動態更新
    type = FVAnisotropicDiffusion
    variable = pressure
    coeff = "Ainv"
    coeff_interp_method = 'average'
  []
  [p_source]
    # ∇⋅(HbyA)：壓力修正方程式的源項
    # HbyA 是「幾乎滿足動量方程式但還不滿足連續方程式」的速度場
    # force_boundary_execution = true：確保邊界處也計算散度
    type = FVDivergence
    variable = pressure
    vector_field = "HbyA"
    force_boundary_execution = true
  []

  # ----------------------------------------------------------
  # 2. 動量守恆方程式（RANS N-S）
  # ----------------------------------------------------------
  # 完整形式（以 x 方向為例，SIMPLE 穩態，無時間項）：
  #   ρ v⋅∇vx = -∂p/∂x + ∇⋅[μ∇vx] + ∇⋅[μt∇vx] + ρgx
  #             （壓力項）（分子黏性）（湍流黏性）  （重力項）
  #
  # 為什麼分子黏度和湍流黏度分開寫成兩個 kernel？
  #   μ 是常數，μt 是空間變數（由 AuxKernel 計算）
  #   數值處理方式不同，分開寫讓 MOOSE 能各自最佳化
  #
  # complete_expansion = no（湍流黏度 kernel）：
  #   只計算主對角項（∂/∂xi(μt ∂vj/∂xi)），略去交叉項
  #   提升收斂穩定性，是 Tano et al. 範本的做法

  # ── x 方向動量 ──
  # [vel_x_time] # ⚠️ 已停用：SIMPLE 穩態求解器不使用時間項
  #   type = INSFVMomentumTimeDerivative
  #   variable = vel_x
  #   rho = ${rho}
  #   momentum_component = x
  # []
  [vel_x_advection]
    # ρ v⋅∇vx：流體移動將 x 方向動量從一處帶到另一處
    type = INSFVMomentumAdvection
    variable = vel_x
    rho = ${rho}
    momentum_component = x
  []
  [vel_x_diffusion]
    # ∇⋅[μ∇vx]：分子黏性擴散項
    type = INSFVMomentumDiffusion
    variable = vel_x
    mu = ${mu}
    momentum_component = x
  []
  [vel_x_diffusion_turbulent]
    # ∇⋅[μt∇vx]：湍流黏性擴散項
    type = INSFVMomentumDiffusion
    variable = vel_x
    mu = 'mu_t'
    momentum_component = x
    complete_expansion = no
    u = vel_x
    v = vel_y
    w = vel_z
  []
  [vel_x_pressure]
    # -∂p/∂x：壓力梯度驅動 x 方向流動
    # extra_vector_tags：標記壓力梯度貢獻，供 Rhie-Chow 修正使用
    type = INSFVMomentumPressure
    variable = vel_x
    momentum_component = x
    pressure = pressure
    extra_vector_tags = ${pressure_tag}
  []

  # ── y 方向動量 ──
  # [vel_y_time] # ⚠️ 已停用：SIMPLE 穩態求解器不使用時間項
  #   type = INSFVMomentumTimeDerivative
  #   variable = vel_y
  #   rho = ${rho}
  #   momentum_component = y
  # []
  [vel_y_advection]
    type = INSFVMomentumAdvection
    variable = vel_y
    rho = ${rho}
    momentum_component = y
  []
  [vel_y_diffusion]
    type = INSFVMomentumDiffusion
    variable = vel_y
    mu = ${mu}
    momentum_component = y
  []
  [vel_y_diffusion_turbulent]
    type = INSFVMomentumDiffusion
    variable = vel_y
    mu = 'mu_t'
    momentum_component = y
    complete_expansion = no
    u = vel_x
    v = vel_y
    w = vel_z
  []
  [vel_y_pressure]
    type = INSFVMomentumPressure
    variable = vel_y
    momentum_component = y
    pressure = pressure
    extra_vector_tags = ${pressure_tag}
  []

  # ── z 方向動量 ──
  # [vel_z_time] # ⚠️ 已停用：SIMPLE 穩態求解器不使用時間項
  #   type = INSFVMomentumTimeDerivative
  #   variable = vel_z
  #   rho = ${rho}
  #   momentum_component = z
  # []
  [vel_z_advection]
    type = INSFVMomentumAdvection
    variable = vel_z
    rho = ${rho}
    momentum_component = z
  []
  [vel_z_diffusion]
    # ∇⋅[μ∇vz]：分子黏性擴散項（z 方向）
    type = INSFVMomentumDiffusion
    variable = vel_z
    mu = ${mu}
    momentum_component = z
  []
  [vel_z_diffusion_turbulent]
    # ∇⋅[μt∇vz]：湍流黏性擴散項（z 方向）
    type = INSFVMomentumDiffusion
    variable = vel_z
    mu = 'mu_t'
    momentum_component = z
    complete_expansion = no
    u = vel_x
    v = vel_y
    w = vel_z
  []
  [vel_z_pressure]
    type = INSFVMomentumPressure
    variable = vel_z
    momentum_component = z
    pressure = pressure
    extra_vector_tags = ${pressure_tag}
  []
  [vel_z_gravity]
    # ρgz：重力體積力，只在 z 方向有效（垂直向下）
    # rho：直接傳入密度數值作為 functor
    type = INSFVMomentumGravity
    variable = vel_z
    momentum_component = z
    gravity = '0 0 -9.81'
    rho = ${rho}
  []

  # ----------------------------------------------------------
  # 3. 能量守恆方程式
  # ----------------------------------------------------------
  # 完整形式（SIMPLE 穩態，無時間項）：
  #   ρcp v⋅∇T = ∇⋅[k∇T] + q‴
  #   （對流項）  （擴散項）  （熱源項）
  #
  # 注意：左邊有 cp，右邊擴散項沒有 cp
  #   → T 是溫度，需要乘 cp 才能換算成熱量（Q = mcp ΔT）
  #   → k 是熱傳導係數（單位含能量 W/m·K），不需要 cp
  #
  # INSFVEnergyDiffusion 在此版本 MOOSE 不存在，
  # 改用通用的 FVDiffusion（coeff = 熱傳導係數 k）

  # [energy_time] # ⚠️ 已停用：SIMPLE 穩態求解器不使用時間項
  #   type = INSFVEnergyTimeDerivative
  # #   variable = T_fluid  # Phase 1 停用
  #   rho = ${rho}
  #   cp = ${cp}
  # []
  #[energy_advection] # Phase 1 停用
  #[energy_diffusion] # Phase 1 停用
  #[energy_source] # Phase 1 停用

  # ----------------------------------------------------------
  # 4. TKE 輸送方程式（k-ε 模型第一條）
  # ----------------------------------------------------------
  # 完整形式（SIMPLE 穩態，無時間項）：
  #   ρ v⋅∇k = ∇⋅[μ∇k] + ∇⋅[(μt/σk)∇k] + Pk - ρε
  #            （分子擴散） （湍流擴散）     （生成） （耗散）
  #
  # Pk = μt|∇v|²：速度梯度剪切產生湍流
  # ρε：黏性將湍流動能耗散為熱能
  # 平衡時 Pk = ρε：充分發展湍流狀態

  # [TKE_time] # ⚠️ 已停用：SIMPLE 穩態求解器不使用時間項
  #   type = INSFVEnergyTimeDerivative
  #   variable = TKE
  #   rho = ${rho}
  #   cp = 1.0
  # []
  #[TKE_advection] # Phase 1 停用
  #[TKE_diffusion] # Phase 1 停用
  #[TKE_diffusion_turbulent] # Phase 1 停用
  #[TKE_source] # Phase 1 停用

  # ----------------------------------------------------------
  # 5. TKED 輸送方程式（k-ε 模型第二條）
  # ----------------------------------------------------------
  # 完整形式（SIMPLE 穩態，無時間項）：
  #   ρ v⋅∇ε = ∇⋅[μ∇ε] + ∇⋅[(μt/σε)∇ε] + C1(ε/k)Pk - C2ρε²/k
  #            （分子擴散） （湍流擴散）     （生成項）    （耗散項）
  #
  # Standard k-ε 模型的經驗常數：
  #   C1 = 1.44（生成項係數）
  #   C2 = 1.92（耗散項係數）
  #   σε = 1.3（TKED 擴散的湍流普朗特數，比 σk=1.0 稍大）
  #
  # ⚠️ 注意 TKED 源項分母含 k：
  #   C2ρε²/k → k→0 時源項趨向無限大，求解器爆掉
  #   這就是 TKE 初始值不能為零的原因

  # [TKED_time] # ⚠️ 已停用：SIMPLE 穩態求解器不使用時間項
  #   type = INSFVEnergyTimeDerivative
  #   variable = TKED
  #   rho = ${rho}
  #   cp = 1.0
  # []
  #[TKED_advection] # Phase 1 停用
  #[TKED_diffusion] # Phase 1 停用
  #[TKED_diffusion_turbulent] # Phase 1 停用
  #[TKED_source] # Phase 1 停用
  # ── 人工阻尼 Body Force ──────────────────────────────────────
  # 把 FunctorMaterials 定義的 drag_force 施加到動量方程右側
  # 當 |v| > 5.0 m/s 時，INSFVBodyForce 在動量求解步加入反向阻力
  # 防止 Sliver element 暴衝導致 A_diag → 0 → overflow
  [rubber_wall_x]
    type = INSFVBodyForce
    variable = vel_x
    functor = drag_force_x
    rhie_chow_user_object = 'rc'
    momentum_component = 'x'
  []
  [rubber_wall_y]
    type = INSFVBodyForce
    variable = vel_y
    functor = drag_force_y
    rhie_chow_user_object = 'rc'
    momentum_component = 'y'
  []
  [rubber_wall_z]
    type = INSFVBodyForce
    variable = vel_z
    functor = drag_force_z
    rhie_chow_user_object = 'rc'
    momentum_component = 'z'
  []
[]
# ============================================================
# [Functions]：定義隨迭代變化的函數
# ============================================================
# PiecewiseLinear：線性插值函數
#   x：迭代步（SIMPLE 用 time 代表迭代次數）
#   y：對應的入口速度值
#
# Velocity Ramping 策略：
#   讓入口速度從極小值慢慢爬升到目標值
#   目的：避免流場成長過快觸發局部奇異點
#   從 0.001 而非 0 開始：提供最小驅動力，
#   防止壓力修正方程式在靜止場下出現數值奇異
[Functions]
  [ramped_vel_z]
    type = PiecewiseLinear
    x = '0   200'
    y = '0.001 1.1838'
  []
[]
# ============================================================
# [FVBCs]：有限體積法邊界條件
# ============================================================
# MSFR 流場的三類邊界：
#   入口（gap_enter_boundary）：指定速度、溫度、湍流量
#   出口（gap_exit_boundary） ：指定壓力（讓速度自由發展）
#   壁面（wall）              ：無滑移 + 壁面函數（近壁湍流處理）
#
# 為什麼入口指定速度、出口指定壓力？
#   N-S 方程式的數學性質決定的：
#   入口需要知道「東西從哪裡來、帶多少動量」→ 給速度
#   出口需要「壓力參考點」讓 SIMPLE 演算法收斂 → 給 p=0（錶壓）
#   兩端都給速度 → 方程式超定（overdetermined），求解器無法收斂
#
# 為什麼壁面速度用 FVDirichletBC 而非 INSFVNoSlipWallBC？
#   INSFVNoSlipWallBC 是為耦合壁面設計的（需要額外的壁面物件）
#   FVDirichletBC 直接強制邊界值 = 0，更適合 k-ε 壁面函數的搭配
#   來源：Tano et al. channel_ERCOFTAC.i（Dr. Tano 本人的範本）
[FVBCs]

  # ----------------------------------------------------------
  # 1. 入口邊界（gap_enter_boundary）
  # ----------------------------------------------------------
  # 燃料鹽從底部 16 個冷卻通道截斷面流入爐心
  # 流向：+z 方向（向上），x、y 方向速度為零
  # 入口條件：速度、溫度、TKE、TKED 全部用 Dirichlet 強制指定

  [inlet_vel_x]
    # x 方向速度為零（純垂直流入，無橫向分量）
    type = INSFVInletVelocityBC
    variable = vel_x
    boundary = 'gap_enter_boundary'
    functor = 0.0
  []
  [inlet_vel_y]
    # y 方向速度為零
    type = INSFVInletVelocityBC
    variable = vel_y
    boundary = 'gap_enter_boundary'
    functor = 0.0
  []
  [inlet_vel_z]
    # 入口平均流速估算：
    #   總熱功率 P = 3000 MW
    #   Q = P / (ρ cp ΔT) = 3e9 / (4147 × 1525 × 100) ≈ 4.77 m³/s
    #   16 個通道截面積 A ≈ 0.322 m²（⚠️ 待確認實際通道尺寸）
    #   U_in = Q/A ≈ 1.1838 m/s，+z 方向（向上）
    #
    # ── Velocity Ramping（Test 8 新增）────────────────────────
    # 舊值：functor = 1.1838（固定速度）
    #   問題：流場從 Stokes 靜止場一步跳到全速，
    #         對流項在 iter 15~21 成長到臨界強度後觸發局部奇異點
    #         → A_diag → 0 → A_inv → ∞ → overflow
    #
    # 新值：functor = ramped_vel_z（線性爬升函數）
    #   入口速度從 0.001 m/s 線性爬升到 1.1838 m/s（200 iter）
    #   為什麼從 0.001 而非 0：
    #     完全靜止場（v=0）下 SIMPLE 壓力修正方程式無驅動力，
    #     可能出現除以零或壓力無法收斂的數值奇異
    #     0.001 m/s 提供最小物理驅動力，讓求解器有「東西可以算」
    #   治標策略：讓流場用更小的步伐成長，
    #     推遲觸發奇異點的時間，降低衝擊強度
    #   為什麼治標就夠：
    #     Phase 1 目標只是讓流場「活起來」，不需要完美物理解
    #     Phase 2 遇到的奇異點性質完全不同（真實物理湍流問題），
    #     現在的數值人工奇異點屆時不會再出現
    type = INSFVInletVelocityBC
    variable = vel_z
    boundary = 'gap_enter_boundary'
    functor = ramped_vel_z
  []
  #[inlet_T] # Phase 1 停用
  #[inlet_TKE] # Phase 1 停用
  #[inlet_TKED] # Phase 1 停用

  # ----------------------------------------------------------
  # 2. 出口邊界（gap_exit_boundary）
  # ----------------------------------------------------------
  # 壓力設為 0（錶壓參考點）
  # 速度、溫度、TKE、TKED：不設邊界條件
  #   → MOOSE FV 預設為 zero-gradient（充分發展假設）
  #   → 出去的東西自然流出，不強制改變

  [outlet_pressure]
    # p = 0 作為整個流場的壓力參考點（錶壓）
    # ⚠️ 不代表實際絕對壓力，只是讓 SIMPLE 有收斂基準
    type = INSFVOutletPressureBC
    variable = pressure
    boundary = 'gap_exit_boundary'
    functor = 0.0                 # [Pa]，錶壓
  []

  # ----------------------------------------------------------
  # 3. 壁面邊界（wall）
  # ----------------------------------------------------------
  # 球形爐心外壁：燃料鹽與結構材料的介面
  # 無滑移條件：壁面處流體速度 = 0
  #
  # 為什麼不對 TKE、TKED 設壁面邊界條件？
  #   壁面函數（INSFVTurbulentViscosityWallFunction）作用在 mu_t，
  #   透過 log-law 間接控制近壁的湍流行為，
  #   不需要對 TKE/TKED 直接設定壁面值。

  [wall_vel_x]
    type = FVDirichletBC
    variable = vel_x
    boundary = 'wall'
    value = 0.0
  []
  [wall_vel_y]
    type = FVDirichletBC
    variable = vel_y
    boundary = 'wall'
    value = 0.0
  []
  [wall_vel_z]
    type = FVDirichletBC
    variable = vel_z
    boundary = 'wall'
    value = 0.0
  []
#   [wall_mu_t]
#     # 壁面函數：用 log-law 計算近壁的湍流黏度 μt
#     # log-law：u⁺ = (1/κ)ln(y⁺) + B，κ=0.41（von Kármán 常數）
#     #
#     # wall_treatment = 'eq_newton'：
#     #   eq = equilibrium（假設近壁生成 ≈ 耗散，Pk ≈ ρε）
#     #   newton = 用 Newton 迭代求解摩擦速度 u_τ（最精確）
#     #   這是 Tano et al. channel_ERCOFTAC.i 範本使用的設定
#     #
#     # variable = mu_t（不是 TKE 或 TKED）：
#     #   壁面函數覆蓋近壁處的 μt 值，讓它符合 log-law
#     type = INSFVTurbulentViscosityWallFunction
#     variable = mu_t
#     boundary = 'wall'
#     u = vel_x
#     v = vel_y
#     w = vel_z
#     rho = ${rho}
#     mu = ${mu}
#     mu_t = 'mu_t'
#     wall_treatment = 'eq_newton'
#   []
[]
# ← 這個是 [FVBCs] 的關閉括號
# ============================================================
# [Postprocessors]：監控量（每步輸出到終端和 CSV）
# ============================================================
# 目的：監控每次 SIMPLE 迭代的速度極值
#   當 Momentum 暴衝時，找出哪個分量最先失控
#   以及速度最大值出現在哪個位置（間接定位奇異點）
#
# Gemini 建議：速度極值監控是定位「觸發暴衝的局部位置」的關鍵
#   若 max_vel_z 在某 iter 從 0.13 突然跳到 1000，
#   表示 z 方向動量在入口附近失控
[Postprocessors]
  [max_vel_x]
    type = ElementExtremeValue
    variable = vel_x
    value_type = max
    # 舊值：NONLINEAR（每次非線性迭代執行，但崩潰前無法輸出到表格）
    # 新值：TIMESTEP_END（每次 SIMPLE 迭代結束後輸出一次）
    # 原因：SIMPLE 把每次迭代當作一個「timestep」
    #   NONLINEAR 的結果不會即時寫入 log 表格，
    #   系統在第一個 timestep 內崩潰 → 只有 time=0 的初始值
    #   TIMESTEP_END 確保每個 SIMPLE iter 結束後都輸出一行數據
    #   → 可以看到 iter 1~23 每步的速度極值變化
    #   → 定位 iter 15 暴衝時哪個方向速度最先失控
    execute_on = 'TIMESTEP_END'
  []
  [max_vel_y]
    type = ElementExtremeValue
    variable = vel_y
    value_type = max
    # 同 max_vel_x，改為 TIMESTEP_END 確保每 iter 輸出
    execute_on = 'TIMESTEP_END'
  []
  [max_vel_z]
    type = ElementExtremeValue
    variable = vel_z
    value_type = max
    # 同 max_vel_x，改為 TIMESTEP_END 確保每 iter 輸出
    # 主流方向（z），最可能在 iter 15 出現異常極大值
    execute_on = 'TIMESTEP_END'
  []
  [min_vel_z]
    # 監控最小值：如果 min_vel_z 出現極大負值，
    # 代表某處有強烈的回流或速度方向反轉（奇異點訊號）
    #
    # 舊值：NONLINEAR → 崩潰前無法輸出
    # 新值：TIMESTEP_END → 每 iter 輸出，可追蹤回流發展過程
    type = ElementExtremeValue
    variable = vel_z
    value_type = min
    execute_on = 'TIMESTEP_END'
  []
[]
# ============================================================
# [Outputs]：輸出設定
# ============================================================
# Test 10 新增：配合 iter 14 攔截法輸出流場快照
# execute_on = 'FINAL'：在計算結束時（iter 14）輸出 Exodus 檔
# 輸出檔供 ParaView 視覺化，定位奇異點位置
[Outputs]
  [exodus_out]
    type = Exodus
    execute_on = 'FINAL'
  []
[]
