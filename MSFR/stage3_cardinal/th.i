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
# SIMPLE 求解器需要的壓力梯度標籤
pressure_tag = "pressure_grad"
# 燃料鹽物性（來源：Rouch et al. 2014，ANL Cardinal tutorial）
# ------------------------------------------------------------
rho = 4147.3        # 密度 [kg/m³]
mu = 0.011266321    # 動力黏度 [Pa·s]
cp = 1524.86        # 比熱容 [J/kg/K]，將溫度變化換算為熱量的橋樑（Q = mcp ΔT）
k = 1.0             # 熱傳導係數 [W/m·K]（暫用，待確認正確值）
# ============================================================
# [GlobalParams]：全域參數（所有 kernel 共用）
# ============================================================
# 把重複出現的參數集中在這裡，避免每個 kernel 都要寫一遍
# rhie_chow_user_object：Rhie-Chow 插值物件，消除壓力棋盤格振盪
# advected_interp_method：對流項的面插值方法
# velocity_interp_method：速度的面插值方法（rc = Rhie-Chow）
[GlobalParams]
  rhie_chow_user_object = 'rc'
  advected_interp_method = 'upwind'
  velocity_interp_method = 'rc'
[]

# ============================================================
# [Problem]：求解系統定義
# ============================================================
# SIMPLE 分離式求解器需要把每個方程式分配到獨立的求解系統
# 這樣才能分別控制每個方程式的鬆弛因子和收斂條件
[Problem]
  nl_sys_names = 'u_system v_system w_system pressure_system TKE_system TKED_system energy_system'
  previous_nl_solution_required = true
[]

# ============================================================
# [UserObjects]：Rhie-Chow 插值物件
# ============================================================
# INSFVRhieChowInterpolatorSegregated：
#   SIMPLE 分離式求解器專用的 Rhie-Chow 插值
#   作用：在同位網格（collocated grid）上消除壓力棋盤格振盪
#   同位網格：速度和壓力存在同一個網格中心（非交錯網格）
#   棋盤格問題：若不處理，壓力場會出現鋸齒狀振盪
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
# [GlobalParams]：全域參數（所有 kernel 自動繼承）
# ============================================================
# 把重複出現的參數集中在這裡，避免每個 kernel 都要寫一遍。
# 任何 kernel 只要有這些參數名稱，就會自動套用這裡的值。
#
# rhie_chow_user_object：
#   指向下方 [UserObjects] 定義的 Rhie-Chow 插值物件
#   所有速度、壓力相關 kernel 都需要它
#
# advected_interp_method = 'upwind'：
#   對流項的面插值方法
#   upwind（一階迎風）：穩定性好，適合強對流的湍流問題
#   average（中央差分）：精度較高但容易振盪，不適合高 Re 流
#
# velocity_interp_method = 'rc'：
#   速度的面插值用 Rhie-Chow（rc）方法
#   目的：消除同位網格的壓力棋盤格振盪
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
[Problem]
  nl_sys_names = 'u_system v_system w_system pressure_system TKE_system TKED_system energy_system'
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
# msr_with_sidesets.e 是由 add_sidesets.py 用 Cubit Python API
# 從原始 msr.e 產生的，包含：
#   - gap_exit_boundary（上方截斷面，Z > 0）：燃料鹽流出口
#   - gap_enter_boundary（下方截斷面，Z < 0）：燃料鹽流入口
# 格式：Exodus II（.e），由 Cubit 產生
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
# 與之前的差異：每個變數加了兩個新參數：
#   solver_sys：指定這個變數屬於哪個求解系統
#     SIMPLE 分離式求解器把每個方程式拆成獨立系統，
#     分別控制鬆弛因子和收斂條件，避免強耦合造成發散
#   two_term_boundary_expansion = false：
#     關閉邊界處的二階外插，提升近壁區域的數值穩定性
#     k-ε 模型在壁面附近梯度很大，高階外插容易產生振盪
#
# 注意：AuxVariables（如 power_density、mu_t）不是求解目標，
#       而是從外部傳入或由 AuxKernel 計算的輔助量，不需要 solver_sys
[Variables]
  [vel_x]
    # x 方向速度分量 [m/s]
    # 對應動量方程式 x 分量：ρ Dvx/Dt = -∂p/∂x + ∇⋅[(μ+μt)∇vx]
    # 初始速度為零（靜止起始），SIMPLE 迭代過程中逐漸建立流場
    # solver_sys = u_system：x 動量方程式獨立求解系統
    type = INSFVVelocityVariable
    initial_condition = 0.0
    solver_sys = u_system
    two_term_boundary_expansion = false
  []
  [vel_y]
    # y 方向速度分量 [m/s]
    # MSFR 是球形對稱爐心，主流方向為 z，
    # x、y 方向速度由湍流和幾何不對稱產生，初始為零
    type = INSFVVelocityVariable
    initial_condition = 0.0
    solver_sys = v_system
    two_term_boundary_expansion = false
  []
  [vel_z]
    # z 方向速度分量 [m/s]，主流方向（向上）
    # 初始為零，入口邊界條件（1.1838 m/s）會驅動流場建立
    type = INSFVVelocityVariable
    initial_condition = 0.0
    solver_sys = w_system
    two_term_boundary_expansion = false
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
    solver_sys = pressure_system
    two_term_boundary_expansion = false
  []
  [TKE]
    # 湍流動能 k [m²/s²]
    # 描述湍流的「激烈程度」：k = (1/2)(vx'² + vy'² + vz'²)
    # 初始值估算：k = 1.5×(I×U)²
    #   I = 0.01（1% 湍流強度），U = 1.1838 m/s
    #   k = 1.5×(0.01×1.1838)² = 2.102×10⁻⁴ m²/s²
    # ⚠️ 不能設為 0.0：
    #   TKED 源項分母含 k（C2ρε²/k），k=0 → 除以零 → 求解器爆掉
    type = INSFVEnergyVariable
    initial_condition = 2.102e-4
    solver_sys = TKE_system
    two_term_boundary_expansion = false
  []
  [TKED]
    # 湍流動能耗散率 ε [m²/s³]
    # 描述湍流消退的速率：大渦旋→小渦旋→分子熱能
    # 初始值估算：ε = Cμ^0.75 × k^1.5 / L
    #   Cμ = 0.09，L = 1.1 m（爐心半徑）
    #   ε = 0.09^0.75 × (2.102e-4)^1.5 / 1.1 = 4.55×10⁻⁷ m²/s³
    # ⚠️ 不能設為 0.0：
    #   μt = Cμ×k²/ε，ε=0 → μt 無限大 → 數值發散
    type = INSFVEnergyVariable
    initial_condition = 4.55e-7
    solver_sys = TKED_system
    two_term_boundary_expansion = false
  []
  [T_fluid]
    # 燃料鹽溫度場 [K]
    # 初始值設為入口溫度 898 K（燃料鹽進入爐心的溫度）
    # 目標：OpenMC 功率密度驅動下，平均溫度升至 936 K（Tano et al. 2025）
    # 溫度場的建立依賴 power_density（AuxVariable），
    # 第一次迭代 power_density=0，溫度場暫時不變，
    # 等 OpenMC 傳入功率密度後才開始升溫
    type = INSFVEnergyVariable
    initial_condition = 898.0
    solver_sys = energy_system
    two_term_boundary_expansion = false
  []
[]

# ============================================================
# [AuxVariables]：輔助變數（非求解目標，從外部傳入或計算）
# ============================================================
[AuxVariables]
  [power_density]
    # 核分裂功率密度 q‴(r) [W/m³]
    # 這是 Cardinal 耦合的關鍵橋樑：
    #   OpenMC 計算中子通量 → 產生功率密度分布
    #   → 透過 MultiApp Transfer 填入此變數
    #   → 能量方程式的熱源項使用它
    # 初始值為 0，等第一次 OpenMC 計算完成後才有非零值
    type = MooseVariableFVReal
    initial_condition = 0.0
  []
  [mu_t]
    # 湍流動黏度 μt [Pa·s]
    # 這是 k-ε 模型的核心輸出量：μt = Cμ × k²/ε
    #   Cμ = 0.09（Standard k-ε 經驗常數）
    #   k = TKE（湍流動能），ε = TKED（湍流耗散率）
    #
    # 為什麼放在 AuxVariables 而非 FunctorMaterials？
    #   因為壁面函數（INSFVTurbulentViscosityWallFunction）需要
    #   直接修改近壁處的 μt 值——這只有 AuxVariable 才能做到。
    #   FunctorMaterial 是唯讀的計算量，無法被邊界條件覆蓋。
    #
    # 初始值：μt = ρ × Cμ × k²/ε
    #   = 4147.3 × 0.09 × (5.26e-3)² / (6.4e-4)
    #   ≈ 1.62×10⁻¹ Pa·s（約為分子黏度 μ=0.011 的 15 倍）
    #   湍流黏度遠大於分子黏度，這正是湍流增強動量傳遞的體現
    type = MooseVariableFVReal
    initial_condition = 0.162
    two_term_boundary_expansion = false
  []

  [yplus]
    # 無因次壁面距離 y⁺ [-]
    # 定義：y⁺ = u_τ × y / ν
    #   u_τ = √(τ_w/ρ)（摩擦速度），y = 距壁面距離，ν = 運動黏度
    #
    # y⁺ 是判斷網格品質的關鍵指標：
    #   y⁺ < 5   ：黏性底層（viscous sublayer），需要極細網格
    #   y⁺ = 5~30：過渡區（buffer layer），避免第一層落在這裡
    #   y⁺ = 30~300：對數律區（log-law region），壁面函數的有效範圍
    #
    # 用途：計算完成後檢查 y⁺ 分布，確認網格是否符合壁面函數假設
    #       若 y⁺ < 30，需要加密壁面附近網格
    type = MooseVariableFVReal
    two_term_boundary_expansion = false
  []
[]


# ============================================================
# [AuxKernels]：輔助變數的計算方式
# ============================================================
# AuxVariables 只是「容器」，AuxKernels 才是「計算公式」。
# 每個 AuxKernel 對應一個 AuxVariable，告訴 MOOSE 怎麼填值。
#
# 執行時機：execute_on = 'NONLINEAR'
#   每次非線性迭代時重新計算，確保 μt 和 y⁺ 隨速度場即時更新
#   若設 'TIMESTEP_END' 則每個時間步才更新一次（精度較低）
[AuxKernels]

  [compute_mu_t]
    # 計算湍流動黏度：μt = Cμ × k²/ε
    # kEpsilonViscosityAux 是 MOOSE Navier-Stokes 模組內建的 kernel，
    # 專門為 k-ε 模型設計，包含壁面函數的近壁修正邏輯：
    #   爐心內部：μt = ρ × Cμ × k²/ε（標準公式）
    #   近壁處  ：μt 由壁面函數覆蓋（log-law 決定）
    #
    # 這個 μt 之後會被 [FVKernels] 的擴散項使用：
    #   動量擴散：∇·[(μ + μt)∇v]
    #   TKE 擴散：∇·[(μ + μt/σk)∇k]
    #   TKED 擴散：∇·[(μ + μt/σε)∇ε]
    type = kEpsilonViscosityAux
    variable = mu_t
    C_mu = 0.09
    k = TKE
    epsilon = TKED
    mu = ${mu}
    rho = ${rho}
    u = vel_x
    v = vel_y
    w = vel_z
    bulk_wall_treatment = false
    walls = 'wall'
    wall_treatment = 'eq_newton'
    execute_on = 'NONLINEAR'
  []

  [compute_yplus]
    # 計算無因次壁面距離 y⁺，用於事後檢查網格品質
    # RANSYPlusAux 從速度場和湍流量反推摩擦速度 u_τ，
    # 再算出每個網格中心到壁面的 y⁺ 值
    #
    # 計算完成後在 Paraview 裡觀察 yplus 分布：
    #   若大部分 y⁺ 在 30~300 → 壁面函數有效，網格品質合格
    #   若 y⁺ < 30 → 壁面網格太細，壁面函數假設失效
    #   若 y⁺ > 300 → 壁面網格太粗，log-law 不適用
    type = RANSYPlusAux
    variable = yplus
    k = TKE
    mu = ${mu}
    rho = ${rho}
    u = vel_x
    v = vel_y
    w = vel_z
    walls = 'wall'
    wall_treatment = 'eq_newton'
    execute_on = 'NONLINEAR'
  []
[]
# ============================================================
# [Executioner]：求解器設定
# ============================================================
# 使用 SIMPLE（Semi-Implicit Method for Pressure-Linked Equations）
# 演算法求解不可壓縮 N-S 方程式。
#
# SIMPLE 的求解順序：
#   1. 用目前壓力場求解動量方程式 → 得到中間速度場 v*
#   2. 求解壓力修正方程式 → 得到壓力修正量 p'
#   3. 用 p' 修正速度場，使 ∇⋅v = 0（質量守恆）
#   4. 求解 TKE、TKED 方程式（湍流封閉）
#   5. 求解能量方程式（溫度場）
#   6. 檢查收斂，未收斂回第 1 步
#
# 為什麼用 SIMPLENonlinearAssembly 而非 Steady 或 Transient？
#   SIMPLE 是專門為不可壓縮流設計的分離式求解器，
#   把速度-壓力耦合問題拆成多個較小的線性系統，
#   比全耦合（monolithic）方法更節省記憶體，收斂更穩定
[Executioner]
  type = SIMPLENonlinearAssembly
  rhie_chow_user_object = 'rc'

  # 各方程式的求解系統對應
  momentum_systems = 'u_system v_system w_system'
  pressure_system = 'pressure_system'
  turbulence_systems = 'TKE_system TKED_system'
  energy_system = 'energy_system'

  # 壓力梯度標籤（SIMPLE 內部用來傳遞壓力修正）
  pressure_gradient_tag = ${pressure_tag}

  # 鬆弛因子（relaxation factors）
  # 控制每次迭代的更新幅度，避免發散
  #   動量：0.7（標準值，太大容易震盪，太小收斂慢）
  #   壓力：0.3（標準值，通常比動量小）
  #   湍流：0.2（比動量更保守，k-ε 方程式非線性強）
  #   能量：0.9（溫度方程式線性較好，可以較大）
  momentum_equation_relaxation = 0.7
  pressure_variable_relaxation = 0.3
  turbulence_equation_relaxation = '0.2 0.2'
  energy_equation_relaxation = 0.9

  # 最大迭代次數
  num_iterations = 1000

  # 收斂判斷：各方程式的絕對殘差容忍值
  pressure_absolute_tolerance = 1e-8
  momentum_absolute_tolerance = 1e-8
  turbulence_absolute_tolerance = '1e-8 1e-8'
  energy_absolute_tolerance = 1e-8

  # 線性求解器設定（每個非線性迭代內部的線性系統）
  # hypre boomeramg：代數多重網格預條件子，適合大型稀疏系統
  momentum_petsc_options_iname = '-pc_type -pc_hypre_type'
  momentum_petsc_options_value = 'hypre boomeramg'
  pressure_petsc_options_iname = '-pc_type -pc_hypre_type'
  pressure_petsc_options_value = 'hypre boomeramg'
  turbulence_petsc_options_iname = '-pc_type -pc_hypre_type'
  turbulence_petsc_options_value = 'hypre boomeramg'
  energy_petsc_options_iname = '-pc_type -pc_hypre_type'
  energy_petsc_options_value = 'hypre boomeramg'

  # 線性求解器容忍值
  momentum_l_abs_tol = 1e-14
  pressure_l_abs_tol = 1e-14
  turbulence_l_abs_tol = 1e-14
  energy_l_abs_tol = 1e-14
  momentum_l_max_its = 30
  pressure_l_max_its = 30
  momentum_l_tol = 0.0
  pressure_l_tol = 0.0
  turbulence_l_tol = 0.0
  energy_l_tol = 0.0

  print_fields = false
[]
# ============================================================
# [FVKernels]：有限體積法方程式核心
# ============================================================
# 每個 kernel 對應方程式裡的一項（積木式組合）。
# 這是 MOOSE 框架設計哲學的核心：
#   「把每一項物理機制做成獨立 kernel，使用者自由組合。」
# 好處：可以逐步加入物理機制，逐步驗證收斂。
#
# 所有守恆定律的共同結構：
#   變化率 + 對流 = 擴散 + 源項
#   （時間項）（帶走項）（傳遞項）（產生項）
[FVKernels]

  # ----------------------------------------------------------
  # 1. 質量守恆方程式
  # ----------------------------------------------------------
  # 原始形式：∂ρ/∂t + ∇⋅(ρv) = 0
  # 不可壓縮流（ρ=常數，∂ρ/∂t=0）化簡為：∇⋅v = 0
  # 物理意義：流進控制體積的質量 = 流出的質量，無質量憑空產生
  # ----------------------------------------------------------
  # 1. 質量守恆方程式（SIMPLE 分離式求解器版本）
  # ----------------------------------------------------------
  # SIMPLE 不直接求解 ∇⋅v = 0，而是用「壓力修正」間接滿足：
  #   Step 1：用目前壓力求解動量 → 得到 v*（不一定滿足連續）
  #   Step 2：求解壓力修正方程式（Poisson 方程）→ 得到 p'
  #   Step 3：用 p' 修正 v*，使 ∇⋅v = 0
  #
  # 壓力修正方程式的形式：
  #   ∇⋅(Ainv ∇p') = ∇⋅(HbyA)
  #   Ainv：動量矩陣對角線的倒數（由 Rhie-Chow 物件提供）
  #   HbyA：中間速度場（由 Rhie-Chow 物件提供）
  #
  # 因此需要兩個 kernel 取代原來的 INSFVMassAdvection：
  #   FVAnisotropicDiffusion：處理左邊的 ∇⋅(Ainv ∇p') 項
  #   FVDivergence：處理右邊的 ∇⋅(HbyA) 項（源項）

  [p_diffusion]
    # ∇⋅(Ainv ∇p')：壓力修正方程式的擴散項
    # Ainv 由 Rhie-Chow 插值物件在每次迭代時動態更新
    # coeff_interp_method = 'average'：Ainv 在網格面用算術平均插值
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
  # 完整形式（以 x 方向為例）：
  #   ρ ∂vx/∂t + ρ v⋅∇vx = -∂p/∂x + ∇⋅[(μ+μt)∇vx] + ρgx
  #   （時間項）（對流項）  （壓力項）（黏性擴散項）       （重力項）
  #
  # 為什麼 μ → (μ+μt)？
  #   RANS 時間平均後，湍流擾動產生 Reynolds stress，
  #   用湍流黏度 μt = Cμ*k²/ε 來模擬（Boussinesq 假設）
  # ⚠️ 目前 diffusion kernel 只用 μ（分子黏度），
  #    μt 的修正待 [FunctorMaterials] 的 total_viscosity 完成後補入

  # ── x 方向動量 ──
  [vel_x_time]
    # ρ ∂vx/∂t：x 方向動量隨時間的變化率（慣性項）
    # 穩態時理論上為零，但 SIMPLE 迭代過程中需要它
    type = INSFVMomentumTimeDerivative
    variable = vel_x
    rho = ${rho}
    momentum_component = x
  []
  [vel_x_advection]
    # ρ v⋅∇vx：流體移動將 x 方向動量從一處帶到另一處
    # 非線性項（速度×速度梯度），是 N-S 數值求解困難的主因
    type = INSFVMomentumAdvection
    variable = vel_x
    
    
    rho = ${rho}
    momentum_component = x
  []
  [vel_x_diffusion]
    # ∇⋅[μ∇vx]：分子黏性擴散項
    # 只含分子黏度 μ，湍流黏度 μt 由下方獨立 kernel 處理
    # 分開寫的原因：μ 是常數，μt 是空間變數，數值處理方式不同
    type = INSFVMomentumDiffusion
    variable = vel_x
    mu = ${mu}
    momentum_component = x
  []
  [vel_x_diffusion_turbulent]
    # ∇⋅[μt∇vx]：湍流黏性擴散項
    # μt = Cμ×k²/ε，由 AuxKernel kEpsilonViscosityAux 計算
    # complete_expansion = no：只計算主對角項，提升收斂穩定性
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
    # extra_vector_tags：把壓力梯度貢獻標記起來，
    #   讓 SIMPLE 演算法可以單獨提取壓力項用於 Rhie-Chow 修正
    type = INSFVMomentumPressure
    variable = vel_x
    momentum_component = x
    pressure = pressure
    extra_vector_tags = ${pressure_tag}
  []
  # ── y 方向動量 ──
  [vel_y_time]
    type = INSFVMomentumTimeDerivative
    variable = vel_y
    rho = ${rho}
    momentum_component = y
  []
  [vel_y_advection]
    type = INSFVMomentumAdvection
    variable = vel_y
    advected_interp_method = average
    
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
  [vel_z_time]
    type = INSFVMomentumTimeDerivative
    variable = vel_z
    rho = ${rho}
    momentum_component = z
  []
  [vel_z_advection]
    type = INSFVMomentumAdvection
    variable = vel_z
    advected_interp_method = average
    
    rho = ${rho}
    momentum_component = z
  []
  [vel_z_diffusion]
    # ⚠️ 同上，應為 (μ+μt)，待補入湍流黏度修正
    type = INSFVMomentumDiffusion
    variable = vel_z
    mu = ${mu}
    momentum_component = z
  []
  [vel_z_diffusion_turbulent]
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
    # MSFR 是球形爐心，z 軸為垂直方向
    # x、y 方向無重力分量，不需要此 kernel
    type = INSFVMomentumGravity
    variable = vel_z
    momentum_component = z
    gravity = '0 0 -9.81'         # [m/s²]，負號表示 -z 方向（向下）
  []

  # ----------------------------------------------------------
  # 3. 能量守恆方程式
  # ----------------------------------------------------------
  # 完整形式：
  #   ρcp ∂T/∂t + ρcp v⋅∇T = ∇⋅[(k+kt)∇T] + q‴
  #   （時間項）   （對流項）   （擴散項）       （熱源項）
  #
  # 注意：左邊有 cp，右邊擴散項沒有 cp
  #   → 因為 T 是溫度，需要乘 cp 才能換算成熱量（Q = mcp ΔT）
  #   → 右邊的 k 已經是熱傳導係數（單位含能量），不需要 cp
  #
  # 熱傳機制對應：
  #   對流項 → Advection（流體移動帶走熱量）
  #   擴散項 → 熱傳導（Conduction，溫度梯度驅動）
  #   注意：熱傳學的 Heat Convection（q=hAΔT）是邊界條件，
  #         在 [FVBCs] 定義，不在這裡

  [energy_time]
    # ρcp ∂T/∂t：單位體積熱量隨時間的變化率
    type = INSFVEnergyTimeDerivative
    variable = T_fluid
    rho = ${rho}
    cp = ${cp}                    # 溫度→熱量的換算係數
  []
  [energy_advection]
    # ρcp v⋅∇T：燃料鹽流動將熱量從一處帶到另一處（Advection）
    # 例如：熔鹽從爐心底部流到頂部，順便把熱量帶走
    type = INSFVEnergyAdvection
    variable = T_fluid
    
    
    rho = ${rho}
    cp = ${cp}
  []
  [energy_diffusion]
    # ∇⋅[(k+kt)∇T]：熱量從高溫傳向低溫（熱傳導）
    # kt = cp*μt/Prt（湍流熱傳導係數）
    #   湍流渦旋像「攪拌」一樣增強熱傳效率，Prt ≈ 0.9
    # ⚠️ 目前只用分子熱傳導係數 k，湍流增強效果待後續補入
    type = INSFVEnergyDiffusion
    variable = T_fluid
    cp = ${cp}
    k = ${k}
  []
  [energy_source]
    # q‴(r)：核分裂功率密度，由 OpenMC 計算後傳入
    # power_density 是 AuxVariable，透過 Cardinal MultiApp Transfer
    # 從 neutronics.i 傳遞過來，這裡直接引用它作為熱源
    type = INSFVBodyForce
    variable = T_fluid
    value = power_density
  []

  # ----------------------------------------------------------
  # 4. TKE 輸送方程式（k-ε 模型第一條）
  # ----------------------------------------------------------
  # 完整形式：
  #   ρ ∂k/∂t + ρ v⋅∇k = ∇⋅[(μ + μt/σk)∇k] + Pk - ρε
  #   （時間項）（對流項）  （擴散項）             （生成項）（耗散項）
  #
  # 與能量方程式結構相同，差異在：
  #   1. 沒有 cp（k 單位已是 J/kg，本身就是能量）
  #   2. 擴散用黏度（不是熱傳導係數）
  #   3. 源項 = 生成(Pk) - 耗散(ρε)，而非外部輸入
  #
  # Pk = μt|∇v|²：速度梯度剪切產生湍流
  # ρε：黏性將湍流動能耗散為熱能
  # 平衡時 Pk = ρε：充分發展湍流狀態

  [TKE_time]
    # ρ ∂k/∂t：TKE 隨時間的變化率
    # cp = 1.0：此 kernel 原為能量方程式設計，含 cp 參數；
    #           TKE 不需要 cp 換算，傳入 1.0 將其「關掉」
    type = WCNSFVTurbulentEnergyTimeDerivative
    variable = TKE
    rho = ${rho}
    cp = 1.0
  []
  [TKE_advection]
    # ρ v⋅∇k：流場將 TKE 從一處輸送到另一處
    type = INSFVTurbulentAdvection
    variable = TKE
    rho = ${rho}
    
    
  []
  [TKE_diffusion]
    # ∇⋅[μ∇k]：TKE 分子黏性擴散項
    type = INSFVTurbulentDiffusion
    variable = TKE
    coeff = ${mu}
  []
  [TKE_diffusion_turbulent]
    # ∇⋅[(μt/σk)∇k]：TKE 湍流擴散項
    # σk = 1.0（Standard k-ε 經驗常數）
    #   物理意義：TKE 的湍流擴散效率與動量湍流擴散效率相同
    #   此值從大量實驗數據擬合得出
    # scaling_coef = σk：kernel 內部計算 μt/σk
    type = INSFVTurbulentDiffusion
    variable = TKE
    coeff = 'mu_t'
    scaling_coef = 1.0
  []
  [TKE_source]
    # Pk - ρε：TKE 的源項
    #   Pk（生成）：速度梯度剪切產生湍流，需要 mu_t
    #   ρε（耗散）：湍流被黏性磨掉，需要 epsilon（TKED）
    # mu_t = 'mu_t'：湍流黏度，由 [FunctorMaterials] 計算
    #   μt = Cμ * k²/ε，Cμ = 0.09
    # 注意：TKE 和 TKED 互相依賴（k 用到 ε，ε 用到 k），
    #       這就是為什麼需要兩條方程式聯立求解
    type = INSFVTKESourceSink
    variable = TKE
    u = vel_x
    v = vel_y
    w = vel_z
    rho = ${rho}
    mu = ${mu}
    mu_t = 'mu_t'
    epsilon = TKED
  []

  # ----------------------------------------------------------
  # 5. TKED 輸送方程式（k-ε 模型第二條）
  # ----------------------------------------------------------
  # 完整形式：
  #   ρ ∂ε/∂t + ρ v⋅∇ε = ∇⋅[(μ + μt/σε)∇ε] + C1(ε/k)Pk - C2ρε²/k
  #   （時間項）（對流項）  （擴散項）              （生成項）    （耗散項）
  #
  # 與 TKE 方程式結構完全相同，差異只在源項的係數：
  #   C1 = 1.44（生成項係數）
  #   C2 = 1.92（耗散項係數）
  #   σε = 1.3（TKED 擴散的湍流普朗特數）
  # 這些都是 Standard k-ε 模型的經驗常數
  #
  # ⚠️ 注意 TKED 源項分母含 k：
  #   C2ρε²/k → k→0 時源項趨向無限大，求解器爆掉
  #   這就是 TKE 初始值不能為零的另一個原因

  [TKED_time]
    type = WCNSFVTurbulentEnergyTimeDerivative
    variable = TKED
    rho = ${rho}
    cp = 1.0                      # 同 TKE，傳入 1.0 關掉 cp 換算
  []
  [TKED_advection]
    type = INSFVTurbulentAdvection
    variable = TKED
    rho = ${rho}
    
    
  []
  [TKED_diffusion]
    # ∇⋅[μ∇ε]：TKED 分子黏性擴散項
    type = INSFVTurbulentDiffusion
    variable = TKED
    coeff = ${mu}
  []
  [TKED_diffusion_turbulent]
    # ∇⋅[(μt/σε)∇ε]：TKED 湍流擴散項
    # σε = 1.3（Standard k-ε 經驗常數）
    #   物理意義：TKED 的擴散效率比動量稍慢（1.3 > 1.0）
    #   代表耗散率的擴散受到更多阻礙
    type = INSFVTurbulentDiffusion
    variable = TKED
    coeff = 'mu_t'
    scaling_coef = 1.3
  []
  [TKED_source]
    # C1(ε/k)Pk - C2ρε²/k：TKED 的源項
    #   生成項：C1(ε/k)Pk，比例於 TKE 生成率
    #   耗散項：C2ρε²/k，自我加速耗散
    type = INSFVTKEDSourceSink
    variable = TKED
    u = vel_x
    v = vel_y
    w = vel_z
    rho = ${rho}
    mu = ${mu}
    mu_t = 'mu_t'
    epsilon = TKED
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
#   FVDirichletBC 直接強制邊界值 = 0，更適合簡單無滑移條件
#   來源：Tano et al. channel_ERCOFTAC.i（Dr. Tano 本人的範本）
[FVBCs]

  # ----------------------------------------------------------
  # 1. 入口邊界（gap_enter_boundary）
  # ----------------------------------------------------------
  # 燃料鹽從底部 16 個冷卻通道截斷面流入爐心
  # 流向：+z 方向（向上），x、y 方向速度為零
  # 入口條件：速度、溫度、TKE、TKED 全部用 Dirichlet 強制指定
  # 這是「已知進來什麼」的邊界，不讓求解器自由決定

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
    #   16 個通道截面積 A ≈ 0.322 m²（待確認實際通道尺寸）
    #   U_in = Q/A ≈ 1.1838 m/s，+z 方向（向上）
    type = INSFVInletVelocityBC
    variable = vel_z
    boundary = 'gap_enter_boundary'
    functor = 1.1838              # [m/s]
  []

  [inlet_T]
    # 入口溫度固定為 898 K（燃料鹽進入爐心前的溫度）
    # 目標：燃料鹽流過爐心後平均溫度升至 936 K（ΔT ≈ 38 K）
    # 注意：這裡用 FVDirichletBC（直接給值），
    #       不用 INSFVScalarFieldAdvectionBC（那是對流出口用的）
    type = FVDirichletBC
    variable = T_fluid
    boundary = 'gap_enter_boundary'
    value = 898.0                 # [K]
  []

  [inlet_TKE]
    # 入口 TKE 估算：k = 1.5 × (I × U_in)²
    #   湍流強度 I = 5%（一般工程湍流的典型值）
    #   k = 1.5 × (0.05 × 1.1838)² = 5.26×10⁻³ m²/s²
    # 物理意義：進入爐心時的湍流「激烈程度」
    type = FVDirichletBC
    variable = TKE
    boundary = 'gap_enter_boundary'
    value = 5.26e-3               # [m²/s²]
  []
  [inlet_TKED]
    # 入口 TKED 估算：ε = Cμ^0.75 × k^1.5 / L
    #   Cμ = 0.09，L = 水力直徑 ≈ 0.1 m（待確認）
    #   ε = 0.09^0.75 × (5.26e-3)^1.5 / 0.1 = 6.4×10⁻⁴ m²/s³
    # 此公式假設入口已達充分發展湍流（生成 ≈ 耗散的平衡狀態）
    type = FVDirichletBC
    variable = TKED
    boundary = 'gap_enter_boundary'
    value = 6.4e-4                # [m²/s³]
  []

  # ----------------------------------------------------------
  # 2. 出口邊界（gap_exit_boundary）
  # ----------------------------------------------------------
  # 壓力設為 0（錶壓參考點）
  # 速度、溫度、TKE、TKED：不設邊界條件
  #   → MOOSE FV 預設為 zero-gradient（充分發展假設）
  #   → 意思是「出去的東西就讓它自然流出，不強制改變它」
  # 這符合 MSFR 出口的物理假設：
  #   燃料鹽流出截斷面時已充分發展，梯度趨近於零

  [outlet_pressure]
    # p = 0 作為整個流場的壓力參考點（錶壓）
    # ⚠️ 不代表實際絕對壓力，只是讓 SIMPLE 有收斂基準
    # SIMPLE 演算法靠壓力修正速度場，必須有至少一個固定壓力點
    type = INSFVOutletPressureBC
    variable = pressure
    boundary = 'gap_exit_boundary'
    functor = 0.0                 # [Pa]，錶壓
  []

  # ----------------------------------------------------------
  # 3. 壁面邊界（wall）
  # ----------------------------------------------------------
  # 球形爐心外壁：燃料鹽與結構材料的介面
  # 無滑移條件：壁面處流體速度 = 0（流體黏在壁面上不動）
  #
  # 為什麼不對 TKE、TKED 設壁面邊界條件？
  #   真實壁面附近有「黏性底層」（y⁺ < 5），湍流被強烈抑制
  #   要直接解析需要極細網格（y⁺ ≈ 1）→ 計算量爆炸
  #   解法：用「壁面函數」橋接黏性底層，
  #         讓第一個網格點可以放在 y⁺ = 30~300（對數律區）
  #   壁面函數作用在 mu_t（湍流黏度），而不是直接作用在 TKE/TKED
  #   → 所以 TKE、TKED 在壁面不設 BC，由壁面函數間接控制

  [wall_vel_x]
    # 壁面無滑移：x 方向速度 = 0
    # 用 FVDirichletBC（直接強制值），不用 INSFVNoSlipWallBC
    # 原因：FVDirichletBC 更適合 k-ε 壁面函數的搭配方式
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

  [wall_mu_t]
    # 壁面函數：用 log-law 計算近壁的湍流黏度 μt
    # log-law：u⁺ = (1/κ)ln(y⁺) + B，κ=0.41（von Kármán 常數）
    #
    # wall_treatment = 'eq_newton'：
    #   eq = equilibrium（假設近壁生成 ≈ 耗散，Pk ≈ ρε）
    #   newton = 用 Newton 迭代求解 u_τ（摩擦速度）
    #   這是 Tano et al. 範本使用的設定，精度與穩定性最佳
    #
    # 注意：variable = mu_t（不是 TKE 或 TKED）
    #   mu_t 是 AuxVariable，在 [AuxKernels] 由 kEpsilonViscosityAux
    #   從 TKE、TKED 計算得出：μt = Cμ × k²/ε
    #   壁面函數覆蓋近壁處的 μt 值，讓它符合 log-law
    type = INSFVTurbulentViscosityWallFunction
    variable = mu_t
    boundary = 'wall'
    u = vel_x
    v = vel_y
    w = vel_z
    rho = ${rho}
    mu = ${mu}
    mu_t = 'mu_t'
    k = TKE
    wall_treatment = 'eq_newton'
  []
[]
[]
