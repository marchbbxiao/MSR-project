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