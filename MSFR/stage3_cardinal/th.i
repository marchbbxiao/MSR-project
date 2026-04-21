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
# 燃料鹽物性（來源：Rouch et al. 2014，ANL Cardinal tutorial）
# ------------------------------------------------------------
rho = 4147.3        # 密度 [kg/m³]
mu = 0.011266321    # 動力黏度 [Pa·s]
cp = 1524.86        # 比熱容 [J/kg/K]，將溫度變化換算為熱量的橋樑（Q = mcp ΔT）
k = 1.0             # 熱傳導係數 [W/m·K]（暫用，待確認正確值）

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
# 注意：AuxVariables（如 power_density）不是求解目標，
#       而是從外部傳入的輔助量。
[Variables]
  [vel_x]
    type = INSFVVelocityVariable  # 有限體積法速度變數
    initial_condition = 0.0       # 初始速度為零（靜止起始）
  []
  [vel_y]
    type = INSFVVelocityVariable
    initial_condition = 0.0
  []
  [vel_z]
    type = INSFVVelocityVariable
    initial_condition = 0.0
  []
  [pressure]
    # 壓力在 SIMPLE 演算法中扮演「調節器」角色：
    # 若某處 ∇⋅v ≠ 0（質量不守恆），求解器調整壓力修正速度，
    # 直到 ∇⋅v = 0 為止。這就是為什麼質量守恆方程式
    # 對應的變數是 pressure 而非速度。
    type = INSFVPressureVariable
    initial_condition = 0.0
  []
  [TKE]
    # TKE（Turbulent Kinetic Energy，湍流動能）[m²/s² = J/kg]
    # 描述湍流的「激烈程度」，即速度擾動 v' 的動能：
    # k = (1/2)(v'x² + v'y² + v'z²)
    # 初始值用湍流強度公式估算：TKE = 1.5*(u*I)²
    #   u = 1.1838 m/s（平均流速），I = 0.01（1% 湍流強度）
    # ⚠️ 不能設為 0.0：TKED 方程式分母含 k，k=0 會造成除以零
    type = INSFVEnergyVariable
    initial_condition = 2.102e-4  # [m²/s²]
  []
  [TKED]
    # TKED（Turbulent Kinetic Energy Dissipation，湍流動能耗散率）[m²/s³]
    # 描述湍流消退的速率：大渦旋→小渦旋→分子熱能的能量耗散過程
    # 初始值估算：TKED = Cμ^0.75 * TKE^1.5 / L
    #   Cμ = 0.09，L = 1.1 m（爐心半徑）
    # ⚠️ 不能設為 0.0：μt = Cμ*k²/ε，ε=0 會造成除以零
    type = INSFVEnergyVariable
    initial_condition = 4.55e-7   # [m²/s³]
  []
  [T_fluid]
    # 燃料鹽溫度場 [K]
    # 初始值設為入口溫度 898K（燃料鹽進入爐心的溫度）
    # 目標平均溫度：936K（Tano et al. 2025 設計點）
    type = INSFVEnergyVariable
    initial_condition = 898.0     # [K]，入口溫度
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
  [mass]
    type = INSFVMassAdvection
    variable = pressure           # 用壓力作為調節器強制滿足 ∇⋅v=0
    advected_interp_method = average  # 網格面的值取相鄰中心的算術平均
    velocity_interp_method = rc   # Rhie-Chow 插值：消除同位網格的
                                  # 棋盤格壓力振盪（checkerboard instability）
    rho = ${rho}                  # 即使 ρ 是常數，kernel 內部矩陣組裝仍需要它
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
    advected_interp_method = average
    velocity_interp_method = rc
    rho = ${rho}
    momentum_component = x
  []
  [vel_x_diffusion]
    # ∇⋅[μ∇vx]：分子黏性將動量從快速流體傳遞到慢速流體
    # ⚠️ 應為 (μ+μt)，待補入湍流黏度修正
    type = INSFVMomentumDiffusion
    variable = vel_x
    mu = ${mu}
    momentum_component = x
  []
  [vel_x_pressure]
    # -∂p/∂x：壓力梯度驅動流體從高壓流向低壓
    # 這是壓力能修正速度的原因（SIMPLE 演算法的核心）
    type = INSFVMomentumPressure
    variable = vel_x
    momentum_component = x
    pressure = pressure
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
    velocity_interp_method = rc
    rho = ${rho}
    momentum_component = y
  []
  [vel_y_diffusion]
    type = INSFVMomentumDiffusion
    variable = vel_y
    mu = ${mu}
    momentum_component = y
  []
  [vel_y_pressure]
    type = INSFVMomentumPressure
    variable = vel_y
    momentum_component = y
    pressure = pressure
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
    velocity_interp_method = rc
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
  [vel_z_pressure]
    type = INSFVMomentumPressure
    variable = vel_z
    momentum_component = z
    pressure = pressure
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
    advected_interp_method = average
    velocity_interp_method = rc
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
    advected_interp_method = average
    velocity_interp_method = rc
  []
  [TKE_diffusion]
    # ∇⋅[(μ + μt/σk)∇k]：TKE 透過黏性擴散
    # sigma = σk = 1.0（Standard k-ε 經驗常數）
    #   物理意義：TKE 的湍流擴散效率與動量湍流擴散效率相同
    #   此值從大量實驗數據擬合得出
    type = INSFVTurbulentDiffusion
    variable = TKE
    coeff = ${mu}
    sigma = 1.0
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
    advected_interp_method = average
    velocity_interp_method = rc
  []
  [TKED_diffusion]
    # sigma = σε = 1.3（Standard k-ε 經驗常數）
    #   物理意義：TKED 的擴散效率比動量稍慢（1.3 > 1.0）
    #   代表耗散率的擴散受到更多阻礙
    type = INSFVTurbulentDiffusion
    variable = TKED
    coeff = ${mu}
    sigma = 1.3
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
[]
