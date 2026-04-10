# CLAUDE.md — MSR 耦合模擬學習進度快照
更新日期：2026-04-05

---

## 我的學習進度（最新狀態）

### 已完成
- [x] 理解完整耦合框架（Steps 1–11）
- [x] 理解鄧永宏的技術細節
- [x] WSL2 Ubuntu 環境建置完成
- [x] GitHub repo 建立（msre-project + MSFR 各自獨立 repo）
- [x] 階段一：MSRE keff 驗證（k=1.00637 ± 0.00113）
- [x] 階段二開始：MSFR 單獨 OpenMC
  - [x] ANL Tutorial 檔案架構理解
  - [x] CSG vs DAGMC 概念理解
  - [x] DAGMC 材料對應機制（name tag）理解
  - [x] 解決 lost particle 問題（球形粒子分佈 r=70cm）
  - [x] **MSFR 第一個 keff = 0.95438 ± 0.00393（vacuum 邊界）**
  - [x] albedo 邊界條件深度討論，理解為何需要修改 msr.h5m

### 進行中（下一步）
- [ ] 改用鄧永宏成分重跑 keff，目標 ≈ 1.05
  - LiF(50%) – ThF₄(10%) – UF₄(40%)
  - 密度 6.131 g/cc
- [ ] git commit 今日成果到 MSFR repo

### 尚未開始
- [ ] 用 Cubit 修改 msr.h5m albedo 邊界（albedo=0.74）
- [ ] Cardinal 耦合設定（neutronics.i / th.i / main.i）
- [ ] Steps 7–11 燃耗循環

---

## 環境狀態

| 項目 | 狀態 |
|---|---|
| 電腦 | 家用 A 電腦，WSL2 Ubuntu |
| OpenMC | 0.15.3，conda activate openmc |
| 截面庫 | ENDF/B-VIII.0，`~/nuclear_data/endfb-viii.0-hdf5/` |
| MSRE repo | `~/msre-project/`，5 commits |
| MSFR repo | `~/MSFR/`，含 ANL 原始檔 + 今日成果 |
| 工作目錄 | `~/MSFR/results/stage2_msfr_openmc/` |
| Jupyter | `cd ~/MSFR/results/stage2_msfr_openmc && conda activate openmc && jupyter notebook --no-browser --port=8888` |

---

## 關鍵技術理解（今日新增）

### DAGMC 材料對應機制
```python
# msr.h5m 裡有 mat:1 這個 tag
# OpenMC 用 Material 的 name 屬性對應
salt = openmc.Material(name='1')  # name='1' 對應 mat:1
```

### Lost Particle 問題解法
```python
# 錯誤：立方體分佈，角落落在空白區域
lower_left = (-100, -100, -100)
upper_right = (100, 100, 100)

# 正確：球形分佈，r=70cm < 最小節點距離 80cm
settings.source = openmc.IndependentSource(
    space=openmc.stats.SphericalIndependent(
        r=openmc.stats.Uniform(0, 70),
        cos_theta=openmc.stats.Uniform(-1, 1),
        phi=openmc.stats.Uniform(0, 2*openmc.pi)
    )
)
```

### msr.h5m 幾何尺寸
```
X: -215.7 ~ 215.7 cm
Y: -132.6 ~ 132.6 cm（Y 方向較扁）
Z: -215.7 ~ 215.7 cm
幾何中心：(0, 0, 0)
從中心到節點最小距離：80.0 cm
```

### albedo 邊界的限制
- `msr.h5m` 內部有 `boundary:Vacuum`，粒子在內部就消失
- 外層包 CSG 球設 `boundary_type='white'` **無效**
- 要真正套用 albedo=0.74，必須用 Cubit 修改 `msr.h5m`
- 鄧永宏的暫時做法：高濃縮鈾 + 高密度補償洩漏

### k-eff 偏低的三個原因
1. Vacuum 邊界 → Leakage Fraction = 12.8%（正常應 <5%）
2. 鈾濃度低（U233=2.515% vs UF₄=40%）
3. 密度低（4.12 vs 6.131 g/cc）

---

## 今日重要思辨

**「粒子落在幾何外」vs「落在空白區域」的區別**
- 幾何邊界 ±215 cm，粒子撒在 ±100 cm → 粒子在幾何「內部」
- 但爐心是特定形狀，±100 cm 立方體的角落沒有材料定義
- 這些「空白區域」讓 OpenMC 找不到對應的 cell → lost particle

**albedo 邊界為何無法從 Python 端覆蓋**
- DAGMC 內部的 boundary:Vacuum 優先順序高於外層 CSG
- 這是 DAGMC 和 CSG 混用時的邊界優先順序問題
- 根本解法只有修改 h5m 本身

---

## 下次對話開場建議

「上次完成了 MSFR 第一個 keff 計算（0.95438，vacuum 邊界），
理解了 albedo 邊界需要修改 msr.h5m。
下一步是改用鄧永宏的成分（LiF 50%+ThF₄ 10%+UF₄ 40%，6.131 g/cc）
重跑 keff，驗證能否重現 ≈1.05。」
