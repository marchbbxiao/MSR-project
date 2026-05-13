# ============================================================
# main.i：Cardinal 耦合主程式
# ============================================================
# 架構：OpenMC（中子學）← Picard 迭代 → MOOSE RANS TH（熱流）
# 參考：cardinal/tutorials/msfr/openmc.i
#
# Picard 迭代流程：
#   Step 1：OpenMC 計算功率密度 kappa_fission(r)
#   Step 2：MOOSE TH 接收功率密度，計算溫度場 T_fluid(r)
#   Step 3：溫度場回傳 OpenMC，更新截面（Doppler 效應）
#   Step 4：收斂判斷，未收斂回 Step 1
# ============================================================

# ── 中子學網格（OpenMC 用 msr.e，不含 sidesets）─────────────
[Mesh]
  [file]
    type = FileMeshGenerator
    file = ../msr.e
  []
[]

# ── 初始條件 ──────────────────────────────────────────────────
[ICs]
  [temp]
    type = ConstantIC
    variable = temp
    value = 936.0           # 目標平均溫度（K）
  []
  [density]
    type = ConstantIC
    variable = density
    value = ${fparse -0.882*936+4983.6}
  []
[]

# ── 輔助變數 ──────────────────────────────────────────────────
[AuxVariables]
  [cell_temperature]
    family = MONOMIAL
    order = CONSTANT
  []
  [cell_density]
    family = MONOMIAL
    order = CONSTANT
  []
[]

[AuxKernels]
  [cell_temperature]
    type = CellTemperatureAux
    variable = cell_temperature
  []
  [cell_density]
    type = CellDensityAux
    variable = cell_density
  []
  [density]
    type = ParsedAux
    variable = density
    expression = '-0.882*max(800.0,min(1800.0,temp))+4983.6'  # 截斷：防止非物理溫度造成負密度
    coupled_variables = temp
    execute_on = timestep_begin
  []
[]

# ── OpenMC 問題設定 ───────────────────────────────────────────
[Problem]
  type = OpenMCCellAverageProblem
  temperature_min = 800.0
  temperature_max = 1800.0
  power = 3.0e9                 # MSFR 設計熱功率 3000 MWth
  temperature_blocks = '1'
  density_blocks = '1'
  cell_level = 0
  scaling = 100.0               # msr.e 單位 m，OpenMC 為 cm
  reuse_source = true           # Picard 沿用上一步中子源，加速收斂
  skinner = moab
  [Tallies]
    [heat_source]
      type = MeshTally
      mesh_template = ../msr.e
      score = 'kappa_fission'
    []
  []
[]

# ── MoabSkinner：溫度/密度分 bin ──────────────────────────────
nb   = 15.0
tmin = 600.0   # 入口邊界溫度可能低於 800K
tmax = 1e6   # MoabSkinner 不崩潰，核數據截斷靠 OpenMCCellAverageProblem

[UserObjects]
  [moab]
    type = MoabSkinner
    temperature = temp
    n_temperature_bins = ${nb}
    temperature_min = ${tmin}
    temperature_max = ${tmax}
    density = density
    n_density_bins = ${nb}
    density_min = 3000.0   # 固定值，不隨 tmax 變化
    density_max = 4500.0   # 固定值
    build_graveyard = true
    output_skins = true
  []
[]

# ── TH Sub-App ────────────────────────────────────────────────
# FullSolveMultiApp：每個 Picard 步讓 TH 跑到它自己的收斂標準
# keep_solution_during_restore：保留上一輪的 T_fluid，
#   讓溫度場在 Picard 迭代中累積收斂（Claude 與 Gemini 共識）
[MultiApps]
  [th]
    type = FullSolveMultiApp
    input_files = 'th_run4b_energy.i'
    execute_on = 'timestep_end'
    keep_solution_during_restore = true
  []
[]

# ── 變數傳遞 ─────────────────────────────────────────────────
# 兩個網格不同（msr.e vs msr_with_sidesets.e），
# 用 NearestLocationTransfer 做插值
[Transfers]
  # TH → OpenMC：溫度場（T_fluid → temp）
  [temp_from_th]
    type = MultiAppGeneralFieldShapeEvaluationTransfer
    from_multi_app = th
    variable = temp
    source_variable = T_fluid
  []
  # OpenMC → TH：功率密度（kappa_fission → power_density）
  [power_to_th]
    type = MultiAppGeneralFieldShapeEvaluationTransfer
    to_multi_app = th
    source_variable = kappa_fission
    variable = power_density
  []
[]

# ── Picard 迭代控制 ──────────────────────────────────────────
# num_steps = 5：第一次試跑，目標是跑通框架，不要求精確收斂
[Executioner]
  type = Transient
  num_steps = 5
[]

# ── 監控輸出 ─────────────────────────────────────────────────
[Postprocessors]
  [keff]
    type = KEigenvalue
  []
  [max_T]
    type = ElementExtremeValue
    variable = temp
  []
  [avg_T]
    type = ElementAverageValue
    variable = temp
  []
[]

[Outputs]
  exodus = true
  csv = true
[]
