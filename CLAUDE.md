# MSR 耦合模擬專案 — CLAUDE.md
# 最後更新：2026-05-13

---

## 專案目標

複製 Tano et al. 2025（Progress in Nuclear Energy 178, 105503）的
OpenMC + Thermochimica + Zapdos PNP 耦合框架，
**並擴展加入 MOOSE RANS TH**（論文未實作，我們超越論文的部分）。

---

## 環境資訊

### RTXWS（主力機）
- Ubuntu 24.04，WinFast WS2030
- Dual Xeon Silver 4216（32核），2×Tesla V100S 32GB
- 512GB NVMe (/)，4TB HDD (~/data)，IP 192.168.27.190
- Cardinal 安裝位置：`~/cardinal`
- 截面資料庫：ENDF/B-VII.1，路徑 `~/data/cross_sections/endfb-vii.1-hdf5/`
- conda env：`moose`（`conda activate moose`）
- 執行 Cardinal：`mpirun -n 16 --mca btl_vader_single_copy_mechanism none ~/cardinal/cardinal-opt -i main.i`

### A電腦（次要/同步）
- Windows 11 + WSL2 Ubuntu 22.04，username=bruce
- Cardinal b1e271b638，ENABLE_NEK=false

---

## 目前進度

### Stage 1：MSRE keff 驗證 ✅
- keff = 1.00637 ± 0.00113

### Stage 2：MSFR 單獨 OpenMC ✅（2026-04-15）
- keff = 1.047 ± 0.004
- 燃料鹽：U233=0.02135, Li7=0.779961, Li6=3.9e-5, F19=1.66, Th232=0.19985
- density = 4.1249 g/cm³, T=898K
- 幾何：msr_reflecting.h5m（Reflecting 邊界）

### Stage 3a：Cardinal 穩態 Picard 耦合 ✅（2026-05-13，run12）

**框架驗證成功，5 個 Picard 步全部完成。**

```
| time | avg_T    | keff      | max_T  |
| 1    | 936.0    | 0.91015   | 936.0  |
| 2    | 1234.0   | 0.87670   | 1800.0 |
| 3    | 1239.9   | 0.87696   | 1800.0 |
| 4    | 1245.7   | 0.87716   | 1800.0 |
| 5    | 1251.4   | 0.87357   | 1800.0 |
計算時間：198.52 秒（16 核）
```

**物理問題（已知，待修復）：**
- avg_T 偏高（1234K vs 預期 1000K）
- keff 偏低（0.877 vs 目標 1.047，差 17,300 pcm）
- 原因：313 個 Sliver Elements 數值污染被截斷到 1800K，假收斂

### Stage 3b：暫態耦合 ⏳ 待開始

---

## 當前最重要任務：重寫 th_physics.i

**決策：放棄手動 [FVKernels]，改用 MOOSE [Physics] 系統 + Pseudo-Transient**

### 為什麼要換

原本 `th_run4b_energy.i` 的根本問題：
- 手動 SIMPLE [FVKernels]：缺乏 skewness-corrected、Rhie-Chow 等穩定機制
- 313 個 Sliver Elements（SJ < 0.1）使矩陣對角線→0，速度飆到 3.39e6 m/s
- 人工阻尼無效（顯式 vs 隱式時機問題）
- T_clipped 防火牆只是掩蓋問題，avg_T/keff 物理不準確

### 新架構設計

```ini
[Physics]
  [Flow]
    [flow_physics]
      compressibility = 'incompressible'
      momentum_advection_interpolation = 'upwind'
      pressure_face_interpolation = 'skewness-corrected'  # 消除 Sliver 幾何偏斜
      velocity_interpolation = 'rc'                        # Rhie-Chow
      inlet_boundaries = 'gap_enter_boundary'
      momentum_inlet_types = 'fixed-velocity'
      wall_boundaries = 'wall'
      momentum_wall_types = 'noslip'
      outlet_boundaries = 'gap_exit_boundary'
      momentum_outlet_types = 'fixed-pressure'
      pressure_functors = '0'
    []
  []
  [FluidHeatTransfer]
    [energy_physics]
      energy_advection_interpolation = 'upwind'
      energy_face_interpolation = 'skewness-corrected'
      energy_inlet_types = 'fixed-temperature'
      energy_inlet_functors = '898.0'
      energy_wall_types = 'heatflux'
      energy_wall_functors = '0'
    []
  []
  [Turbulence]
    [sst_physics]
      turbulence_handling = 'k-omega-sst'   # 一行取代所有手動 k-ε kernels
    []
  []
[]

[Executioner]
  type = Transient                # Pseudo-Transient（關鍵！ρV_C/Δt 壓制矩陣病態）
  solve_type = 'NEWTON'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_type
                          -pc_factor_shift_type -snes_linesearch_type'
  petsc_options_value  = 'lu     mumps  NONZERO  bt'
  [TimeStepper]
    type = IterationAdaptiveDT
    dt = 1e-4
    cutback_factor = 0.5
    growth_factor = 1.2
    dtmax = 1.0
  []
  steady_state_detection = true
  steady_state_tolerance = 1e-6
  end_time = 1e5
[]
```

### 關鍵穩定機制

| 機制 | 作用 |
|------|------|
| skewness-corrected 面插值 | 消除 Sliver 幾何偏斜導致的梯度估算錯誤 |
| Rhie-Chow (rc) | 防止同位網格壓力震盪 |
| upwind 梯度限制器 | 防止局部速度過衝 |
| Pseudo-Transient ∂(ρu)/∂t | ρV_C/Δt 加到對角線，強制矩陣對角佔優 |

### 開發步驟

1. `th_physics.i`：新架構（[Physics] + Pseudo-Transient）
2. 單獨跑 TH，確認 Outlier 速度消失
3. Cardinal run13：接新 TH，確認 keff 回到 ~1.0 附近
4. 撤除 T_clipped 防火牆
5. Stage 3b：暫態耦合

---

## 網格資訊

### msr_with_sidesets.e（現有網格，繼續使用）
- Exodus II，TETRA4，9245 nodes，35186 elements
- Side sets：`gap_enter_boundary`（入口）、`gap_exit_boundary`（出口）、`wall`（壁面）
- **已知問題：313 個 Sliver Elements（SJ < 0.1），最差 SJ=0.01912**
- 位置：入口槽與球壁銳角交界
- 決策：不重建網格，靠 [Physics] 系統的穩定機制應對

---

## 關鍵檔案

```
工作目錄：~/MSR-project/MSFR/stage3_cardinal/
網格（TH）：../msr_with_sidesets.e
網格（OpenMC）：../msr.e
DAGMC：../msr_reflecting.h5m
IC（乾淨基準）：th_run4b_out.e（April 24，SIMPLE 動量場收斂）
當前 TH 輸入：th_run4b_energy.i（舊版，手動 k-ε + T_clipped 防火牆）
當前耦合主程式：main.i（T_clipped Transfer，tmin=1K，ShapeEvaluation）
最新 run log：cardinal_run12.log（5 步成功）
工作日誌：工作日誌/2026-05-12_13.md
```

---

## 燃料鹽物性

來源：Rouch et al. 2014，ANL Cardinal tutorial
- rho = 4147.3 kg/m³（線性：-0.882T + 4983.6）
- mu = 0.011266321 Pa·s
- cp = 1524.86 J/kg/K
- k = 1.0 W/m·K
- 入口速度 = 1.1838 m/s（+z 方向）
- 入口溫度 = 898K，目標平均 936K

---

## 重要認知

**Tano et al. 2025 並未耦合 MOOSE RANS TH！**
- 論文假設固定均勻溫度場 936K
- 我們做完整 TH 耦合是超越論文的工作

**Sliver Elements 的根本機制：**
- V_i → 0 → A_diag → 0 → Iteration 1 隱式求解速度飆 3.39e6 m/s
- Outlier 每次完全相同（3.388682e+06 / 4.181225e+06 / 6.053793e+06）
- 顯式阻尼無效，T_clipped 只是隔離，[Physics] + Pseudo-Transient 才是根治

**MOOSE [Physics] 系統（2024/2025）：**
- 舊版 [Modules]/NSFVAction 已棄用（Deprecated）
- 新版 [Physics] 自動生成標準變數（vel_x, vel_y, vel_z, pressure, T_fluid）
- Cardinal Transfer 直接對應，不需修改 main.i

---

## 工具鏈

```bash
~/cardinal/cardinal-opt          # 主執行檔
~/cardinal/contrib/moose/        # MOOSE 框架
~/MSR-project/MSFR/              # MSFR 工作目錄
~/MSR-project/MSFR/stage3_cardinal/  # Stage 3 輸入檔

# 語法驗證
~/cardinal/cardinal-opt --check-input -i th_physics.i 2>&1 | tail -5

# 單獨跑 TH
mpirun -n 16 --mca btl_vader_single_copy_mechanism none \
  ~/cardinal/cardinal-opt -i th_physics.i 2>&1 | tee th_physics.log &

# Cardinal 耦合
mpirun -n 16 --mca btl_vader_single_copy_mechanism none \
  ~/cardinal/cardinal-opt -i main.i 2>&1 | tee cardinal_run13.log &
```

---

## GitHub

Repo：marchbbxiao/MSR-project（private）
日常同步：`msr-sync` alias

---

## 下一步（優先順序）

1. **【最優先】重寫 th_physics.i**（[Physics] + k-ω SST + Pseudo-Transient）
2. **單獨測試 TH**：確認 Outlier 速度消失，速度場物理收斂
3. **Cardinal run13**：接新 TH，確認 keff 回到 ~1.0
4. **驗證撤除 T_clipped**：avg_T 回到 ~1000K，keff 回到 ~1.047
5. **Stage 3b**：暫態耦合（Transient Newton + DNP 漂移）
6. **Stage 4**：燃耗循環（openmc.deplete + Thermochimica + Zapdos）
