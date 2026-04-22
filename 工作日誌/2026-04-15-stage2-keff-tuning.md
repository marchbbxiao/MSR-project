# Stage 2 keff 調整結果 - 2026-04-15

## 環境
- 機器：RTXWS（Ubuntu 24.04）
- OpenMC：0.15.4-dev136（Cardinal 內建）
- 截面：ENDF/B-VII.1
- 幾何：msr_reflecting.h5m（boundary:Reflecting）

## 燃料鹽成分（固定）
- Li7: 0.779961 ao
- Li6: 3.9e-5 ao
- F19: 1.66 ao
- Th232: 0.19985 ao
- 密度: 4.1249 g/cm3

## 試驗結果
| U233 ao   | keff              |
|-----------|-------------------|
| 0.02515   | 1.131 ± 0.004     |
| 0.02263   | 1.073 ± 0.003     |
| 0.02135   | 1.047 ± 0.004  ✅ |
| 0.02100   | 1.037 ± 0.004     |

## 結論
- 採用 U233 = 0.02135 ao → keff ≈ 1.047，在目標 1.05 ± 0.005 範圍內
- 邊界條件：Reflecting（100%反射），為 Stage 3 耦合計算的暫用設定
- 下一步：Stage 3 Cardinal OpenMC + MOOSE RANS TH 耦合

## 技術筆記
- RTXWS 無獨立 openmc conda 環境，使用 cardinal/install/bin/openmc
- 需要 mpirun -n 4 --mca btl_vader_single_copy_mechanism none
- cross_sections 要設在 materials.xml，不能在 settings.xml
- DAGMC geometry.xml 寫法：<dagmc_universe id="1" filename="..." auto_geom_ids="true"/>
- PYTHONPATH 設定無效（Python 3.10 不支援 typing.Self）
