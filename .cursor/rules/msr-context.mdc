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
- OpenMC 0.15.3 (conda activate openmc)
- Cardinal: ~/MSR-project/cardinal (branch b1e271b638, ENABLE_NEK=false)
- 614/614 tests passing, ENDF/B-VII.1

### RTXWS（主力，公司）
- Ubuntu 24.04 LTS
- Dual Xeon Silver 4216 (32 cores), 2x Tesla V100S 32GB
- 512GB NVMe (/) + 4TB HDD (~/data), IP: 192.168.27.190
- Cardinal: ~/cardinal (ENABLE_NEK=yes, V100S)
- Tests: Cardinal 783/815, Thermochimica 77/77, Zapdos 58/62
- Cross-sections: ~/data/cross_sections/endfb-vii.1-hdf5/
- OpenMC執行: export PATH=/home/ubuntu/cardinal/install/bin:/home/ubuntu/cardinal/install/bin:/usr/local/cuda-12.5/bin:/usr/local/cuda-12.2/bin:/usr/local/cuda-12.2/bin:/home/ubuntu/.local/bin:/home/ubuntu/cardinal/install/bin:/home/ubuntu/miniconda3/bin:/home/ubuntu/miniconda3/condabin:/usr/local/cuda-12.5/bin:/usr/local/cuda-12.2/bin:/usr/local/cuda-12.2/bin:/home/ubuntu/.local/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin
- Run: mpirun -n 4 --mca btl_vader_single_copy_mechanism none openmc

## 目前進度

### Stage 2 完成（2026-04-15）
- MSFR standalone OpenMC keff = 1.047±0.004
- 使用 msr_reflecting.h5m (boundary:Reflecting)
- 燃料鹽：U233=0.02135 ao, Li7=0.779961, Li6=3.9e-5, F19=1.66, Th232=0.19985
- 密度：4.1249 g/cm3, T=898K
- Batches=100 (50 inactive + 50 active), particles=1000

### 下一步：Stage 3
- Cardinal OpenMC + MOOSE RANS TH 耦合
- 在 RTXWS 執行

## 關鍵技術細節

### OpenMC (RTXWS)
- Python API 不可用 (Python 3.10 incompatible with typing.Self)
- XML模式：cross_sections 設在 materials.xml (不是 settings.xml)
- DAGMC geometry: <dagmc_universe id=1 filename=... auto_geom_ids=true/>
- Neutron source: sphere r=70cm

### 已知問題
- Zapdos: INCORRECT JACOBIAN (2個測試失敗)
- Cardinal: 783/815 (32個失敗待查)
- 鄧永宏: PID Control 尚未成功

### 重要檔案
- msr.h5m, msr_reflecting.h5m, msr.e (MSFR幾何)
- stage2_msfr_openmc_keff_baseline.ipynb

## 耦合架構（Tano 2025）
內層迴圈 (Picard):
  Step 1: OpenMC 計算功率密度
  Step 2: MOOSE RANS TH 計算溫度場+速度場
  Step 3: 溫度回傳OpenMC更新截面
  Step 4: DNP空間漂移
  Step 5: 密度回饋
  Step 6: 收斂判斷

外層迴圈 (燃耗):
  Step 7: openmc.deplete (0.1 MWd/kgHM)
  Step 8a: Thermochimica (相平衡)
  Step 8b: Zapdos PNP (腐蝕)
  Step 9: 更新materials.xml
  Step 10: UF4補料控制keff≈1.05
  Step 11: 回到Step 1

## 每日更新說明
開發結束後在 Claude.ai 說：
「今天完成了XXX，遇到YYY，幫我更新CLAUDE.md」
→ 複製新內容貼回這個檔案
→ git add CLAUDE.md && git commit -m "更新記憶" && git push
