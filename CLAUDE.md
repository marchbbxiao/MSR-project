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

### 明日診斷計劃（最優先）
**暫時移除能量方程式，先確認純流場能收斂**：

在 th.i 中：
1. `[Variables]` 移除 T_fluid（或將其 solver_sys 改為不存在的系統）
2. `[FVKernels]` 用 # 停用 energy_advection、energy_diffusion、energy_source
3. `[FVBCs]` 用 # 停用 inlet_T
4. `[Problem]` nl_sys_names 移除 energy_system
5. `[Executioner]` 移除所有 energy_* 參數
6. `[FunctorMaterials]` 可暫時保留或移除

執行：
```bash
cd ~/MSR-project/MSFR/stage3_cardinal
mpirun -n 4 --mca btl_vader_single_copy_mechanism none ~/cardinal/cardinal-opt -i th.i 2>&1 | tee th_pure_flow.log | tail -20
```

若純流場收斂 → 逐步加回能量方程式

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
## 2026-05-09 A電腦調試記錄（補充 Stage 3 狀態）

### 本日工作摘要
在 A電腦（家用，4核 WSL2）繼續 Phase 1 SIMPLE 調試。
承接 RTXWS 的 th_phase1_from_th.i，進行 6 次系統性測試。

### 關鍵物理認知更新

**μt 初始值策略（Mixing Length 模型）：**
- 0.162 Pa·s：k-ε 公式，與 Mixing Length 不自洽，已棄用
- 0.56 Pa·s：Re 經驗關係（μt/μ≈50），Re_eff=940，仍震盪
- 5.6 Pa·s：μt/μ≈500，Re_eff≈96，當前使用

**Re_eff 公式：**
Re_eff = Re / (1 + μt/μ) = 48000 / (1 + 500) ≈ 96

**execute_on 機制：**
- NONLINEAR：每步重算，Stokes 熱啟動場速度≈0 → μt 第一步被覆蓋歸零
- INITIAL：只算一次，凍結 μt 在設定值
- 當前設定：execute_on = 'INITIAL'

### 六次測試結果摘要

| Test | momentum | pressure | mu_t | 崩潰時間 | 關鍵發現 |
|------|----------|----------|------|----------|----------|
| 1 | 0.1 | 0.05 | 0.162/NONLINEAR | iter ~15 | mu_t 被覆蓋歸零 |
| 2 | 0.1 | 0.05 | 5.6/INITIAL | iter 16 | Momentum 改善 |
| 3 | 0.1 | 0.05 | 5.6 + l_tol修正 | iter 15 | 線性容忍值無效 |
| 4 | 0.1 | 0.05 | LU 診斷 | iter 8 | 確認元兇為動量過衝 |
| 5 | 0.01 | 0.05 | 5.6 | iter 21 | Momentum ↓一個數量級 |
| 6 | 0.01 | 0.01 | 5.6 | iter 18 | 更早崩潰（反直覺）|

### 未解決問題（待 Gemini 診斷）

每次崩潰前的固定模式：
```
某特定 iter：Momentum 三分量同時暴衝至 0.5~0.9
             Pressure 同步出現極低谷（1e-8~1e-10）
→ 降低鬆弛因子無法解決
→ 疑為 Stokes 初始場局部奇異點觸發 A_inv 爆炸
```

### 當前 th_phase1_from_th.i 設定（最新）

```
mu_t initial_condition = 5.6
execute_on = 'INITIAL'
momentum_equation_relaxation = 0.01
pressure_variable_relaxation = 0.01
momentum_l_tol = 1e-6
momentum_l_abs_tol = 1e-10
pressure_l_tol = 1e-6
pressure_l_abs_tol = 1e-10
pressure_petsc: hypre boomeramg
momentum_petsc: hypre boomeramg
```

### 新增工具
- `monitor.py`：修改為 Phase 1 版本（Pressure 觸發，移除 TKE/TKED）

## 2026-05-10 奇異點診斷（A電腦）

### 重大發現：iter 15 固定爆炸的根本原因
- MOOSE 內部保護機制：前 14 iter 壓制對流項高階修正，iter 15 解除
- 與 Ramping、鬆弛因子無關，硬寫在程式碼中
- iter 15 殘差永遠相同：Momentum 0.994, 0.999, 0.969 / Pressure 1.65e-10

### 奇異點位置（ParaView 確認）
- 位置：爐心側面壁面中間高度
- 類型：凹角（Re-entrant Corner）奇異點
- 具體：入口通道（gap_enter_boundary）切割球形壁面（wall）的垂直溝槽交界處
- 速度值：6.7e+45 m/s（單一 Sliver element 網格）
- 診斷檔案：MSFR/stage3_cardinal/th_phase1_from_th_exodus_out.e（iter 14 快照）

### 崩潰物理機制
凹角導致 Sliver element（極扁四面體），體積極小：
A_diag ∝ 面積/體積 → 0
A_inv = 1/A_diag → ∞
壓力修正量 p' → inf → overflow

### 已嘗試但無效的方法
- lower_bound/upper_bound：INSFVVelocityVariable 不支援（unused parameter）
- Velocity Ramping：推遲 2 iter，無法避開 iter 15
- 降低鬆弛因子（αm=0.01, αp=0.01）：αm+αp 太小導致壓力速度脫節，更早崩潰
- LU 直接求解器：語法問題，壓力殘差全為 0

### 鬆弛因子耦合原理（重要）
αm + αp ≈ 1 是 SIMPLE 穩定的必要條件
αp 太小 → 壓力修正不足 → 質量誤差累積 → A_diag→0 → overflow
兩者都壓低（0.01/0.01）→ 壓力速度脫節，反而更早崩潰

### 明日任務（RTXWS）
1. 等 Gemini 確認 ParsedFunctorMaterial 語法後，實作人工阻尼（橡皮牆）
   - vel > 5.0 m/s → drag = -1e5 × velocity
   - 壓制 Sliver element 的速度暴衝
2. num_iterations 恢復 1000，測試能否跑超過 iter 15
3. 治本方案：Cubit 對凹角施加幾何倒角（Fillet），重切網格
   - 工具：Coreform Cubit 2026.4（/opt/Coreform-Cubit-2026.4/bin/coreform_cubit）
   - 目標：消除入口通道與球壁交界處的銳角

## 2026-05-10 晚間補充：人工阻尼語法確認（Gemini v4 回覆）

### 明日實作內容（RTXWS 優先）

**Step 1：在 [FunctorMaterials] 加入三個阻尼材料**

```
[FunctorMaterials]
  [drag_calc_x]
    type = ParsedFunctorMaterial
    property_name = 'drag_force_x'
    expression = 'vel_mag := sqrt(vel_x^2 + vel_y^2 + vel_z^2); if(vel_mag > 5.0, -1e5 * vel_x, 0.0)'
    functor_names = 'vel_x vel_y vel_z'
  []
  [drag_calc_y]
    type = ParsedFunctorMaterial
    property_name = 'drag_force_y'
    expression = 'vel_mag := sqrt(vel_x^2 + vel_y^2 + vel_z^2); if(vel_mag > 5.0, -1e5 * vel_y, 0.0)'
    functor_names = 'vel_x vel_y vel_z'
  []
  [drag_calc_z]
    type = ParsedFunctorMaterial
    property_name = 'drag_force_z'
    expression = 'vel_mag := sqrt(vel_x^2 + vel_y^2 + vel_z^2); if(vel_mag > 5.0, -1e5 * vel_z, 0.0)'
    functor_names = 'vel_x vel_y vel_z'
  []
[]
```

**Step 2：在 [FVKernels] 加入三個 Body Force**

```
[rubber_wall_x]
  type = INSFVBodyForce
  variable = vel_x
  functor = drag_force_x
[]
[rubber_wall_y]
  type = INSFVBodyForce
  variable = vel_y
  functor = drag_force_y
[]
[rubber_wall_z]
  type = INSFVBodyForce
  variable = vel_z
  functor = drag_force_z
[]
```

**Step 3：Executioner 參數恢復**

```
num_iterations = 1000
momentum_equation_relaxation = 0.5
pressure_variable_relaxation = 0.3
```

### 人工阻尼物理原理
INSFVBodyForce 加在動量方程右側：
ρ Dv/Dt = -∇p + ∇·[(μ+μt)∇v] + ρg + F_body

當 vel_mag > 5.0 m/s：F_body = -1e5 × velocity（巨大反向阻力）
當 vel_mag ≤ 5.0 m/s：F_body = 0（不干擾正常流場）

效果：Sliver element 在 iter 15 想暴衝時，瞬間撞上橡皮牆被壓回 5 m/s 以內
→ A_diag 不會趨近於零 → A_inv 不會爆炸 → SIMPLE 可以繼續跑

### 語法注意事項
- ParsedFunctorMaterial 每個區塊只能定義一個 property_name（不能同時輸出多個）
- INSFVBodyForce 的 functor 可以直接引用 FunctorMaterial 的 property_name
- 不需要透過 ParsedAux 轉存 AuxVariable
