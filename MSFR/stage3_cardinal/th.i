# MOOSE RANS TH 熱流計算輸入檔
# 求解燃料鹽的速度場 v(r) 和溫度場 T(r)
# 接收來自 neutronics.i 的功率密度 q‴(r) 作為熱源

# 燃料鹽物性（來源：Rouch et al. 2014，ANL Cardinal tutorial）
rho = 4147.3        # 密度 kg/m³
mu = 0.011266321    # 動力黏度 Pa-s
cp = 1524.86        # 比熱容 J/kg/K
k = 1.0             # 熱傳導係數 W/m/K（暫用，待確認）

[Mesh]
  [file]
    type = FileMeshGenerator
    file = ../msr_with_sidesets.e
  []
[]