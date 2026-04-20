# [原始]
[Mesh]
  [file]
    type = FileMeshGenerator
    file = ../msr.e
  []
[]

# [新增] 初始條件：設定燃料鹽溫度與密度的初始值
# 目標平均溫度 936K（Tano et al. 2025 論文設定）
[ICs]
  [temp]
    type = ConstantIC
    variable = temp
    value = 936.0
  []
  [density]
    type = ConstantIC
    variable = density
    # 密度公式：ρ(T) = -0.882*T + 4983.6 (kg/m³)
    # 來源：MSFR 熱膨脹係數 8.82e-4/°C × 基準密度 4100 kg/m³
    value = ${fparse -0.882*936+4983.6}
  []
[]

# [新增] 輔助變數：輸出 OpenMC cell 內的溫度與密度（供後處理使用）
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

# [新增]
[AuxKernels]
  # 從 OpenMC cell 讀取溫度回 MOOSE mesh
  [cell_temperature]
    type = CellTemperatureAux
    variable = cell_temperature
  []
  # 從 OpenMC cell 讀取密度回 MOOSE mesh
  [cell_density]
    type = CellDensityAux
    variable = cell_density
  []
  # 密度回饋：根據當前溫度場自動更新密度（負溫度係數）
  # 溫度升高 → 密度下降 → 中子洩漏增加 → keff 下降
  [density]
    type = ParsedAux
    variable = density
    expression = '-0.882*temp+4983.6'
    coupled_variables = temp
    execute_on = timestep_begin
  []
[]

# [原始] + 新增 density_blocks 和 reuse_source 兩行
[Problem]
  type = OpenMCCellAverageProblem
  power = 3.0e9                 # MSFR 設計熱功率 3000 MWth
  temperature_blocks = '1'      # [原始]
  density_blocks = '1'          # [新增] 同時更新密度（密度回饋）
  cell_level = 0                # [原始]
  scaling = 100.0               # [原始] msr.e 單位 meters，OpenMC 為 cm
  reuse_source = true           # [新增] Picard 迭代沿用上一步中子源，加速收斂

  [Tallies]
    [Tally]
      type = MeshTally
      mesh_template = ../msr.e
      score = 'kappa_fission'   # [原始] 空間功率密度 q‴(r)，傳給 MOOSE TH
    []
  []
[]

# [新增] MoabSkinner：將溫度與密度分 bin
# 讓 OpenMC 能處理空間上不均勻的溫度分佈
[UserObjects]
  [moab]
    type = MoabSkinner
    temperature = temp
    n_temperature_bins = 15     # 溫度分 15 個 bin
    temperature_min = 800.0     # 最低溫度（K）
    temperature_max = 1150.0    # 最高溫度（K）
    density = density
    n_density_bins = 15
    density_min = ${fparse -0.882*1150+4983.6}  # 對應最高溫的最低密度
    density_max = ${fparse -0.882*800+4983.6}   # 對應最低溫的最高密度
    build_graveyard = true
    output_skins = true
  []
[]

# [原始]
[Executioner]
  type = Transient
  num_steps = 3
[]

# [原始] + 新增 max_T 和 avg_T
[Postprocessors]
  [keff]
    type = KEigenvalue           # [原始]
  []
  [max_T]                        # [新增] 溫度場最大值，監控收斂
    type = ElementExtremeValue
    variable = temp
  []
  [avg_T]                        # [新增] 溫度場平均值，監控收斂
    type = ElementAverageValue
    variable = temp
  []
[]

# [原始]
[Outputs]
  exodus = true
  csv = true
[]