# MSR 耦合模擬專案 — CLAUDE.md
# 最後更新：2026-05-14

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

框架驗證成功，但物理假收斂：
```
avg_T = 1234K（應為 ~1000K）
keff = 0.877（應為 ~1.047，差 17,300 pcm）
```
根本原因：313 個 Sliver Elements 數值污染，T_clipped 防火牆掩蓋問題

### Stage 3b：TH 重建（2026-05-14）

#### th_physics.i 版本歷史

**v1（th_run4b_energy.i）：手動 SIMPLE k-ε**
- 問題：Sliver Elements → 矩陣奇異 → 速度 3,388,682 m/s
- 結果：假收斂，avg_T=1234K，keff=0.877

**v2：[Physics] + Pseudo-Transient，固定 μ_eff=0.7373**
- 成果：Sliver 問題解決，max_vel_z 從 3.39e6 降至 1.3 m/s ✅
- 失敗：固定 μ_eff 無湍流耗散，t>0.4s 速度發散至 8.47 m/s ❌
- 流場物理確認（Gemini 驗證）：
  - Phase 1（t<0.019s）：V 型速度發展 = 射流徑向擴散（Plume expansion）
  - Phase 2（0.019→0.154s）：渦旋建立，max_vel_z 增至 2.45 m/s
  - Phase 3（t≈0.154s）：Flip-Flop 翻轉（Kelvin-Helmholtz 不穩定性），物理真實
  - Phase 4（t>0.4s）：速度發散，固定 μ_eff 無法耗散渦流動能

**v3（當前版本）：[Physics] + Pseudo-Transient + [Physics/Turbulence] k-ε**
- 狀態：語法通過 ✅，run3 執行中 ⏳
- 關鍵修正：fluid_heat_transfer_physics 正確放入 [turb_physics]（v2 放在 [energy_physics] 裡）
- 自動輸出：mu_t_out, k_t_out（可 ParaView 視覺化）

---

## 當前最重要任務

### 立即：觀察 run3 結果

```bash
tail -50 ~/MSR-project/MSFR/stage3_cardinal/th_physics_run3.log
grep "8.980000e+02" ~/MSR-project/MSFR/stage3_cardinal/th_physics_run3.log | tail -10
```

**判斷標準：**
- max_vel_z 穩定在 ~2-3 m/s → k-ε 湍流耗散有效，繼續等穩態
- max_vel_z 再次發散到 >8 m/s → k-ε 仍有問題，需要診斷
- Newton DIVERGED_MAX_IT 反覆出現 → 收斂策略需調整

### 下一步（依序）

1. **run3 速度場穩定** → 進入 Cardinal run13
   - 修改 main.i 使用 th_physics.i（確認 Transfer 變數名稱：T_fluid）
   - 預期：avg_T 從 898K 升至 ~1000K，keff 回到 ~1.047
   - 驗證：撤除 T_clipped 防火牆

2. **run3 失敗** → 根據錯誤訊息診斷
   - 若仍發散：查 mu_t_out 分佈是否異常（ParaView）
   - 若 Newton 卡死：調整 nl_max_its 或 dt 參數

3. **Stage 3b 完成後** → Stage 4 燃耗循環（openmc.deplete + Thermochimica + Zapdos）

---

## th_physics.i v3 架構說明

```ini
[Physics/NavierStokes/Flow/flow_physics]
  compressibility = incompressible
  velocity_interpolation = rc                      # Rhie-Chow
  pressure_face_interpolation = skewness-corrected # 消除 Sliver 偏斜誤差
  momentum_advection_interpolation = upwind        # 防速度過衝
  dynamic_viscosity = mu（分子黏度，μ_t 由 Turbulence 自動加）

[Physics/NavierStokes/FluidHeatTransfer/energy_physics]
  external_heat_source = power_density（來自 OpenMC）

[Physics/NavierStokes/Turbulence/turb_physics]
  fluid_heat_transfer_physics = 'energy_physics'   # 關鍵！v2 放錯位置
  turbulence_handling = 'k-epsilon'
  tke_name = TKE, tked_name = TKED
  C_mu=0.09, C1_eps=1.44, C2_eps=1.92, sigma_k=1.0, sigma_eps=1.3
  turbulence_walls = 'wall'
  wall_treatment_eps = 'eq_newton'

[Executioner]
  type = Transient（Pseudo-Transient）
  solve_type = NEWTON
  petsc: lu + mumps + NONZERO + bt linesearch
  nl_abs_tol=1e-4, nl_rel_tol=1e-4, nl_max_its=20
  dt=1e-4, growth=1.2, cutback=0.5, optimal_iterations=8
```

---

## 網格資訊

### msr_with_sidesets.e（TH 用）
- Exodus II，TETRA4，9245 nodes，35186 elements
- Side sets：gap_enter_boundary（入口）、gap_exit_boundary（出口）、wall（壁面）
- **已知問題：313 個 Sliver Elements（SJ < 0.1），最差 SJ=0.01912**
- 解決方案：[Physics] skewness-corrected + Pseudo-Transient（不重建網格）

---

## 燃料鹽物性

來源：Rouch et al. 2014，ANL Cardinal tutorial
- rho = 4147.3 kg/m³
- mu = 0.011266321 Pa·s（分子黏度）
- cp = 1524.86 J/kg·K
- k = 1.0 W/m·K
- 入口速度 = 1.1838 m/s（+z 方向）
- 入口溫度 = 898K，目標平均 ~1000K

---

## 關鍵檔案

```
工作目錄：~/MSR-project/MSFR/stage3_cardinal/
網格（TH）：../msr_with_sidesets.e
網格（OpenMC）：../msr.e
DAGMC：../msr_reflecting.h5m
當前 TH 輸入：th_physics.i（v3，[Physics/Turbulence] k-ε）
run3 log：th_physics_run3.log（執行中）
舊版 log：th_physics_run2.log（固定 μ_eff，速度發散記錄）
主耦合：main.i（尚未更新到使用 v3）
工作日誌：工作日誌/2026-05-14.md
```

---

## 重要認知

**Tano et al. 2025 並未耦合 MOOSE RANS TH！**
- 論文假設固定均勻溫度場 936K
- 我們做完整 TH 耦合是超越論文的工作

**Sliver Elements 的根本機制：**
- V_i → 0 → A_diag → 0 → 矩陣奇異
- 解法：skewness-corrected（幾何修正）+ Pseudo-Transient（ρV_c/Δt 補充對角線）
- 已驗證有效（v2 run2：3.39e6 → 1.3 m/s）

**[Physics/Turbulence] k-ε 的正確用法：**
- fluid_heat_transfer_physics 必須放在 [turb_physics] 裡，不是 [energy_physics]
- 需要 tke_name, tked_name, turbulence_walls 參數
- 入口 TKE/TKED BC 用 [FVBCs] FVDirichletBC 設定
- 語法通過後自動輸出 mu_t_out, k_t_out

**Cardinal 版本（2025-10 commit）的湍流支援：**
- k-ω SST：不支援（WCNSFVTurbulencePhysics 不存在）
- k-ε via [Physics/Turbulence]：支援，需正確耦合參數
- mixing-length：支援但不適用高 Re 流場

---

## 工具鏈

```bash
~/cardinal/cardinal-opt          # 主執行檔
~/cardinal/contrib/moose/        # MOOSE 框架
~/MSR-project/MSFR/              # MSFR 工作目錄
~/MSR-project/MSFR/stage3_cardinal/  # Stage 3 輸入檔

# 語法驗證
~/cardinal/cardinal-opt --check-input -i th_physics.i 2>&1 | tail -10

# 單獨跑 TH
mpirun -n 16 --mca btl_vader_single_copy_mechanism none \
  ~/cardinal/cardinal-opt -i th_physics.i 2>&1 | tee th_physics_run3.log &

# 監控進度
grep "8.980000e+02" th_physics_run3.log | tail -5
tail -30 th_physics_run3.log

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

1. **【最優先】觀察 run3 結果**
   - max_vel_z 是否穩定（不再發散）
   - mu_t_out 分佈是否物理合理
   - 預期：k-ε 耗散後速度穩定在 ~2-3 m/s

2. **run3 穩定後 → Cardinal run13**
   - 修改 main.i 使用 th_physics.i
   - 撤除 T_clipped 防火牆
   - 驗證 avg_T ~1000K，keff ~1.047

3. **Stage 4**：燃耗循環（openmc.deplete + Thermochimica + Zapdos）
