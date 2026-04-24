# MSR 專案 CLAUDE.md（更新：2026-04-24）

## 當前進度

### Stage 3：Cardinal OpenMC + MOOSE RANS TH 耦合
工作目錄：`~/MSR-project/MSFR/stage3_cardinal/`

### TH 求解器狀態（2026-04-24）

#### 已確認的物理事實
- MSFR 球形幾何，Re~446,000，底部 16 個射流形成強烈 Flip-Flop 震盪
- 穩態 SIMPLE 極限：momentum ~1e-2（iter ~200，momentum relaxation=0.1）
- 物理上流場具有瞬態不穩定性，穩態求解器無法完全收斂

#### Continuation Method 結果
| Run | U_in | k IC | ε IC | momentum relax | 最佳 momentum | 狀態 |
|-----|------|------|------|----------------|--------------|------|
| Run1 | 0.01 m/s | 3.75e-7 | 3.87e-10 | 0.1 | - | TKED 除以零崩潰 |
| Run2 | 0.1 m/s | 3.75e-4 | 3.87e-6 | 0.1 | ~1e-1 | TKE 首次收斂 |
| Run3 | 0.1 m/s | 同上 | 同上 | 0.3 | ~1e-1 | TKE=1e-6 ✅ |
| Run4 | 0.1 m/s | 同上 | 同上 | 0.1 | **~1e-2** ✅ | Flip-Flop 極限 |
| Run4b | 同上 | 同上 | 同上 | 0.1 | ~1e-2 | 200步正常結束，有 exodus |

#### 關鍵輸出檔
- `th_run4b_out.e`：Run 4b 最終流場（3.6MB），包含 vel_x/y/z, pressure, TKE, TKED, mu_t, yplus, power_density

#### Transient 求解器狀態
- `th_transient.i`：從 `th_run4b_out.e` 讀取初始場的 Transient Newton/PJFNK 版本
- 卡關：初始殘差固定 **6.004574e+03**（SIMPLE 壓力場與 Newton 框架不相容）
- 已嘗試：NEWTON+lu（記憶體爆炸）、NEWTON+hypre（6004）、PJFNK+ASM（6004）
- **根本問題**：SIMPLE 壓力 = Poisson 修正框架，Newton 壓力 = INSFVMassAdvection 框架
- **Gemini 未回覆**：壓力方程式正確寫法？是否冷啟動 pressure？

## 明天繼續的工作

### 優先事項：等待 Gemini 回覆
問題已送出：
1. Transient 壓力方程式正確寫法（INSFVMassAdvection 是否正確？）
2. 只用 velocity 作初始場，pressure 冷啟動？
3. 完全冷啟動 Transient？
4. 直接用 Run 4 結果進行 OpenMC-MOOSE 耦合的可行性？

### 根據 Gemini 回覆執行
- 如果建議修改壓力 kernel：修改 th_transient.i 並重跑
- 如果建議冷啟動：移除 pressure 的 initial_from_file_var
- 如果確認需要 Time-Averaged 耦合：研究 Transient TH + 時間平均策略

## 重要參數

### 燃料鹽物性（U=0.1 m/s）
- ρ = 4147.3 kg/m³，μ = 0.011266 Pa·s
- k IC = 3.75e-4 m²/s²，ε IC = 3.87e-6 m²/s³（I=5%，L=0.1m）
- Re = ρ×U×L/μ ≈ 38,000（U=0.1 m/s 時）
- Re = ρ×U×L/μ ≈ 446,000（U=1.1838 m/s 全載時）

### th_transient.i 當前設定
- Executioner：Transient，PJFNK，ASM+ilu，dt=1e-4
- 初始場：全部從 th_run4b_out.e 讀取（vel_x/y/z, pressure, TKE, TKED, mu_t）
- 時間項：vel_x/y/z 的 INSFVMomentumTimeDerivative 已啟用
- 壓力方程式：INSFVMassAdvection（可能是問題所在）
- Rhie-Chow：INSFVRhieChowInterpolator（已確認非 Segregated 版）

## 路徑與指令

### 常用指令
```bash
# 跑 TH 計算
cd ~/MSR-project/MSFR/stage3_cardinal
mpirun -n 4 --mca btl_vader_single_copy_mechanism none ~/cardinal/cardinal-opt -i th_transient.i 2>&1 | tee th_transient_NEW.log

# 監視 Transient 收斂
watch -n 5 'grep -E "Time Step|Nonlinear \|R\||converged|invalid|dt =" th_transient_NEW.log | tail -15'

# 監視 SIMPLE 收斂
python3 monitor.py th_NEW.log
```

### 關鍵路徑
- Cardinal：`~/cardinal/cardinal-opt`
- 截面：`~/data/cross_sections/endfb-vii.1-hdf5/cross_sections.xml`
- Mesh：`~/MSR-project/MSFR/msr_with_sidesets.e`
- exodus 初始場：`~/MSR-project/MSFR/stage3_cardinal/th_run4b_out.e`

## 學習重點（今日）

### SIMPLE vs Transient Newton 的根本差異
- SIMPLE：分離式求解，每次只解一個小系統（35,186 DOF），壓力用 Poisson 修正方程
- Transient Newton：全耦合求解，一次解所有變數（211,116 DOF），壓力用連續方程式
- 兩者的壓力場定義不同，無法直接互換初始條件

### Continuation Method 原理
- 從低 Re 出發，逐步升速至目標 Re
- k/ε 必須隨速度縮放：k ∝ U²，ε ∝ U³
- Re < 10,000 時，k-ε（High-Re Model）不適用

### Flip-Flop 震盪
- 球形爐心 16 個射流匯聚時，渦流核心跨越兩個相鄰網格
- SIMPLE 每次迭代把渦流推到 A，下次踢到 B，來回震盪
- 解法：Transient 求解器讓渦流隨時間自然演化
