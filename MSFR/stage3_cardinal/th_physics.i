# =============================================================
# th_physics.i — 第三版（Physics Action + k-ε 正確耦合）
#
# 【修正歷史】
#   v1（th_run4b_energy.i）：手動 SIMPLE k-ε → Sliver 矩陣奇異，速度 3.39e6 m/s
#   v2（本次前版）：[Physics] + Pseudo-Transient，固定 μ_eff → 速度 t>0.4s 發散
#   v3（本版）：[Physics] + Pseudo-Transient + [Physics/Turbulence] k-ε 正確耦合
#
# 【v2 失敗根因】
#   fluid_heat_transfer_physics = 'energy_physics' 被加到 [energy_physics] 裡
#   應該加到 [turb_physics] 裡，block 放錯了
#   另外缺少 tke_name/tked_name/turbulence_walls 等必要參數
#
# 【v3 關鍵修正（根據 Cardinal 內建範例 2d_channel_scalar_turbulence_init.i）】
#   1. fluid_heat_transfer_physics 正確放入 [turb_physics]
#   2. 加入 tke_name = TKE, tked_name = TKED
#   3. 加入 turbulence_walls = 'wall'
#   4. 加入所有 k-ε 模型常數（C_mu, sigma_k, sigma_eps, C1_eps, C2_eps）
#   5. 加入壁面處理參數（wall_treatment_eps, wall_treatment_T）
#   6. μ 恢復分子黏度，由 [Physics/Turbulence] 自動計算並加入 μ_t
#
# 幾何：msr_with_sidesets.e（35186 TETRA4，313 Sliver Elements）
# 邊界：gap_enter_boundary（入口）、gap_exit_boundary（出口）、wall（壁面）
# 燃料鹽：ρ=4147.3 kg/m³，μ=0.011266 Pa·s，cp=1524.86 J/kg·K，k=1.0 W/m·K
# 入口：U_z=1.1838 m/s，T_in=898K，Re≈218,000
# =============================================================

# ── k-ε 初始條件計算（與 Cardinal 範例一致）──
# k_in = 1.5 × (I × U)² = 1.5 × (0.05 × 1.1838)² = 0.00264 m²/s²
# ε_in = Cμ^(3/4) × k^(3/2) / l = 0.1643 × 0.0001356 / 0.007 = 0.00362 m²/s³
# μ_t_init = ρ × Cμ × k² / ε = 4147.3 × 0.09 × 0.00264² / 0.00362 = 0.726 Pa·s

[Mesh]
  type = FileMesh
  file = '../msr_with_sidesets.e'
[]

# ─────────────────────────────────────────────────────────────
# 流體物性：恢復分子黏度（μ_t 由 [Physics/Turbulence] 自動處理）
# ─────────────────────────────────────────────────────────────
[FunctorMaterials]
  [fluid_props]
    type = ADGenericFunctorMaterial
    prop_names  = 'rho    mu            k_fluid  cp'
    prop_values = '4147.3 0.011266321   1.0      1524.86'
    # mu = 分子動黏度（0.01127 Pa·s），不再是固定 μ_eff
    # [Physics/Turbulence] 會自動計算 μ_t 並加入動量/能量方程
  []
[]

# ─────────────────────────────────────────────────────────────
# 來自 Cardinal 的功率密度
# ─────────────────────────────────────────────────────────────
[AuxVariables]
  [power_density]
    type = MooseVariableFVReal
    initial_condition = 0.0
  []
[]

# ─────────────────────────────────────────────────────────────
# [Physics] 系統
# ─────────────────────────────────────────────────────────────
[Physics]
  [NavierStokes]

    [Flow]
      [flow_physics]
        compressibility = 'incompressible'

        # 穩定插值（消除 Sliver Element 問題）
        velocity_interpolation = 'rc'
        pressure_face_interpolation = 'skewness-corrected'
        momentum_advection_interpolation = 'upwind'

        density = 'rho'
        dynamic_viscosity = 'mu'

        inlet_boundaries = 'gap_enter_boundary'
        momentum_inlet_types = 'fixed-velocity'
        momentum_inlet_functors = '0 0 1.1838'

        wall_boundaries = 'wall'
        momentum_wall_types = 'noslip'

        outlet_boundaries = 'gap_exit_boundary'
        momentum_outlet_types = 'fixed-pressure'
        pressure_functors = '0'

        initial_velocity = '0 0 0'
        initial_pressure = 0.0
      []
    []

    [FluidHeatTransfer]
      [energy_physics]
        coupled_flow_physics = 'flow_physics'

        energy_advection_interpolation = 'upwind'
        energy_face_interpolation = 'skewness-corrected'

        thermal_conductivity = 'k_fluid'
        specific_heat = 'cp'

        energy_inlet_types = 'fixed-temperature'
        energy_inlet_functors = '898.0'

        energy_wall_types = 'heatflux'
        energy_wall_functors = '0'

        external_heat_source = 'power_density'
        external_heat_source_coeff = 1.0

        initial_temperature = 898.0
        # 注意：不再有 fluid_heat_transfer_physics 或 turbulence_handling
        # 這兩個參數屬於 [turb_physics]，之前放錯了這裡
      []
    []

    # ──────────────────────────────────────────────────────────
    # [Turbulence]：k-ε 正確耦合（第三版的關鍵修正）
    #
    # 根據 Cardinal 內建範例：
    #   2d_channel_scalar_turbulence_init.i
    #   lid-driven-turb-std-wall.i
    #
    # 必要參數清單：
    #   fluid_heat_transfer_physics → 必須放在這裡（v2 放錯了）
    #   tke_name / tked_name → 變數名稱宣告
    #   turbulence_walls → 壁面 sideset 名稱
    #   C_mu, sigma_k, sigma_eps, C1_eps, C2_eps → 模型常數
    #   wall_treatment_eps → 壁面處理方法
    # ──────────────────────────────────────────────────────────
    [Turbulence]
      [turb_physics]
        # ── 耦合宣告（必須在 turb_physics 裡，不是 energy_physics 裡）──
        coupled_flow_physics = 'flow_physics'
        fluid_heat_transfer_physics = 'energy_physics'

        # ── 湍流模型 ──
        turbulence_handling = 'k-epsilon'

        # ── 變數名稱（[Physics] 自動宣告這兩個 INSFVEnergyVariable）──
        tke_name = TKE
        tked_name = TKED

        # ── 湍流 Prandtl 數（能量方程中 k_t = μ_t × cp / Pr_t）──
        Pr_t = 0.9

        # ── k-ε 標準模型常數 ──
        C_mu = 0.09      # μ_t = ρ × Cμ × k² / ε
        C1_eps = 1.44    # ε 方程生成項係數
        C2_eps = 1.92    # ε 方程耗散項係數
        sigma_k = 1.0    # k 方程擴散 Schmidt 數
        sigma_eps = 1.3  # ε 方程擴散 Schmidt 數

        # ── 壁面設定 ──
        turbulence_walls = 'wall'
        # gap_enter_boundary 和 gap_exit_boundary 不是壁面，只有 wall 是

        bulk_wall_treatment = false
        # false = 使用壁函數（標準壁面處理）
        # 適用 y+ ~30-300，TETRA4 非結構網格

        wall_treatment_eps = 'eq_newton'
        # 壁面 ε 的處理方式
        # eq_newton = 平衡假設 + Newton 迭代（最穩定）
        # 其他選項：eq_incremental, eq_linearized, neq

        wall_treatment_T = 'eq_newton'
        # 壁面溫度

        # ── 初始條件 ──
        initial_tke = 0.00264


        # ── μ_t 計算方式 ──
        mu_t_as_aux_variable = false
        # false = μ_t 作為 Functor Material，不是 AuxVariable
        # 對 Transient Newton 更穩定（避免 staggered 更新的延遲）

        k_t_as_aux_variable = false
        # false = 湍流熱傳導率也作為 Functor Material
      []
    []

  [] # end NavierStokes
[] # end Physics


[FVBCs]
  [tke_inlet]
    type = FVDirichletBC
    variable = TKE
    boundary = 'gap_enter_boundary'
    value = 0.00264
  []
  [tked_inlet]
    type = FVDirichletBC
    variable = TKED
    boundary = 'gap_enter_boundary'
    value = 0.00362
  []
[]

[Postprocessors]
  [avg_T]
    type = ElementAverageValue
    variable = T_fluid
    execute_on = 'timestep_end'
  []
  [max_vel_z]
    type = ElementExtremeValue
    variable = vel_z
    value_type = max
    execute_on = 'timestep_end'
  []
  [min_vel_z]
    type = ElementExtremeValue
    variable = vel_z
    value_type = min
    execute_on = 'timestep_end'
  []
  [avg_TKE]
    # 全場平均湍流動能（應從 0.00264 逐漸發展）
    type = ElementAverageValue
    variable = TKE
    execute_on = 'timestep_end'
  []
  [outlet_avg_T]
    type = SideAverageValue
    variable = T_fluid
    boundary = 'gap_exit_boundary'
    execute_on = 'timestep_end'
  []
  [power_density_avg]
    type = ElementAverageValue
    variable = power_density
    execute_on = 'timestep_end'
  []
[]


[Executioner]
  type = Transient
  solve_type = 'NEWTON'

  petsc_options_iname = '-pc_type -pc_factor_mat_solver_type -pc_factor_shift_type -snes_linesearch_type'
  petsc_options_value  = 'lu      mumps                       NONZERO               bt'

  nl_abs_tol = 1e-4
  nl_rel_tol = 1e-4
  nl_max_its = 20
  l_tol = 1e-5
  l_max_its = 100

  [TimeStepper]
    type = IterationAdaptiveDT
    dt = 1e-4
    cutback_factor = 0.5
    growth_factor = 1.2
    optimal_iterations = 8
    # optimal_iterations 從 6 調整到 8
    # k-ε 增加了 2 個額外變數（TKE, TKED），每步 Newton 迭代會稍多
  []

  steady_state_detection = true
  steady_state_tolerance = 1e-6
  steady_state_start_time = 10.0
  end_time = 1e5
[]

[Outputs]
  [exodus]
    type = Exodus
    file_base = 'th_physics_v3_out'
    execute_on = 'timestep_end'
    time_step_interval = 10
  []
  [csv]
    type = CSV
    file_base = 'th_physics_v3_out'
    execute_on = 'timestep_end'
  []
  print_linear_residuals = false
[]
