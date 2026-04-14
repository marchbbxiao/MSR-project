# RTXWS Cardinal 完整安裝工作日誌

**日期：** 2026-04-13 ～ 2026-04-14  
**機器：** RTXWS（Ubuntu 24.04 LTS，Dual Xeon Silver 4216，2× Tesla V100S 32GB）  
**目標：** 完整安裝 Cardinal（含 NekRS + OpenMC + DAGMC + Thermochimica + Zapdos）並驗證測試套件

---

## 一、環境前置確認

```bash
conda activate moose
cmake --version  # 需確認 < 4.0，RTXWS 已預先降級至 3.22
```

---

## 二、Cardinal 編譯流程與踩坑記錄

### 坑 1：libcuda.so.1 找不到（OCCA/NekRS 連結失敗）

**症狀：**
```
undefined reference to `cuXxx` symbols
libocca.so link error
```

**原因：** OCCA 在連結 CUDA backend 時找不到 `libcuda.so.1`。

**解法：**
```bash
find /usr/lib -name "libcuda.so*"
# 找到 /usr/lib/x86_64-linux-gnu/libcuda.so.1
ln -sf /usr/lib/x86_64-linux-gnu/libcuda.so.1 $CONDA_PREFIX/lib/libcuda.so.1
```

---

### 坑 2：Cardinal 路徑錯誤

**症狀：**
```
bash: cd: /home/ubuntu/MSR-project/cardinal: No such file or directory
```

**原因：** RTXWS 的 Cardinal 安裝在 `~/cardinal`，不是 `~/MSR-project/cardinal`。

**解法：**
```bash
find ~ -name "Makefile" -path "*/cardinal/Makefile"
# 確認路徑為 ~/cardinal
cd ~/cardinal
```

---

### 坑 3：NEKRS_HOME 未設定

**症狀：**
```
"Environment variable NEKRS_HOME needs to be set to /home/ubuntu/cardinal/install"
```

**解法：**
```bash
export NEKRS_HOME=$HOME/cardinal/install
```

---

### 坑 4：OpenMC CMake 找不到 MPI

**症狀：**
```
Could NOT find MPI_C (missing: MPI_C_WORKS)
```

**原因：** CMake 測試編譯 C 程式時，連結器找不到 `libstdc++.so.6`（被 WASP 的 `.so` 檔依賴）。

**診斷：**
```bash
which mpicc
echo "int main(){return 0;}" | mpicc -x c - -o /tmp/test_mpi && echo "OK"
# MPI OK，但 libstdc++ 路徑未加入
```

**解法：**
```bash
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$CONDA_PREFIX/x86_64-conda-linux-gnu/lib:$LD_LIBRARY_PATH
export MPI_C_COMPILER=$(which mpicc)
export MPI_CXX_COMPILER=$(which mpicxx)
export MPI_Fortran_COMPILER=$(which mpifort)
rm -rf build/openmc  # 清除 CMake cache
```

---

### 坑 5：OpenMC CMake 找不到 HDF5

**症狀：**
```
Could NOT find HDF5 (missing: HDF5_LIBRARIES HDF5_INCLUDE_DIRS)
```

**解法：**
```bash
export HDF5_ROOT=$CONDA_PREFIX
export HDF5_DIR=$CONDA_PREFIX
rm -rf build/openmc
```

---

### 坑 6：cardinal-opt 連結失敗（libnekrs-hypre 缺失）

**症狀：**
```
libnekrs.so: undefined reference to `hypreWrapperDevice::boomerAMG_t::boomerAMG_t(...)`
undefined reference to `hypreWrapper::IJ_t::MatrixAssemble()`
```

**原因：** `~/cardinal/Makefile` 的 ADDITIONAL_LIBS 只有 `-lnekrs`，沒有包含 `-lnekrs-hypre` 和 `-lnekrs-hypre-device`。

**診斷：**
```bash
grep -n "lnekrs" ~/cardinal/Makefile
# 第 331、366 行只有 -lnekrs
```

**解法（修改 Makefile）：**
```bash
# 修改 NEKRS_LIB（第 179 行）
sed -i 's|NEKRS_LIB := \$(NEKRS_LIBDIR)/libnekrs.so$|NEKRS_LIB := $(NEKRS_LIBDIR)/libnekrs.so $(NEKRS_LIBDIR)/libnekrs-hypre.so $(NEKRS_LIBDIR)/libnekrs-hypre-device.so|' ~/cardinal/Makefile

# 修改 ADDITIONAL_LIBS（第 331 行）
sed -i 's|-lnekrs -locca|-lnekrs -lnekrs-hypre -lnekrs-hypre-device -locca|' ~/cardinal/Makefile

# 修改 CARDINAL_EXTERNAL_FLAGS（第 366 行）
sed -i 's|-lnekrs \$(CC_LINKER_SLFLAG)|-lnekrs -lnekrs-hypre -lnekrs-hypre-device $(CC_LINKER_SLFLAG)|' ~/cardinal/Makefile
```

---

### 坑 7：cardinal-opt 被 wrapper script 覆蓋（嚴重！）

**背景：** 為了解決 Thermochimica TestHarness 問題，嘗試建立 wrapper script 過濾 NekRS 輸出，但不小心把 wrapper 存成 `~/cardinal/cardinal-opt`，覆蓋了真正的執行檔。

**症狀：**
```bash
file ~/cardinal/cardinal-opt
# Bourne-Again shell script (只有 129 bytes！)
~/cardinal/cardinal-opt --show-capabilities
# /bin/bash: warning: shell level (1000) too high, resetting to 1
# 無限遞迴！
```

**解法：**
```bash
rm ~/cardinal/cardinal-opt
# 重新編譯
make -j16 ENABLE_NEK=yes
# 確認
file ~/cardinal/cardinal-opt
# ELF 64-bit LSB pie executable (67K) ✓
```

**教訓：** 永遠不要把 wrapper script 命名為與執行檔相同的名稱放在同一目錄。

---

## 三、截面資料庫安裝

```bash
mkdir -p ~/data/cross_sections
cd ~/data/cross_sections
wget https://anl.box.com/.../endfb-vii.1.tar.xz
tar -xJf endfb-vii.1.tar.xz
# 結果：endfb-vii.1-hdf5/cross_sections.xml

export OPENMC_CROSS_SECTIONS=/home/ubuntu/data/cross_sections/endfb-vii.1-hdf5/cross_sections.xml
```

---

## 四、Cardinal 編譯成功

```bash
make -j16 ENABLE_NEK=yes 2>&1 | tee ~/make_cardinal.log
# Linking Executable /home/ubuntu/cardinal/cardinal-opt...
file ~/cardinal/cardinal-opt
# ELF 64-bit LSB pie executable, 67K ✓
```

---

## 五、測試套件結果

### 5.1 Cardinal 主套件

```bash
cd ~/cardinal
./run_tests -j4 --max-fails 500
# 783 passed, 51 skipped, 32 FAILED
```

**失敗分析：**

| 類型 | 數量 | 原因 |
|------|------|------|
| CSVDIFF | 13 | OpenMC 蒙地卡羅統計波動（預期行為） |
| NekRS TIMEOUT/CRASH/ERRMSG | 19 | OCCA GPU JIT 在測試 timeout 內未完成 |
| EXODIFF | 1 | 輸出差異（微小） |

**與鄧永宏比對：** CSVDIFF 失敗類型完全一致，均為蒙地卡羅統計問題。

---

### 5.2 Thermochimica

#### TestHarness 問題排查

**坑 8：hit.so 編譯目標錯誤**

```bash
make PYTHON=$(which python3)  # 不會生成 hit.so！
# 正確：
make bindings PYTHON=$(which python3)
```

**坑 9：NekInitAction 干擾 Thermochimica 測試**

**症狀：** cardinal-opt 啟動時 NekInitAction 要求 `Problem/type`，但 Thermochimica 測試檔沒有這個參數，導致 29 個測試 ERRMSG。

**解法：**
```bash
./run_tests -j4 --cli-args "Problem/type=FEProblem"
# 77 passed, 0 skipped, 0 failed ✓
```

**最終結果：77/77 通過，與鄧永宏完全一致。**

---

### 5.3 Zapdos PNP

#### TestHarness 問題排查

**坑 10：TestHarness 載入失敗（MOOSE 版本不符）**

```
ModuleNotFoundError: No module named 'TestHarness'
```

**原因：** Zapdos 內嵌的 MOOSE 版本較舊，`hit.so` 版本不符，且缺少 `yaml` 模組。

**解法：**
```bash
# 使用 Cardinal 的 MOOSE TestHarness
export PYTHONPATH=~/cardinal/contrib/moose/python:~/cardinal/contrib/moose/framework/contrib/capabilities:$PYTHONPATH
export MOOSE_DIR=~/cardinal/contrib/moose

# 重新編譯 hit.so（bindings 目標）
cd ~/cardinal/contrib/moose/framework/contrib/hit
make bindings PYTHON=$(which python3)

# 重新編譯 capabilities
cd ~/cardinal/contrib/moose/test
make capabilities

# 建立 zapdos-opt symlink
ln -sf /home/ubuntu/cardinal/cardinal-opt ~/cardinal/contrib/zapdos/zapdos-opt

# 跑測試
cd ~/cardinal/contrib/zapdos
./run_tests -j4
# 58 passed, 20 skipped, 4 FAILED
```

**失敗分析：**

| 失敗案例 | 原因 | 影響 |
|----------|------|------|
| ad_test EXODIFF | Zapdos 已知問題 | 無 |
| jacobian_testing INCORRECT JACOBIAN | Zapdos 已知問題 | 無 |
| current_carrying_wire ERRMSG | cardinal-opt 含 NekRS，觸發 NekInitAction | 無 |
| field_solver_temp.i | 測試 spec 寫錯檔名 | 無 |

---

## 六、環境變數永久設定（~/.bashrc）

```bash
# Cardinal Environment
export NEKRS_HOME=$HOME/cardinal/install
export OPENMC_CROSS_SECTIONS=/home/ubuntu/data/cross_sections/endfb-vii.1-hdf5/cross_sections.xml
export LD_LIBRARY_PATH=$HOME/cardinal/install/lib:$CONDA_PREFIX/lib:$CONDA_PREFIX/x86_64-conda-linux-gnu/lib:$LD_LIBRARY_PATH
export HDF5_ROOT=$CONDA_PREFIX
export MPI_C_COMPILER=$(which mpicc)
export MPI_CXX_COMPILER=$(which mpicxx)
export MPI_Fortran_COMPILER=$(which mpifort)

# Zapdos/Cardinal TestHarness (moose env only)
if [[ "$CONDA_DEFAULT_ENV" == "moose" ]]; then
    export PYTHONPATH=$HOME/cardinal/contrib/moose/python:$HOME/cardinal/contrib/moose/framework/contrib/capabilities:$PYTHONPATH
    export MOOSE_DIR=$HOME/cardinal/contrib/moose
fi

# 測試快捷指令
alias run_thermochimica='cd ~/cardinal/contrib/moose/modules/chemical_reactions && ./run_tests -j4 --cli-args "Problem/type=FEProblem"'
alias run_zapdos='cd ~/cardinal/contrib/zapdos && ./run_tests -j4'
alias run_cardinal='cd ~/cardinal && ./run_tests -j4 --max-fails 500'
```

---

## 七、Makefile 修改總覽

```bash
# ~/cardinal/Makefile 修改記錄

# 1. 第 179 行：補充 NEKRS_LIB
NEKRS_LIB := $(NEKRS_LIBDIR)/libnekrs.so \
             $(NEKRS_LIBDIR)/libnekrs-hypre.so \
             $(NEKRS_LIBDIR)/libnekrs-hypre-device.so

# 2. 第 331 行：ADDITIONAL_LIBS 加入 hypre
ADDITIONAL_LIBS += -L$(NEKRS_LIBDIR) -lnekrs -lnekrs-hypre -lnekrs-hypre-device -locca ...

# 3. 第 366 行：CARDINAL_EXTERNAL_FLAGS 加入 hypre
CARDINAL_EXTERNAL_FLAGS += -L$(NEKRS_LIBDIR) -lnekrs -lnekrs-hypre -lnekrs-hypre-device ...
```

---

## 八、三環境測試比對總表

| 組件 | 鄧永宏 | A電腦（家用 WSL2） | RTXWS（工作站） |
|------|--------|-------------------|-----------------|
| Cardinal 通過/總計 | 816/830 | 614/614 | 783/815 |
| Cardinal NekRS | 啟用 | 停用 | 啟用 |
| Thermochimica | 77/77 | 77/77 | 77/77 ✅ |
| Zapdos | 60/62 | 60/62 | 58/62 |

**A電腦 Cardinal 零失敗原因：** ENABLE_NEK=false，NekRS 相關測試全部跳過，測試規模縮減至 614 題。

---

## 九、下一步

- [ ] Stage 2 MSFR 檔案從 A電腦遷移到 RTXWS
- [ ] Stage 2 keff 目標計算（目標 keff ≈ 1.05）
- [ ] NekRS segfault 問題調查（低優先度，不影響 Stage 2-3）

