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
[Variables]
  [vel_x]
    # x 方向速度分量 [m/s]
    # 對應動量方程式 x 分量：ρ Dvx/Dt = -∂p/∂x + ∇⋅[(μ+μt)∇vx]
    # 初始速度為零（靜止起始），SIMPLE 迭代過程中逐漸建立流場
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
  # ── 標準值參考 ────────────────────────────────────────────────
  #   動量標準值：0.7（太大容易震盪，太小收斂慢）
  #   壓力標準值：0.3（通常比動量小以維持穩定）
  #   湍流標準值：0.2（k-ε 方程式非線性強，需保守）
  #   能量標準值：0.9（溫度方程式線性較好，可較大）
  #
  # ── 調試歷程 ──────────────────────────────────────────────────
  # Test 1~3（momentum=0.1, pressure=0.05）：
  #   iter ~15 overflow 崩潰
  #   Gemini 診斷：問題出在動量過衝導致 A_inv 爆炸
  #   崩潰路徑：速度過衝 → A_diag→0 → A_inv→∞ → p'→inf → overflow
  #
  # Test 4（LU 直接求解器診斷）：
  #   確認壓力求解器不是元兇（壓力殘差=0，LU未執行）
  #   仍然 overflow → 100% 確認是動量過衝問題
  #
  # Test 5（momentum=0.01, pressure=0.05）：
  #   重大進展：Momentum 從 0.05~0.5 降至 0.003~0.01（↓一個數量級）
  #   Pressure 下包絡線清楚下降（iter 11 達到 1e-8）
  #   但 iter 11 壓力修正過大 → iter 12 Momentum 反彈至 0.04
  #   → iter 21 仍然 overflow
  #   診斷：overflow 元兇已從動量轉移到壓力修正過衝
  #   壓力鬆弛因子 0.05 仍然太大，需要進一步壓低
  #
  # Test 6（當前）：momentum=0.01, pressure=0.01
  #   目的：同時壓制壓力修正幅度，防止壓力低谷後反彈打爆速度場
  #   物理邏輯：
  #     pressure_variable_relaxation 控制每步壓力更新量：
  #     p_new = p_old + α_p × p'
  #     α_p 越小 → 壓力每步走得越小 → 不容易過衝
  #   代價：收斂步數增加，但穩定性提升
  momentum_equation_relaxation = 0.01
  pressure_variable_relaxation = 0.01

  # 最大迭代次數
  num_iterations = 1000

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
    type = INSFVInletVelocityBC
    variable = vel_z
    boundary = 'gap_enter_boundary'
    functor = 1.1838              # [m/s]
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
