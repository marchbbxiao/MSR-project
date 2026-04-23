# MSR 耦合模擬專案 — CLAUDE.md
# 最後更新：2026-04-22 晚

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
- Cardinal 安裝位置：`~/cardinal`（非 ~/MSR-project/cardinal）
- OpenMC 執行：`mpirun -n 4 --mca btl_vader_single_copy_mechanism none openmc`
- 截面資料庫：ENDF/B-VII.1，路徑 `~/data/cross_sections/endfb-vii.1-hdf5/`
- conda env：`moose`（`conda activate moose`）
- `~/.bashrc` 含 NEKRS_HOME、cardinal/install/bin in PATH、msr-sync alias

### A電腦（次要/測試）
- Windows 11 + WSL2 Ubuntu 22.04，username=bruce
- Cardinal b1e271b638，ENABLE_NEK=false，614/614 tests passing

---

## 目前進度

### Stage 1：MSRE keff 驗證 ✅
- keff = 1.00637 ± 0.00113
- 幾何：msre_full.h5m（309MB DAGMC）
- 截面：ENDF/B-VIII.0
- 執行時間：~2.7hr

### Stage 2：MSFR 單獨 OpenMC ✅（2026-04-15 完成）
- 最終燃料鹽成分：
  - U233=0.02135 ao, Li7=0.779961, Li6=3.9e-5
  - F19=1.66, Th232=0.19985, density=4.1249 g/cm³, T=898K
- 幾何：msr_reflecting.h5m（boundary: Reflecting）
- keff = 1.047 ± 0.004
- Batches=100（50 inactive + 50 active），particles=1000
- 工作目錄：`~/MSR-project/MSFR/`
- 重要檔案：msr.h5m、msr.e、msr_reflecting.h5m、msr_white.h5m

### Stage 3：Cardinal 耦合 — 進行中 🔧

#### 目前工作目錄
`~/MSR-project/MSFR/stage3_cardinal/`

#### 已完成的檔案
- `neutronics.i`：OpenMC 中子學輸入檔（已完成）
- `th.i`：MOOSE RANS TH 熱流輸入檔（語法驗證通過，運行調試中）
- `~/MSR-project/MSFR/msr_with_sidesets.e`：正確的網格（含3個 side sets）

---

## th.i 目前狀態（最重要）

### 架構
SIMPLE 穩態求解器（SIMPLENonlinearAssembly），7個獨立求解系統：
- u_system（vel_x）、v_system（vel_y）、w_system（vel_z）
- pressure_system、TKE_system、TKED_system、energy_system

### 已完成的區塊
- [GlobalParams]：rhie_chow='rc', advected_interp_method='upwind'
- [Problem]：type=FEProblem, nl_sys_names 7個系統
- [UserObjects]：INSFVRhieChowInterpolatorSegregated
- [Variables]：7個變數，各有 solver_sys + two_term_boundary_expansion=false
- [AuxVariables]：power_density（0.0）、mu_t（0.162）、yplus
- [AuxKernels]：kEpsilonViscosityAux（mu_t）、RANSYPlusAux（yplus）
- [FVKernels]：完整 25+ kernels（質量/動量/能量/TKE/TKED）
- [FunctorMaterials]：INSFVEnthalpyFunctorMaterial（提供 rho_h）
- [FVBCs]：入口/出口/壁面三類邊界條件
- [Executioner]：SIMPLENonlinearAssembly

### 關鍵 kernel 對應（易混淆的地方）
- 質量守恆：FVAnisotropicDiffusion + FVDivergence（不是 INSFVMassAdvection）
- 能量擴散：FVDiffusion（INSFVEnergyDiffusion 在此版本不存在）
- 能量源項：FVCoupledForce（INSFVBodyForce 只能用於動量）
- 動量擴散：兩個 kernel（μ 和 μt 分開）
- TKE/TKED 時間項：已用 # 註解停用（SIMPLE 穩態不需要）
- 棄用參數：k=TKE → tke=TKE（kEpsilonViscosityAux 等）

### 運行測試歷史
1. relaxation=0.7 → Iter ~50 發散（inf）
2. relaxation=0.5 → Iter 92 壓力震盪後發散
3. relaxation=0.3/0.1 → 不發散但收斂慢，後來再次發散

### 發散根本原因（2026-04-23 確認）
**冷啟動 + 對流項非線性** 是發散根源：
- 全零初始條件下，ρ(v·∇)v 在 v≈0 時不穩定
- NekRS tutorial 用 restart.fld 熱啟動，我們需要同樣策略

### 診斷結果
- th_pure_flow.i（無能量）→ 仍發散，能量方程式無關
- th_laminar.i（無湍流）→ 仍發散，對流項是問題
- th_stokes.i（無對流）→ **收斂！** 1000 iter，殘差 ~1e-6
- Checkpoint：th_stokes_checkpoint_cp/0001

### 下一步
1. th_laminar.i 加入 restart_file_base = 'th_stokes_checkpoint_cp/0001'
2. 跑含對流項層流，觀察收斂
3. 層流收斂 → 加回湍流
4. 湍流收斂 → 加回能量方程式

---

## 網格資訊

### msr_with_sidesets.e
- 由 `~/MSR-project/MSFR/read_mesh.py` 從 `msr.e` 產生
- 格式：Exodus II，TETRA4 元素，9245 nodes，35186 elements
- **三個 side sets（面集合）**：
  - `gap_exit_boundary`：334 個面（上方截斷面，Z > 0）→ 出口
  - `gap_enter_boundary`：336 個面（下方截斷面，Z < 0）→ 入口
  - `wall`：11304 個面（球形爐心外壁）→ 壁面
- ⚠️ 之前的版本只有 node sets，已修正為 side sets

---

## 燃料鹽物性（th.i 使用）

來源：Rouch et al. 2014，ANL Cardinal tutorial
- rho = 4147.3 kg/m³
- mu = 0.011266321 Pa·s
- cp = 1524.86 J/kg/K
- k = 1.0 W/m·K（暫用）
- 入口速度 = 1.1838 m/s（+z 方向）
- 入口溫度 = 898 K，目標平均 936 K

---

## 重要認知

**Tano et al. 2025 並未耦合 MOOSE RANS TH！**
- 論文假設固定均勻溫度場 936K
- 實際耦合：OpenMC + Thermochimica + Zapdos PNP
- 我們做完整 TH 耦合是超越論文的工作，物理更正確但數值更困難

**SIMPLE 求解器原則：**
- 求解穩態，不需要時間項（TimeDerivative kernel 會報錯）
- 鬆弛因子控制收斂穩定性（目前用 momentum=0.3, pressure=0.1, turbulence=0.1）
- 未來事故暫態分析才需要改用 Transient executioner

---

## 工具鏈

### Cardinal 測試結果（RTXWS）
- Cardinal：783/815（32個失敗集中在 relaxation/triggers 系列）
- Thermochimica：77/77（需加 --cli-args "Problem/type=FEProblem"）
- Zapdos：58/62

### 重要路徑
```bash
~/cardinal/cardinal-opt          # 主執行檔
~/cardinal/contrib/moose/        # MOOSE 框架
~/data/cross_sections/endfb-vii.1-hdf5/  # 截面資料庫
~/MSR-project/MSFR/              # MSFR 工作目錄
~/MSR-project/MSFR/stage3_cardinal/  # Stage 3 輸入檔
```

### 語法驗證指令
```bash
~/cardinal/cardinal-opt --check-input -i th.i 2>&1 | head -50
```

### 關鍵 MOOSE 參考範本
```
~/cardinal/contrib/moose/modules/navier_stokes/test/tests/finite_volume/ins/turbulence/channel/segregated/channel_ERCOFTAC.i
```
（作者是 Dr. Mauricio Tano，與論文同一人）

---

## GitHub

Repo：marchbbxiao/MSR-project（private）
日常同步：`msr-sync` alias（git add -A && commit && push）

---

## 下一步（優先順序）

1. **【明日最優先】** 純流場診斷版 th.i，移除能量方程式
2. 若純流場收斂 → 加回能量方程式
3. 若仍不收斂 → 考慮改善網格（四面體品質）或初始條件
4. th.i 收斂後 → 開始寫 neutronics.i（OpenMC Cardinal 版本）
5. 兩者都收斂後 → 寫 main.i 耦合（MultiApp + Transfers + Picard 迭代）
6. 最後 → 加入 Thermochimica 和 Zapdos（Steps 8a/8b）

---

## 教學工具

`~/MSR-project/MSFR/note/NS_RANS_ke_完整教學工具_v4.html`
（v4 尚未上傳 repo，需從昨天的 Claude 對話下載）
