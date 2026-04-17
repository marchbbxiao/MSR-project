[Mesh]
  [file]
    type = FileMeshGenerator
    file = ../msr.e
  []
[]

[Problem]
  type = OpenMCCellAverageProblem
  power = 3.0e9
  temperature_blocks = '1'
  cell_level = 0
  scaling = 100.0

  [Tallies]
    [Tally]
      type = MeshTally
      mesh_template = ../msr.e
      score = 'kappa_fission'
    []
  []
[]

[Executioner]
  type = Transient
  num_steps = 3
[]

[Postprocessors]
  [keff]
    type = KEigenvalue
  []
[]

[Outputs]
  exodus = true
  csv = true
[]