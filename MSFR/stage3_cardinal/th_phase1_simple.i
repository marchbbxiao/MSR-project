pressure_tag = "pressure_grad"  # SIMPLE 壓力梯度標籤，連結動量與壓力方程

# ============================================================
# th_phase1_simple.i：Phase 1 SIMPLE + Mixing Length
# ============================================================
# 目的：用 SIMPLE 分離式求解器快速推進流場，
#       讓流體「離開牆壁」，消除壁面奇異點
# 啟動：從 th_stokes_checkpoint_cp/0001 熱啟動
# 優勢：SIMPLE 每步數秒，比 PJFNK 快 100 倍以上
# 完成後：輸出 phase1_out.e 作為 Phase 2 k-ε 的初始條件
# ============================================================

rho = 4147.3
mu  = 0.011266
bulk_u = 0.130

advected_interp_method = 'upwind'
velocity_interp_method = 'rc'

[GlobalParams]
  rhie_chow_user_object = 'rc'
[]

[UserObjects]
  [rc]
    # SIMPLE 專用的 Rhie-Chow 插值器（分離式求解）
    type = INSFVRhieChowInterpolatorSegregated
    u = vel_x
    v = vel_y
    w = vel_z
    pressure = pressure
  []
[]

[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = th_run4b_out.e
    use_for_exodus_restart = true  # 讀取已發展的速度場
  []
[]

[Problem]
  type = FEProblem
  # SIMPLE 分離式求解器需要獨立的求解系統
  nl_sys_names = 'u_system v_system w_system pressure_system'
  previous_nl_solution_required = true
  allow_initial_conditions_with_restart = true
  # 從 Stokes 乾淨解熱啟動
  # 從 th_run4b_out.e 讀取速度場（SIMPLE 230步已發展，無k/ε污染問題）
[]

[Variables]
  [vel_x]
    type = INSFVVelocityVariable
    solver_sys = u_system
    initial_from_file_var = vel_x
    two_term_boundary_expansion = false
  []
  [vel_y]
    type = INSFVVelocityVariable
    solver_sys = v_system
    initial_from_file_var = vel_y
    two_term_boundary_expansion = false
  []
  [vel_z]
    type = INSFVVelocityVariable
    solver_sys = w_system
    initial_from_file_var = vel_z
    two_term_boundary_expansion = false
  []
  [pressure]
    type = INSFVPressureVariable
    solver_sys = pressure_system
    # 壓力冷啟動：避開 SIMPLE 壓力不相容問題
    initial_condition = 0.0
    two_term_boundary_expansion = false
  []
[]

[AuxVariables]
  [mixing_len]
    order = CONSTANT
    family = MONOMIAL
    fv = true
  []
  [mu_t]
    order = CONSTANT
    family = MONOMIAL
    fv = true
  []
[]

[AuxKernels]
  [mixing_length]
    type = WallDistanceMixingLengthAux
    variable = mixing_len
    walls = 'wall'
    von_karman_const = 0.41
    delta = 1.15
    execute_on = 'initial'
  []
  [turbulent_viscosity]
    type = INSFVMixingLengthTurbulentViscosityAux
    variable = mu_t
    mixing_length = mixing_len
    u = vel_x
    v = vel_y
    w = vel_z
  []
[]

[FVKernels]
  # ── 壓力修正方程式（SIMPLE 版本）──
  # FVAnisotropicDiffusion：∇⋅(Ainv ∇p') 擴散項
  # FVDivergence：∇⋅(HbyA) 源項
  # 這兩個合在一起才是 SIMPLE 的壓力 Poisson 方程式
  [p_diffusion]
    type = FVAnisotropicDiffusion
    variable = pressure
    coeff = "Ainv"
    coeff_interp_method = 'average'
  []
  [p_source]
    type = FVDivergence
    variable = pressure
    vector_field = "HbyA"
    force_boundary_execution = true
  []

  # ── x 動量 ──
  [u_advection]
    type = INSFVMomentumAdvection
    variable = vel_x
    advected_interp_method = ${advected_interp_method}
    velocity_interp_method = ${velocity_interp_method}
    rho = ${rho}
    momentum_component = 'x'
  []
  [u_viscosity]
    type = INSFVMomentumDiffusion
    variable = vel_x
    mu = ${mu}
    momentum_component = 'x'
  []
  [u_viscosity_rans]
    # 湍流擴散：使用 clamped mu_t 避免負黏度
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
    # extra_vector_tags：標記壓力梯度，供 Rhie-Chow 修正和壓力修正方程使用
    extra_vector_tags = ${pressure_tag}
  []
  [u_gravity]
    type = INSFVBodyForce
    variable = vel_x
    functor = ${fparse -rho * 0.0}
    momentum_component = 'x'
  []

  # ── y 動量 ──
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
    # extra_vector_tags：標記壓力梯度，供 Rhie-Chow 修正和壓力修正方程使用
    extra_vector_tags = ${pressure_tag}
  []

  # ── z 動量（主流方向，含重力）──
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
    # extra_vector_tags：標記壓力梯度，供 Rhie-Chow 修正和壓力修正方程使用
    extra_vector_tags = ${pressure_tag}
  []
  [w_gravity]
    type = INSFVBodyForce
    variable = vel_z
    functor = ${fparse -rho * 9.81}
    momentum_component = 'z'
  []
[]

[FunctorMaterials]
  [mu_t_clamp]
    # clamp mu_t >= 0，防止浮點雜訊觸發負黏度
    type = ADParsedFunctorMaterial
    property_name = mu_t_safe
    functor_names = 'mu_t'
    functor_symbols = 'mu_t'
    expression = 'max(mu_t, 0.0)'
  []
[]

[FVBCs]
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
  [outlet_p]
    type = INSFVOutletPressureBC
    boundary = 'gap_exit_boundary'
    variable = pressure
    function = '0'
  []
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
  type = SIMPLENonlinearAssembly
  rhie_chow_user_object = 'rc'
  # 求解系統對應
  momentum_systems = 'u_system v_system w_system'
  pressure_system = 'pressure_system'
  # 壓力梯度標籤
  pressure_gradient_tag = ${pressure_tag}
  # 鬆弛因子（保守值，確保收斂）
  momentum_equation_relaxation = 0.7
  pressure_variable_relaxation = 0.3
  # 收斂容忍值
  momentum_absolute_tolerance = 1e-5
  pressure_absolute_tolerance = 1e-5
  # 線性求解器
  momentum_petsc_options_iname = '-pc_type -pc_hypre_type'
  momentum_petsc_options_value = 'hypre boomeramg'
  pressure_petsc_options_iname = '-pc_type -pc_hypre_type'
  pressure_petsc_options_value = 'hypre boomeramg'
  momentum_l_abs_tol = 1e-14
  pressure_l_abs_tol = 1e-14
  momentum_l_tol = 0.0
  pressure_l_tol = 0.0
  momentum_l_max_its = 30
  pressure_l_max_its = 30
  num_iterations = 500
  print_fields = false
[]

[Outputs]
  exodus = true
  execute_on = 'INITIAL FINAL'
  checkpoint = true
  [final]
    type = Exodus
    file_base = 'phase1_out'
    execute_on = 'FINAL'
  []
[]
