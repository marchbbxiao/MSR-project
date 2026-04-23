# 工作日誌：A電腦 Cardinal 完整安裝與驗證

**日期：** 2026-04-12  
**環境：** A電腦（Windows + WSL2 Ubuntu 22.04），`moose` conda 環境  
**目標：** 完成 Cardinal 編譯（`ENABLE_NEK=false`）並通過驗證測試  
**最終結果：** ✅ `cardinal-opt` 編譯成功，614/614 測試通過，0 失敗

---

## 背景（接續 20260411）

前次已完成：
- Zapdos 單獨編譯 ✓
- Thermochimica 原始碼兩處 Fortran 修復 ✓
- `CardinalApp.C` 加入 ZapdosApp 整合 ✓
- `ENABLE_NEK=false` 可繞過 NekRS cmake 相容性問題（cmake 4.x 不相容）✓

本次目標：完成 Cardinal 主體的最後連結，產出可執行的 `cardinal-opt`，並跑驗證測試。

---

## 遭遇的坑、發現過程與解決方式

### 坑 1：DAGMC build 目錄殘留導致重建失敗

**現象：**  
重新執行 `make -j4 ENABLE_NEK=false` 時，DAGMC 的 cmake 步驟報錯，無法正常進入編譯。

**發現方式：**  
看 make 輸出，cmake configure 階段就失敗，錯誤指向 `build/DAGMC/` 目錄內的快取衝突。

**原因：**  
前次中途中斷的 build 在 `build/DAGMC/` 留下不一致的 cmake 快取。

**解決方式：**  
```bash
rm -rf ~/MSR-project/cardinal/build/DAGMC
make -j4 ENABLE_NEK=false
```

**教訓：** cmake 子目錄出現莫名錯誤時，優先刪除對應的 `build/<component>` 目錄再重建。

---

### 坑 2：連結階段大量 `undefined reference`（MOOSE ABI 不相容）

**現象：**  
Cardinal 主體編譯完成後，`Linking Executable cardinal-opt` 時出現數十個錯誤：
```
libzapdos-opt.so: undefined reference to `vtable for AuxKernelBase'
libzapdos-opt.so: undefined reference to `vtable for UserObjectBase'
libzapdos-opt.so: undefined reference to `AppFactory::registerAppCapability(...)'
libsquirrel-opt.so: undefined reference to `libMesh::System::n_variable_groups() const'
```

**發現方式：**  
連結步驟最後出現 `collect2: error: ld returned 1 exit status`，往上看到大量 `undefined reference to vtable`，這是 ABI 不相容的典型特徵。

**原因：**  
20260411 單獨在 `contrib/zapdos/` 執行 `make` 時，Zapdos 使用了**自己的 `contrib/moose` submodule**（版本不同）。Cardinal 連結時使用的是**自己的 `contrib/moose`**，兩者 C++ vtable 符號不一致，產生 ABI 衝突。

識別特徵：
- 大量 `undefined reference to 'vtable for ...'`
- 大量 `non-virtual thunk to ...`
- 涉及 MOOSE 核心類別（`AuxKernelBase`、`UserObjectBase`、`Material` 等）

**解決方式：**  
用 **Cardinal 的 MOOSE** 重新編譯 Zapdos：
```bash
cd ~/MSR-project/cardinal/contrib/zapdos
MOOSE_DIR=~/MSR-project/cardinal/contrib/moose make -j4
```

**核心教訓（最重要）：**
> **MOOSE ABI 一致性原則：** Cardinal 所有 contrib（Zapdos、Thermochimica 等）必須由同一份 `contrib/moose` 統一編譯。嚴禁在 contrib 子目錄單獨 `make`，除非明確指定 `MOOSE_DIR`。

---

### 坑 3：`make clean` 後 `ZapdosApp.h: No such file or directory`

**現象：**  
嘗試修復 ABI 問題時，先對 Zapdos 執行 `make clean`，再直接對 Cardinal 執行 `make`：
```
fatal error: ZapdosApp.h: No such file or directory
```

**發現方式：**  
Cardinal 編譯階段第一個 unity 檔就報 include 找不到。

**原因：**  
`make clean` 清除了 `contrib/zapdos/build/header_symlinks/`。MOOSE 建置系統依賴這些 symlink 讓 Cardinal 找到 Zapdos 標頭檔，清除後未重建就會消失。

**解決方式：**  
`make clean` 後必須先重建 Zapdos（含 symlink 重建），才能建 Cardinal：
```bash
# 步驟 1：重建 Zapdos（含 header symlinks）
cd ~/MSR-project/cardinal/contrib/zapdos
MOOSE_DIR=~/MSR-project/cardinal/contrib/moose make -j4

# 步驟 2：建 Cardinal
cd ~/MSR-project/cardinal
make -j4 ENABLE_NEK=false
```

**教訓：** 對 contrib 執行 `make clean` 後，不能直接跳上層 `make`，必須先重建該 contrib。

---

### 坑 4：`run_tests` 因缺少 Python 套件無法啟動

**現象：**  
```
No module named 'numpy'
KeyError: 'RunParallel'
```

**原因：**  
`moose` conda 環境預設未安裝 MOOSE TestHarness 所需的 Python 套件。

**解決方式：**  
```bash
conda install numpy pandas matplotlib scipy h5py -y
```

---

### 坑 5：測試套件要求 ENDF/B-VII.1，用 VIII.0 跑全部失敗

**現象：**  
設定 `OPENMC_CROSS_SECTIONS` 指向 ENDF/B-VIII.0 後跑測試，出現 218 個 CSVDIFF/EXODIFF 失敗。

**發現方式：**  
單獨跑一個測試加 `-v`，看到明確訊息：
```
Cardinal's test suite must be run with the ENDF/B-7.1 library.
```

**原因：**  
Cardinal 的 gold file（標準答案）全部是用 ENDF/B-VII.1 產生的，用不同版本的截面資料庫跑出來的數值會不一致。

**解決方式：**  
下載 ENDF/B-VII.1 並切換：
```bash
# 使用 Cardinal 提供的腳本
cd ~/MSR-project/cardinal
./scripts/download-openmc-cross-sections.sh

# 或手動下載（ANL Box）
wget https://anl.box.com/shared/static/9igk353zpy8fn9ttvtrqgzvw1vtejoz6.xz
tar -xf 9igk353zpy8fn9ttvtrqgzvw1vtejoz6.xz -C ~/nuclear_data/

# 設定環境變數
export OPENMC_CROSS_SECTIONS=~/nuclear_data/endfb-vii.1-hdf5/cross_sections.xml
```

**教訓：**
- **Stage 1 MSRE keff**：用 ENDF/B-VIII.0
- **Cardinal 測試套件**：必須用 ENDF/B-VII.1
- **Stage 2 MSFR**：用 ENDF/B-VII.1（配合鄧永宏）
- 兩個版本都要裝，用環境變數切換

---

## 最終成功的建置流程（完整版）

```bash
# 前提：已完成 20260411 的修復
# - Thermochimica ModuleThermoTolerance.f90 去除 #ifndef 區塊
# - Thermochimica ModuleThermoIO.f90 第 58 行加入 OUTPUT_DIRECTORY 宣告
# - CardinalApp.C 加入 ZapdosApp.h include 與 ZapdosApp::registerAll

# 1. 安裝 Python 套件
conda install numpy pandas matplotlib scipy h5py -y

# 2. 清除 DAGMC 殘留 cache（如有需要）
rm -rf ~/MSR-project/cardinal/build/DAGMC

# 3. 用 Cardinal 的 MOOSE 重建 Zapdos（ABI 一致性）
cd ~/MSR-project/cardinal/contrib/zapdos
MOOSE_DIR=~/MSR-project/cardinal/contrib/moose make -j4

# 4. 建置 Cardinal 主體（無 NekRS）
cd ~/MSR-project/cardinal
make -j4 ENABLE_NEK=false 2>&1 | tee ~/MSR-project/cardinal_build_final.log

# 5. 驗證可執行檔
ls -lh ~/MSR-project/cardinal/cardinal-opt
~/MSR-project/cardinal/cardinal-opt --version

# 6. 下載 ENDF/B-VII.1（Cardinal 測試需要）
export OPENMC_CROSS_SECTIONS=~/nuclear_data/endfb-vii.1-hdf5/cross_sections.xml

# 7. 跑驗證測試
./run_tests -j4 --max-fails 500 2>&1 | tee ~/MSR-project/cardinal_tests.log | tail -10
```

---

## 驗證測試結果

### 截面版本對比

| 截面版本 | 通過 | 跳過 | 失敗 |
|---|---|---|---|
| ENDF/B-VIII.0（錯誤）| 395 | 253 | 218 |
| ENDF/B-VII.1（正確）| **614** | 252 | **0** |

### 與鄧永宏對比

| | 鄧永宏（RTXWS） | A電腦（WSL2） |
|---|---|---|
| 通過 | 816 | 614 |
| 失敗 | 14 (CSVDIFF) | 0 |
| 跳過 | — | 252 |

差異說明：
- 跳過的 252 個主要是 `min_cpus=2` 的多核測試（WSL2 MPI 限制）與 NekRS 相關測試
- 鄧永宏的 14 個 CSVDIFF 失敗在 A電腦版本中反而全部通過（OpenMC 版本差異）
- 功能層面：**A電腦 Cardinal 驗證完全通過**

### 編譯結果

```
-rwxr-xr-x 1 bruce bruce 67K Apr 12 16:51 cardinal-opt
Application Version: b1e271b638
```

已啟用模組：CHEMICAL_REACTIONS, ELECTROMAGNETICS, FLUID_PROPERTIES, HEAT_TRANSFER, NAVIER_STOKES（含 RANS）, RAY_TRACING, REACTOR, SOLID_MECHANICS, SOLID_PROPERTIES, STOCHASTIC_TOOLS, SUBCHANNEL, THERMAL_HYDRAULICS

---

## A電腦環境完整狀態總結（截至 2026-04-12）

| 元件 | 狀態 | 版本/備註 |
|---|---|---|
| OpenMC | ✅ | 0.15.3（conda openmc 環境） |
| Cardinal | ✅ | b1e271b638，ENABLE_NEK=false |
| MOOSE RANS | ✅ | NAVIER_STOKES 模組已啟用 |
| Thermochimica | ✅ | 原始碼兩處修復後通過 77/77 |
| Zapdos | ✅ | 需用 Cardinal MOOSE 重編 |
| NekRS | ❌ | cmake 4.x 不相容，跳過 |
| ENDF/B-VIII.0 | ✅ | Stage 1 MSRE 使用 |
| ENDF/B-VII.1 | ✅ | Stage 2 MSFR + Cardinal 測試使用 |
| Docker Desktop | ✅ | WSL2 整合 |
| GitHub 同步 | ✅ | marchbbxiao/MSR-project |

---

## RTXWS 建置預備清單（明天）

根據 A電腦的經驗，RTXWS 建置前必須確認：

1. **cmake 版本**：先檢查 `cmake --version`，若 ≥ 4.0 必須先降版（安裝 cmake 3.22）
2. **MOOSE conda 環境**：確認 `moose` env 存在且 activated
3. **Python 套件**：預先安裝 `numpy pandas matplotlib scipy h5py`
4. **Zapdos 編譯順序**：必須在 Cardinal make 之前，用 `MOOSE_DIR` 指定
5. **Thermochimica 修復**：兩個 Fortran 檔案的修復必須在 make 之前套用
6. **CardinalApp.C**：確認 ZapdosApp 整合程式碼已加入
7. **截面資料庫**：兩個版本都要下載（VII.1 和 VIII.0）
8. **ENABLE_NEK**：RTXWS 有 V100S GPU，可以嘗試 `ENABLE_NEK=yes`

### RTXWS 建置指令（預計）

```bash
# 確認 cmake 版本
cmake --version  # 若 >=4.0，先降版

# 若需降版
wget https://github.com/Kitware/CMake/releases/download/v3.22.1/cmake-3.22.1-linux-x86_64.tar.gz
tar -xzf cmake-3.22.1-linux-x86_64.tar.gz -C ~/
export PATH=~/cmake-3.22.1-linux-x86_64/bin:$PATH

# 安裝 Python 套件
conda activate moose
conda install numpy pandas matplotlib scipy h5py -y

# 套用 Thermochimica 修復（見 20260411 日誌）
# 套用 CardinalApp.C 修改（見 20260411 日誌）

# 重建 Zapdos（ABI 一致性）
cd ~/MSR-project/cardinal/contrib/zapdos
MOOSE_DIR=~/MSR-project/cardinal/contrib/moose make -j16

# 建置 Cardinal（RTXWS 可嘗試含 NekRS）
cd ~/MSR-project/cardinal
make -j16 ENABLE_NEK=yes 2>&1 | tee ~/cardinal_build_rtxws.log
```

---

## 關鍵指令備忘

```bash
# Zapdos 正確重建方式（必須指定 MOOSE_DIR）
cd ~/MSR-project/cardinal/contrib/zapdos
MOOSE_DIR=~/MSR-project/cardinal/contrib/moose make -j4

# Cardinal 建置（無 NekRS，A電腦）
cd ~/MSR-project/cardinal
make -j4 ENABLE_NEK=false

# Cardinal 測試（必須用 VII.1）
export OPENMC_CROSS_SECTIONS=~/nuclear_data/endfb-vii.1-hdf5/cross_sections.xml
./run_tests -j4 --max-fails 500

# Stage 1 MSRE（用 VIII.0）
export OPENMC_CROSS_SECTIONS=~/nuclear_data/endfb-viii.0-hdf5/cross_sections.xml

# Stage 2 MSFR（用 VII.1）
export OPENMC_CROSS_SECTIONS=~/nuclear_data/endfb-vii.1-hdf5/cross_sections.xml
```
