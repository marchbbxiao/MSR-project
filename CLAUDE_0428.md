# MSR 耦合模擬專案 — 記憶橋接文件
# 最後更新：2026-04-28

---

## 專案目標

複製並延伸 Tano et al. 2025（Progress in Nuclear Energy 178, 105503）
完整耦合框架：OpenMC + MOOSE RANS TH + Thermochimica + Zapdos PNP

研究者：蕭伯彬（Bruce），INER 核工所
工作機：RTXWS（Ubuntu 24.04，Dual Xeon 32核，2×V100S，IP 192.168.27.190）
Repo：github.com/marchbbxiao/MSR-project（private）

---

## 各階段完成狀態

- ✅ Stage 1：MSRE keff 驗證（k=1.00637±0.00113）
- ✅ Stage 2：MSFR 單獨 OpenMC（k=1.047±0.004，U233=0.02135 ao）
- 🔄 Stage 3：Cardinal OpenMC + MOOSE RANS TH 耦合（進行中）

---

## Stage 3 目前狀態（2026-04-28 晚）

### 工作目錄
```
~/MSR-project/MSFR/stage3_cardinal/
```

### 策略架構（三階段漸進啟動）

```
Phase 1：SIMPLE + Mixing Length（當前）
         目標：建立基本對流場，消除壁面奇異點
         狀態：128 iter，仍在震盪，待解決 mu_t 初始值問題

Phase 2：SIMPLE + k-ε（Phase 1 完成後）
         從 Phase 1 checkpoint 熱啟動
         C_pl=10.0，TKE初始 k=1e-4，ε=1e-6

Phase 3：Cardinal 耦合（Stage 3 最終目標）
         OpenMC 提供功率密度 → MOOSE TH 計算溫度場 → 回傳 OpenMC
```

### 關鍵檔案清單

| 檔案 | 狀態 | 說明 |
|------|------|------|
| `th_stokes.i` | ✅ 完成 | 純 Stokes 流 |
| `th_stokes_checkpoint_cp/0001` | ✅ 完成 | 乾淨熱啟動基底（殘差~1e-6） |
| `th_phase1_from_th.i` | 🔄 進行中 | **明日繼續調試的主力檔案** |
| `th_phase1_simple.i` | 🔄 備用 | 從零建立版本 |
| `th_ml.i` | ⚠️ 棄用 | PJFNK 路徑，dt 惡性循環 |
| `th_run4b_out.e` | ⚠️ 毒井 | k/ε 污染，不作啟動基底 |
| `msr_with_sidesets.e` | ✅ 存在 | 幾何檔（symlink → ../msr_with_sidesets.e） |

---

## 明日第一件事（mu_t 初始值修正）

### 問題根源
Stokes 初始場速度≈0 → mu_t≈0 → 等效純層流 Re=48000
→ SIMPLE 在高 Re 無阻尼下壓力-速度解耦震盪

### 解法：給 mu_t 固定非零初始值

物理估算：Re=48000，μ=0.01127 Pa·s，μt/μ ≈ 50 → μt ≈ 0.56 Pa·s

在 `th_phase1_from_th.i` 的 `[AuxVariables]` 中：
```
[mu_t]
  order = CONSTANT
  family = MONOMIAL
  fv = true
  initial_condition = 0.56   # ← 加入這行！
[]
```

同時確認 `execute_on = 'initial'`（凍結 mu_t，防止反饋震盪）：
```
[compute_mu_t]
  type = INSFVMixingLengthTurbulentViscosityAux
  ...
  execute_on = 'initial'   # ← 確認是 initial，不是 NONLINEAR
[]
```

執行語法驗證：
```bash
~/cardinal/cardinal-opt --check-input -i th_phase1_from_th.i 2>&1 | tail -3
```

執行計算：
```bash
mpirun -n 4 --mca btl_vader_single_copy_mechanism none \
  ~/cardinal/cardinal-opt -i th_phase1_from_th.i 2>&1 | tee th_phase1_from_th3.log &
```

監控（貼數據給 Claude 分析）：
```bash
sleep 30 && grep "Iteration\|Momentum\|Pressure" th_phase1_from_th3.log | tail -20
```

### 判斷成功的標準

```
Momentum 殘差：持續下降趨勢，不再出現 >0.5 的突波
Pressure 殘差：從 1 開始穩定下降，不在 0~1 之間劇烈震盪
目標：100 iter 內 Momentum < 0.01
```

---

## 棄用路徑（不要再嘗試）

1. **PJFNK + Transient**：TKE 負值問題，FV 框架無法設 lower bound，133天不可行
2. **fieldsplit 預條件器**：MOOSE FV 不支援
3. **vinewtonrsls**：FV 框架無法設定 bound
4. **th_run4b_out.e 作為啟動基底**：k/ε 污染

---

## 重要技術細節

### SIMPLE 壓力方程式（正確寫法）
```
# ❌ 錯誤（全耦合用）：
INSFVMassAdvection

# ✅ 正確（SIMPLE 必用）：
FVAnisotropicDiffusion  # ∇⋅(Ainv ∇p')
FVDivergence            # ∇⋅(HbyA)
```

### SIMPLE 標準設定（來自 th.i 驗證版）
```
type = SIMPLENonlinearAssembly
momentum_equation_relaxation = 0.1   # 保守值（高 Re 用）
pressure_variable_relaxation = 0.05  # 保守值
momentum_petsc_options_iname = '-pc_type -pc_hypre_type'
momentum_petsc_options_value = 'hypre boomeramg'
pressure_petsc_options_iname = '-pc_type -pc_hypre_type'
pressure_petsc_options_value = 'hypre boomeramg'
```

### 必要語法結構
```
[Problem]
  nl_sys_names = 'u_system v_system w_system pressure_system'
  previous_nl_solution_required = true

[Variables]
  [vel_x] solver_sys = u_system []/
  [pressure] solver_sys = pressure_system []/

[GlobalParams]
  rhie_chow_user_object = 'rc'

[UserObjects]
  [rc]
    type = INSFVRhieChowInterpolatorSegregated
    ...

[Executioner]
  pressure_gradient_tag = ${pressure_tag}
  momentum_systems = 'u_system v_system w_system'
  pressure_system = 'pressure_system'
```

### 燃料鹽物性
```
rho = 4147.3      # kg/m³
mu  = 0.011266    # Pa·s
bulk_u = 0.130    # m/s（入口速度）
Re ≈ 4.8×10⁴     # 湍流
inlet T = 898 K
target avg T = 936 K
```

### 執行環境
```bash
# Cardinal binary
~/cardinal/cardinal-opt

# 執行指令
mpirun -n 4 --mca btl_vader_single_copy_mechanism none ~/cardinal/cardinal-opt -i [file]

# 截面資料（VII.1）
~/data/cross_sections/endfb-vii.1-hdf5/cross_sections.xml

# 語法驗證
~/cardinal/cardinal-opt --check-input -i [file] 2>&1 | tail -5
```

---

## Phase 2 規劃（備用，Phase 1 完成後執行）

從 Phase 1 checkpoint 熱啟動，加入 k-ε：
```
# th_phase2_ke.i 關鍵設定
TKE 初始值 = 1e-4
TKED 初始值 = 1e-6
C_pl = 10.0           # 生成項限制器，防角點奇異點
turbulence_equation_relaxation = '0.05 0.05'  # 極保守
momentum_equation_relaxation = 0.1
```

---

## 工具指令速查

```bash
# 監控收斂（貼結果給 Claude）
grep "Iteration\|Momentum\|Pressure" [logfile] | tail -30

# 停止計算
pkill -f cardinal-opt
# 或
kill -9 $(pgrep -f cardinal-opt)

# Git 同步
cd ~/MSR-project && git add -A && git commit -m "[msg]" && git push

# 查目前跑什麼
pgrep -af cardinal
```

---

## 開啟新 SESSION 的接頭方式

把這份 CLAUDE.md 的內容貼給 Claude，或說：
「繼續 Stage 3 Phase 1 調試，請讀取 CLAUDE.md」

**今天停在：** th_phase1_from_th.i，128 iter，SIMPLE 壓力-速度震盪
**明天第一步：** 給 mu_t 設定 initial_condition = 0.56

