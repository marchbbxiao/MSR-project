# CLAUDE.md — MSR Project 記憶檔
# 每次開新對話時把這份檔案內容貼給 Claude.ai

## 專案目標
複製 Tano et al. 2025 (Progress in Nuclear Energy 178, 105503) 的完整耦合框架：
OpenMC + MOOSE RANS TH + Thermochimica + Zapdos PNP

## 機器環境

### A電腦（家用）
- Windows 11 + WSL2 Ubuntu 22.04
- i7-12700, 16GB RAM, RTX A5000
- Username: bruce, Windows user: i0950B
- Cardinal: ~/MSR-project/cardinal (ENABLE_NEK=false), 614/614 tests

### RTXWS（主力，公司）
- Ubuntu 24.04 LTS
- Dual Xeon Silver 4216 (32 cores), 2x Tesla V100S 32GB
- IP: 192.168.27.190
- Cardinal: ~/cardinal (ENABLE_NEK=yes)
- Tests: Cardinal 783/815, Thermochimica 77/77, Zapdos 58/62
- Cross-sections: ~/data/cross_sections/endfb-vii.1-hdf5/
- OpenMC 執行: export PATH=/home/ubuntu/cardinal/install/bin:$PATH
- Run: mpirun -n 4 --mca btl_vader_single_copy_mechanism none openmc
- IDE: Cursor 3.1.15

## 專案資料夾架構
~/MSR-project/
├── MSFR/
│   ├── msr.e                    # MOOSE TH 網格（Exodus）
│   ├── msr.h5m                  # OpenMC 幾何（DAGMC，vacuum）
│   ├── msr_reflecting.h5m       # OpenMC 幾何（DAGMC，reflecting）
│   ├── materials.xml            # Stage 2 OpenMC 材料定義
│   ├── geometry.xml             # Stage 2 OpenMC 幾何定義
│   ├── settings.xml             # Stage 2 OpenMC 設定
│   ├── tune_keff.py             # Stage 2 濃度調整腳本
│   ├── stage3_cardinal/         # Stage 3 工作目錄
│   │   ├── neutronics.i         # OpenMC/Cardinal 輸入檔（完成）
│   │   └── th.i                 # MOOSE RANS TH 輸入檔（進行中）
│   ├── results/
│   │   └── stage2_msfr_openmc/
│   └── docs/
├── msre-project/                # Stage 1 MSRE 驗證
├── scripts/
│   └── sync.sh                  # 每日 git push
├── .cursor/rules/
│   └── msr-context.mdc          # Cursor AI 自動讀取
└── CLAUDE.md                    # 本檔案

## 目前進度

### Stage 1 完成
- MSRE keff = 1.00637 ± 0.00113

### Stage 2 完成（2026-04-15）
- MSFR standalone OpenMC keff = 1.047 ± 0.004
- 幾何：msr_reflecting.h5m (Reflecting 邊界)
- 燃料鹽：U233=0.02135 ao, Li7=0.779961, Li6=3.9e-5, F19=1.66, Th232=0.19985
- 密度：4.1249 g/cm3, T=898K

### Stage 3 進行中（2026-04-17）
- Phase 3.1 目標：單向傳遞（OpenMC → MOOSE）
- neutronics.i 完成
- th.i 進行中，下一步找 heat source FVKernel

## Stage 3 關鍵技術細節

### neutronics.i 參數根據
- scaling = 100.0：msr.e 單位公尺，OpenMC 需要公分（文件確認）
- temperature_blocks = '1'：msr.e 唯一 block ID=1（netCDF4 確認）
- cell_level = 0：DAGMC 單層幾何
- power = 3.0e9：MSFR 設計功率 3 GW

### th.i 參考範例
- ~/cardinal/contrib/moose/modules/navier_stokes/test/tests/postprocessors/rayleigh/natural_convection.i
- 區塊：[Mesh][Variables][UserObjects][FVKernels][FVBCs][FluidProperties][FunctorMaterials][Executioner]
- 需要額外加 heat source FVKernel

### Stage 3 執行計畫
Phase 3.1：單向傳遞（OpenMC → MOOSE），固定邊界條件，不用 PID
Phase 3.2：雙向 Picard 迭代，relaxation_factor 防震盪
Phase 3.3：PID Control，先 P-only，解決鄧永宏卡關點

## 已知問題
- Cardinal 783/815（32個失敗，NekRS 相關，不影響 MOOSE RANS TH）
- Zapdos INCORRECT JACOBIAN（2個失敗，不影響我們）
- 鄧永宏 PID Control 尚未成功

## 每日更新說明
開發結束後在 Claude.ai 說：「今天完成了XXX，幫我更新 CLAUDE.md」
→ 在 Cursor 直接編輯 CLAUDE.md
→ msr-sync "說明"
## 2026-04-20 今日工作（RTXWS）

### 完成項目
- neutronics.i 補強：ICs(936K)、密度回饋(ParsedAux)、density_blocks、MoabSkinner、reuse_source
- 安裝 Coreform Cubit 2026.4（/opt/Coreform-Cubit-2026.4/bin/coreform_cubit）
- read_mesh.py：分析 msr.e 幾何，找出上下截斷面節點
- add_sidesets.py：用 Cubit Python API 建立 nodeset
- msr_with_sidesets.e：產生含 gap_exit_boundary(上,Z>0) + gap_enter_boundary(下,Z<0) 的新幾何檔
- th.i：完成 Mesh 區塊（載入 msr_with_sidesets.e）

### 明天下一步：繼續寫 th.i
需要完成的區塊：
1. [Variables]：vel_x, vel_y, vel_z, pressure, TKE, TKED, T_fluid
2. [FVKernels]：動量 + 壓力 + k-epsilon + 能量方程式（含熱源）
3. [FVBCs]：入口速度+溫度(898K)、出口壓力(0)、壁面無滑移
4. [Executioner]：SIMPLE solver

### 關鍵物性參數（Rouch et al. 2014）
- rho = 4147.3 kg/m³
- mu = 0.011266321 Pa-s
- cp = 1524.86 J/kg/K
- k = 1.0 W/m/K（暫用）
- 入口溫度：898K
- 目標平均溫度：936K

### k-epsilon 參數
- sigma_k = 1.0, sigma_eps = 1.3
- C1_eps = 1.44, C2_eps = 1.92, C_mu = 0.09
- bulk_u = 0.130 m/s（從 Re=4.8e4 推算）
- intensity = 0.01
- k_init = 1.5*(0.01*0.130)^2
- eps_init = 0.09^0.75 * k_init^1.5 / 1.0

### 待確認
- 熱傳導係數 k 的正確值
- 入口速度是否正確（需與鄧永宏確認）
- gap_enter/exit 上下方向是否正確（物理驗證後確認）

## 2026-04-21 今日工作（A電腦）

### 完成項目
- th.i [Variables]：7個變數完成，TKE/TKED 初始值用湍流強度公式估算
- th.i [AuxVariables]：power_density（Cardinal 耦合橋樑）
- th.i [FVKernels]：25個 kernels 完成（質量1 + 動量12 + 能量4 + TKE4 + TKED4）
- 所有區塊加入完整中文詳細註解

### 明天下一步：繼續寫 th.i
需要完成的區塊：
1. [FVBCs]：入口速度+溫度(898K)、出口壓力(0)、壁面無滑移、TKE/TKED 入口值
2. [FunctorMaterials]：定義 mu_t = Cμ*k²/ε，補入動量和能量擴散項的湍流修正
3. [Executioner]：SIMPLE solver 設定

### 已知待修正（寫在 kernel 註解的 ⚠️ 標記）
- 動量擴散項目前只用 μ，應改為 total_viscosity（μ+μt）
- 能量擴散項目前只用 k，應加入湍流熱傳導 kt

### 今日學到的核心概念
- Re ≈ 958,000 → MSFR 強湍流，必須用 k-epsilon 模型
- RANS = N-S 時間平均，湍流打包成 μt = Cμ*k²/ε
- 守恆定律結構：時間項 + 對流項 = 擴散項 + 源項
- TKE/TKED 互相依賴，初始值不能為零
- SIMPLE 演算法：壓力調節速度強制 div(v)=0

## 2026-04-22 今日工作（RTXWS）

### 完成項目
- th.i [Variables]、[AuxVariables]、[FVKernels] 完成（25個kernels）
- 教學工具：NS_RANS_ke_完整教學工具_v3.html 存入 MSFR/note/
- 概念：Re估算、DNS為何不行、Reynolds分解、Boussinesq假設、三種對流區別

### 下一步：繼續寫 th.i
1. [FVBCs]：入口速度+溫度、出口壓力、壁面無滑移、TKE/TKED入口值
2. [FunctorMaterials]：μt = Cμk²/ε
3. [Executioner]：SIMPLE solver

## 2026-04-22 今日工作（RTXWS）

### 完成項目
1. 發現 msr_with_sidesets.e 只有 node sets 的根本問題
2. 修正 read_mesh.py：改用 element+side 產生正確 side sets
3. msr_with_sidesets.e 現在有三個正確 side sets：
   - gap_exit_boundary（334面）
   - gap_enter_boundary（336面）
   - wall（11304面）
4. th.i 大幅更新，根據 Tano 本人的 channel_ERCOFTAC.i 範本修正：
   - 加入 [GlobalParams]、[Problem]、[UserObjects]
   - [Variables] 加入 solver_sys 和 two_term_boundary_expansion
   - [AuxVariables] 加入 mu_t、yplus
   - [AuxKernels] 加入 kEpsilonViscosityAux、RANSYPlusAux
   - [FVKernels] 動量/TKE/TKED 擴散改為分子+湍流兩個 kernel
   - 質量守恆改為 FVAnisotropicDiffusion + FVDivergence（SIMPLE版）
   - 壓力項加 extra_vector_tags
   - [FVBCs] 修正：壁面用 FVDirichletBC，湍流入口用 FVDirichletBC
   - [Executioner] 加入 SIMPLENonlinearAssembly

### 尚未完成（斷電前中斷）
- th.i 語法檢查還有三個問題待修正：
  1. [FVKernels] 沒有正確關閉就開始 [FVBCs]（最嚴重）
  2. vel_y_advection、vel_z_advection 殘留 advected_interp_method = average
  3. TKE_source 缺 walls/wall_treatment；TKED_source 缺 k/walls/wall_treatment

### 下一步（復電後）
1. 修正上述三個語法問題
2. 執行 --check-input 語法驗證
3. 確認通過後嘗試第一次單獨執行 th.i（不耦合 OpenMC）

### 關鍵參考檔案
- Tano 本人的 RANS 範本：~/cardinal/contrib/moose/modules/navier_stokes/test/tests/finite_volume/ins/turbulence/channel/segregated/channel_ERCOFTAC.i
- 正確網格：~/MSR-project/MSFR/msr_with_sidesets.e

## 2026-04-22 下午工作（RTXWS）

### 完成項目
- th.i 語法驗證完全通過（零錯誤、零警告）
- 修正清單：
  1. 停用6個時間項 kernel（SIMPLE 穩態不用 Transient）
  2. 移除重複 GlobalParams 殘留
  3. 修正 energy_source：INSFVBodyForce → FVCoupledForce
  4. 修正 energy_diffusion：INSFVEnergyDiffusion → FVDiffusion
  5. 移除 energy_advection 多餘的 rho/cp 參數
  6. 全部 k = TKE 改為 tke = TKE（棄用參數）
  7. TKED_source 補上 tke/walls/wall_treatment
  8. msr_with_sidesets.e 已有正確三個 side sets

### 下一步
- 嘗試單獨執行 th.i（不耦合 OpenMC）：
  mpirun -n 4 ~/cardinal/cardinal-opt -i th.i
- 預期可能的問題：網格品質（y+）、收斂性

## 2026-04-22 晚（RTXWS）

### th.i 運行狀態
- 第一次嘗試（relaxation=0.7）：Iter ~50 發散（inf）
- 第二次嘗試（relaxation=0.5）：Iter 92 壓力劇烈震盪
- 第三次嘗試（relaxation=0.3/0.1）：目前 Iter 87，殘差穩定
  - Momentum: 0.05~0.14（輕微震盪）
  - Pressure: 0.19→0.11（持續下降）
  - Energy: 0.045（穩定）
  - TKE/TKED: 0.046/0.012（穩定）
- 結論：不發散，但收斂慢，讓它跑到 1000 次觀察

### 重要認知修正
- Tano et al. 2025 並未耦合 MOOSE RANS TH
- 論文假設固定溫度場 936K（均勻溫度）
- 我們做的完整 TH 耦合是超越論文的工作

### 下一步
1. 等 th.i 跑完 1000 次，觀察最終殘差
2. 若收斂：用 Paraview 觀察速度場和溫度場
3. 若不收斂：考慮改善初始條件或網格
4. 之後開始寫 neutronics.i 和 main.i
