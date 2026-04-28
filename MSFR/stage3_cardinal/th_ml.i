# ============================================================
# th_ml.i：Phase 1 橋接版本——Mixing Length 湍流模型
# ============================================================
# 目的：用代數湍流模型（無 k/ε 方程式）建立健康的對流速度場
# 啟動：從 th_stokes_checkpoint_cp/0001 熱啟動（乾淨的 Stokes 解）
# 策略：Mixing Length 無除以零風險，無壁面函數奇異性
# 成功後：把此結果作為 th_transient.i（k-ε）的初始條件
# ============================================================

# 物性參數（燃料鹽 LiF-ThF4-UF4，T=898K）
rho = 4147.3      # 密度 [kg/m³]
mu  = 0.011266    # 動力黏度 [Pa·s]
bulk_u = 0.130    # 入口平均流速 [m/s]

advected_interp_method = 'upwind'
velocity_interp_method = 'rc'

[GlobalParams]
  rhie_chow_user_object = 'rc'
[]

[UserObjects]
  [rc]
    type = INSFVRhieChowInterpolator
    u = vel_x
    v = vel_y
    w = vel_z
    pressure = pressure
  []
[]

[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = msr_with_sidesets.e
  []
[]

[Problem]
  type = FEProblem
  # 浮點雜訊的負黏度(-5.8e-11)不應觸發 abort，直接忽略
  solution_invalidity_behavior = 'ignore'
  # 從 Stokes 乾淨解熱啟動（速度場已收斂，無 k/ε 污染）
  allow_initial_conditions_with_restart = true
  restart_file_base = 'th_stokes_checkpoint_cp/0001'
[]

[Variables]
  [vel_x]
    type = INSFVVelocityVariable
    # 從 Stokes 解熱啟動：已有合理速度場，壁面函數不會對零速度發散
    initial_from_file_var = vel_x
    two_term_boundary_expansion = false
  []
  [vel_y]
    type = INSFVVelocityVariable
    initial_from_file_var = vel_y
    two_term_boundary_expansion = false
  []
  [vel_z]
    type = INSFVVelocityVariable
    initial_from_file_var = vel_z
    two_term_boundary_expansion = false
  []
  [pressure]
    type = INSFVPressureVariable
    # 壓力冷啟動：避開 SIMPLE 壓力場不相容問題
    initial_condition = 0.0
    two_term_boundary_expansion = false
  []
[]

[AuxVariables]
  [mixing_len]
    # Mixing Length 長度尺度：由 WallDistanceMixingLengthAux 計算
    # l = κ·y（κ=0.41，y=壁面距離），代替 k-ε 的兩個方程式
    order = CONSTANT
    family = MONOMIAL
    fv = true
  []
  [mu_t]
    # 湍流動黏度：μt = ρ·l²·|S|，由 INSFVMixingLengthTurbulentViscosityAux 計算
    # 不需要 k 和 ε，不可能產生負值或除以零
    order = CONSTANT
    family = MONOMIAL
    fv = true
  []
[]

[AuxKernels]
  [mixing_length]
    # 計算壁面距離混合長度 l = min(κ·y, δ)
    # δ=1.15m（爐心半徑），防止爐心中央 l 無限增大
    type = WallDistanceMixingLengthAux
    variable = mixing_len
    walls = 'wall'
    von_karman_const = 0.41
    delta = 1.15
    execute_on = 'initial'
  []
  [turbulent_viscosity]
    # 計算 μt = ρ·l²·|S|，l 從 mixing_len 讀取
    type = INSFVMixingLengthTurbulentViscosityAux
    variable = mu_t
    mixing_length = mixing_len
    u = vel_x
    v = vel_y
    w = vel_z
  []
[]

[FVKernels]
  # ── 質量守恆（連續方程式）──
  [mass]
    type = INSFVMassAdvection
    variable = pressure
    advected_interp_method = ${advected_interp_method}
    velocity_interp_method = ${velocity_interp_method}
    rho = ${rho}
  []

  # ── x 動量 ──
  [u_time]
    type = INSFVMomentumTimeDerivative
    variable = vel_x
    rho = ${rho}
    momentum_component = 'x'
  []
  [u_advection]
    type = INSFVMomentumAdvection
    variable = vel_x
    advected_interp_method = ${advected_interp_method}
    velocity_interp_method = ${velocity_interp_method}
    rho = ${rho}
    momentum_component = 'x'
  []
  [u_viscosity]
    # 分子黏度擴散項
    type = INSFVMomentumDiffusion
    variable = vel_x
    mu = ${mu}
    momentum_component = 'x'
  []
  [u_viscosity_rans]
    # 湍流擴散：用 AuxKernel 計算好的 mu_t 作為係數
    # 避免 INSFVMixingLengthReynoldsStress 的 AD sqrt(0) 奇異性
    type = INSFVMomentumDiffusion
    variable = vel_x
    mu = mu_t_safe
    momentum_component = 'x'
  []
  [u_pressure]
    type = INSFVMomentumPressure
    variable = vel_x
    momentum_component = 'x'
    pressure = pressure
  []
  [u_gravity]
    type = INSFVBodyForce
    variable = vel_x
    functor = ${fparse -rho * 0.0}
    momentum_component = 'x'
  []

  # ── y 動量 ──
  [v_time]
    type = INSFVMomentumTimeDerivative
    variable = vel_y
    rho = ${rho}
    momentum_component = 'y'
  []
  [v_advection]
    type = INSFVMomentumAdvection
    variable = vel_y
    advected_interp_method = ${advected_interp_method}
    velocity_interp_method = ${velocity_interp_method}
    rho = ${rho}
    momentum_component = 'y'
  []
  [v_viscosity]
    type = INSFVMomentumDiffusion
    variable = vel_y
    mu = ${mu}
    momentum_component = 'y'
  []
  [v_viscosity_rans]
    type = INSFVMomentumDiffusion
    variable = vel_y
    mu = mu_t_safe
    momentum_component = 'y'
  []
  [v_pressure]
    type = INSFVMomentumPressure
    variable = vel_y
    momentum_component = 'y'
    pressure = pressure
  []

  # ── z 動量（主流方向，含重力）──
  [w_time]
    type = INSFVMomentumTimeDerivative
    variable = vel_z
    rho = ${rho}
    momentum_component = 'z'
  []
  [w_advection]
    type = INSFVMomentumAdvection
    variable = vel_z
    advected_interp_method = ${advected_interp_method}
    velocity_interp_method = ${velocity_interp_method}
    rho = ${rho}
    momentum_component = 'z'
  []
  [w_viscosity]
    type = INSFVMomentumDiffusion
    variable = vel_z
    mu = ${mu}
    momentum_component = 'z'
  []
  [w_viscosity_rans]
    type = INSFVMomentumDiffusion
    variable = vel_z
    mu = mu_t_safe
    momentum_component = 'z'
  []
  [w_pressure]
    type = INSFVMomentumPressure
    variable = vel_z
    momentum_component = 'z'
    pressure = pressure
  []
  [w_gravity]
    # 重力項：z 方向向下 g = -9.81 m/s²
    type = INSFVBodyForce
    variable = vel_z
    functor = ${fparse -rho * 9.81}
    momentum_component = 'z'
  []
[]

[FVBCs]
  # 入口（gap_enter_boundary）：z 方向速度 0.130 m/s
  [inlet_vx]
    type = INSFVInletVelocityBC
    boundary = 'gap_enter_boundary'
    variable = vel_x
    functor = '0'
  []
  [inlet_vy]
    type = INSFVInletVelocityBC
    boundary = 'gap_enter_boundary'
    variable = vel_y
    functor = '0'
  []
  [inlet_vz]
    type = INSFVInletVelocityBC
    boundary = 'gap_enter_boundary'
    variable = vel_z
    functor = '${bulk_u}'
  []

  # 出口（gap_exit_boundary）：壓力 = 0
  [outlet_p]
    type = INSFVOutletPressureBC
    boundary = 'gap_exit_boundary'
    variable = pressure
    functor = '0'
  []

  # 壁面：no-slip（速度=0）
  [wall_vx]
    type = INSFVNoSlipWallBC
    boundary = 'wall'
    variable = vel_x
    function = '0'
  []
  [wall_vy]
    type = INSFVNoSlipWallBC
    boundary = 'wall'
    variable = vel_y
    function = '0'
  []
  [wall_vz]
    type = INSFVNoSlipWallBC
    boundary = 'wall'
    variable = vel_z
    function = '0'
  []
[]

[Executioner]
  type = Transient
  solve_type = 'PJFNK'
  # MUMPS 直接求解器 + basic line search + damping 0.1
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_type -ksp_type -mat_mumps_icntl_14 -snes_linesearch_type -snes_linesearch_damping'
  petsc_options_value  = 'lu       mumps                      preonly   200                 basic              0.1'
  nl_rel_tol = 1e-2   # 啟動期只要降 100 倍就放行
  nl_abs_tol = 100.0  # 針對百萬級殘差，100 已足夠
  nl_max_its = 80     # 每步需要約 70 iter，給足夠空間
  l_tol = 1e-6
  l_max_its = 100
  dt = 1e-4           # 固定步長，強迫跳出惡性循環
  end_time = 10.0
  [TimeStepper]
    type = IterationAdaptiveDT
    dt_min = 1e-6         # 防止 dt 切到機器精度以下
    dt = 1e-4
    cutback_factor = 0.5
    growth_factor = 1.2

    optimal_iterations = 6
  []
[]



[FunctorMaterials]
  [mu_t_clamp]
    # 強行 clamp mu_t >= 0，防止浮點雜訊(-5.8e-11)觸發 negative viscosity abort
    # mu_t 由 INSFVMixingLengthTurbulentViscosityAux 計算後存在 AuxVariable
    # 這裡把它包成 Functor，供 INSFVMomentumDiffusion 使用
    type = ADParsedFunctorMaterial
    property_name = mu_t_safe
    functor_names = 'mu_t'
    functor_symbols = 'mu_t'
    expression = 'max(mu_t, 0.0)'
  []
[]

[Outputs]
  exodus = true
  execute_on = 'INITIAL TIMESTEP_END FINAL'
  checkpoint = true
[]
