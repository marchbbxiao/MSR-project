# 工作日誌：A 電腦 Cardinal 全耦合環境安裝嘗試

**日期**：2026-04-11
**作者**：蕭伯彬（BoBin / Bruce），INER 核工所
**環境**：A 電腦（家用）Windows 11 + WSL2 Ubuntu 22.04，i7-12700，16GB RAM
**目標**：在 A 電腦建立 Cardinal 全耦合環境
         （OpenMC + MOOSE RANS TH + Thermochimica + Zapdos PNP）
**最終結果**：部分成功，NekRS 編譯受阻，cardinal-opt 尚未產生

---

## 背景說明

本專案目標是複刻 Tano et al. 2025（Progress in Nuclear Energy 178, 105503）
的多物理耦合 MSR 模擬框架。Cardinal 是整合 OpenMC + MOOSE + NekRS 的關鍵橋樑。

A 電腦定位為輕量測試機，主力計算機為公司的 RTXWS 工作站
（Ubuntu 24.04，Dual Xeon Silver，2x Tesla V100S 32GB）。

今日目標：先在 A 電腦建立完整環境，累積安裝經驗，
供後續在 RTXWS 重建時參考。

---

## 時序記錄

### 階段一：盤點現有安裝狀態（上午）

今日開始前，先確認上次安裝進度。A 電腦已完成：

- miniconda3 安裝，moose conda 環境建立
  （Python 3.10，moose-libmesh=2026.03.17）
- Cardinal master 分支 clone 完成
- get-dependencies.sh 執行完成（所有子模組下載）
- Zapdos 獨立編譯成功，產生 zapdos-opt 和 lib/libzapdos-opt.so
- CardinalApp.C 已修改加入 Zapdos 整合
- Thermochimica 源碼修復已完成（詳見下方）

上次安裝卡關點：執行 make 時 NekRS 編譯失敗。

---

### 階段二：確認 NekRS 的 CMake 錯誤（上午）

**如何發現問題**：

執行編譯指令：
```
conda activate moose
cd ~/MSR-project/cardinal
make -j8 2>&1 | tee cardinal_build3.log
```

編譯過程在 NekRS 的 lapack 子模組時中斷，出現以下錯誤：

```
CMake Error at 3rd_party/lapack/CMakeLists.txt:1 (cmake_minimum_required):
  Compatibility with CMake < 3.5 has been removed from CMake.
```

**問題根源分析**：

查看系統 CMake 版本：
```
cmake --version
# cmake version 4.1.3
```

查看出錯的 CMakeLists.txt 第一行：
```
cmake_minimum_required(VERSION 2.8)
```

這是 NekRS 依賴的 LAPACK 函式庫的 CMakeLists.txt，
寫於大約 2015 年，使用了極舊的版本宣告格式。

CMake 4.1.3（2025 年發布）正式移除了對
cmake_minimum_required(VERSION < 3.5) 的向下相容支援，
導致編譯直接中止。

---

### 階段三：路線 A — 嘗試降級 CMake（上午）

**思路**：若能把 conda 環境的 CMake 從 4.1.3 降到 3.28，
就能繞過 lapack CMakeLists 的相容性問題。

**執行指令**：
```
conda install -c conda-forge cmake=3.28 -n moose -y
```

**錯誤輸出**：
```
LibMambaUnsatisfiableError: Encountered problems while solving:
  - package moose-mpi-base-2026.03.19-openmpi requires cmake 4.1.3 hc85cc9f_0,
    but none of the providers can be installed

The following packages are incompatible:
  cmake =3.28 * is requested and can be installed;
  moose-libmesh ==2026.3.17.3463d95 * is not installable because it requires
    moose-petsc [==3.24.5 ...], which requires
      moose-mpi =2026.3.19 *, which requires
        moose-mpi-base [==2026.3.19 ...], which requires
          cmake ==4.1.3 hc85cc9f_0, which conflicts with any installable versions
```

**如何理解這個錯誤**：

moose conda 環境的整條依賴鏈如下：

```
moose-libmesh（MOOSE 的有限元素庫）
  └── moose-petsc（平行線性代數求解器）
        └── moose-mpi（MPI 通訊環境）
              └── moose-mpi-base 2026.03.19
                    └── cmake == 4.1.3（硬性鎖定，無法降級）
```

moose-mpi-base 明確指定 `cmake==4.1.3 hc85cc9f_0`，
這是 conda 的 pinned dependency，不允許任何其他版本。

**結論**：路線 A 在技術上無解，確定放棄。

---

### 階段四：路線 B — 尋找 Cardinal 官方 Docker 容器（下午）

**思路**：若 Cardinal 官方提供預建的 Docker image，
其中的工具鏈版本已經由官方確認相容，可以直接使用，
繞過本地環境的版本衝突問題。

**先確認 Docker 是否可用**：
```
docker --version
# Docker version 29.3.1, build c2be9cc

docker ps
# failed to connect to the docker API at unix:///var/run/docker.sock
```

Docker daemon 未啟動。原因：WSL2 裡的 Docker 需要透過
Windows 端的 Docker Desktop 啟動 daemon。

**修復 Docker 連線**：
1. 在 Windows 工作列啟動 Docker Desktop
2. Docker Desktop → Settings → Resources → WSL Integration
3. 啟用「Enable integration with my default WSL distro」
4. Apply & Restart
5. 重新執行 docker ps → 返回空列表，連線成功

**嘗試拉取 Cardinal 容器**：
```
docker pull ghcr.io/neams-th-coe/cardinal/ubuntu:latest
# Error response from daemon: error from registry: denied
```

**進一步搜尋**：

搜尋 GitHub（github.com/neams-th-coe/cardinal）的 Packages 頁面
和 Cardinal 官方文件（cardinal.cels.anl.gov），
確認 Cardinal 團隊**沒有發布任何公開的 Docker image**。

所有安裝文件都指向從源碼編譯的方式。
ghcr.io/neams-th-coe/cardinal 路徑不存在或為私有。

**結論**：路線 B 確定失敗，Cardinal 無官方公開容器。

---

### 階段五：整理現況與規劃下一步（下午）

確認今日最終狀態：

**已完成的安裝工作**（這些成果在 RTXWS 上仍然有參考價值）：

#### Thermochimica 源碼修復（詳細記錄）

Cardinal 的 Thermochimica 模組有 Fortran 前處理器指令問題，
gfortran 無法正確處理 #ifndef / #define 語法。

**修復檔案 1**：
`cardinal/contrib/moose/modules/chemical_reactions/contrib/
 thermochimica/src/module/ModuleThermoTolerance.f90`

修改內容：移除檔案開頭三行前處理器指令：
```fortran
! 刪除這三行：
#ifndef THERMOCHIMICA_DEFAULT_TOLERANCE_EPSILON
#define THERMOCHIMICA_DEFAULT_TOLERANCE_EPSILON 1D-14
#endif
```
並將所有 `= THERMOCHIMICA_DEFAULT_TOLERANCE_EPSILON` 替換為 `= 1D-14`

**修復檔案 2**：
`cardinal/contrib/moose/modules/chemical_reactions/contrib/
 thermochimica/src/module/ModuleThermoIO.f90`

修改內容：在第 58 行後插入缺失的常數宣告：
```fortran
character(*), parameter :: OUTPUT_DIRECTORY = ""
```

#### Zapdos 整合 Cardinal（詳細記錄）

**`cardinal/src/main/CardinalApp.C`** 修改：
```cpp
// 在 include 區塊加入：
#include "ZapdosApp.h"

// 在 registerAll() 函數內加入：
ZapdosApp::registerAll(_factory, _action_factory, _syntax);
```

**`cardinal/Makefile`** 加入：
```makefile
ENABLE_DAGMC          := yes
CHEMICAL_REACTIONS    := yes
ELECTROMAGNETICS      := yes
ZAPDOS_PATH           := $(HOME)/MSR-project/zapdos
```

**`~/.bashrc`** 加入環境變數：
```bash
export HDF5_ROOT=$HOME/miniconda3/envs/moose
export NEKRS_HOME=$HOME/MSR-project/cardinal/install
export OPENMC_CROSS_SECTIONS=$HOME/data/endfb71_hdf5/cross_sections.xml
export ENABLE_DAGMC=yes
export ZAPDOS_PATH=$HOME/MSR-project/zapdos
export CC=mpicc
export CXX=mpicxx
export FC=mpif90
```

---

## 現況總覽

```
A 電腦 Cardinal 安裝狀態（2026-04-11）：

✅ miniconda3 + moose conda 環境（Python 3.10）
✅ Cardinal master 分支 clone
✅ get-dependencies.sh 所有子模組下載完成
✅ Zapdos 獨立編譯成功（zapdos-opt、libzapdos-opt.so）
✅ Thermochimica Fortran 源碼修復（兩個檔案）
✅ CardinalApp.C 加入 Zapdos 整合
✅ Makefile 設定（DAGMC、Thermochimica、Zapdos）
✅ Docker Desktop 與 WSL2 連線正常（29.3.1）
❌ NekRS 編譯失敗（CMake 4.1.3 與 lapack 不相容）
❌ cardinal-opt 尚未產生
```

---

## 根本問題診斷

A 電腦的障礙是三方版本衝突，在目前環境內無解：

```
[moose conda 環境]          [NekRS 子模組]         [CMake 官方]
moose-mpi-base 2026.03.19   lapack CMakeLists.txt   CMake 4.1.3
鎖定 cmake==4.1.3     VS    VERSION 2.8 舊式寫法 VS 移除 <3.5 相容
        ↑                           ↑                      ↑
   無法降級                      無法升級               已發布
```

唯一的出路是**在 conda 環境外**安裝一個獨立的 CMake 3.x，
然後讓 Cardinal 的 NekRS 編譯使用那個版本。
但這在 WSL2 + conda 的環境下需要額外的路徑操控，
風險高且複雜。

---

## 下一步行動計畫

### 優先方案：RTXWS 工作站（到公司後執行）

RTXWS 是正確的 Cardinal 安裝目標：
- 原生 Ubuntu 24.04，可以 `sudo apt install cmake` 獨立控制版本
- 不受 conda 環境的依賴鎖定影響
- 鄧永宏已在相同架構機器成功安裝 Cardinal（816/830 測試通過）
- Tesla V100S GPU 對 NekRS 的 GPU 加速計算至關重要

安裝時參考本日誌的 Thermochimica 和 Zapdos 修復步驟。

### 備用方案：A 電腦跳過 NekRS

設定 `export ENABLE_NEK=false` 後重新編譯，
可產生不含 NekRS CFD 功能的 cardinal-opt。
適合測試 OpenMC + Thermochimica + Zapdos 的整合，
但無法執行完整的 MSFR 熱流耦合計算。

---

## 關鍵教訓

1. **CMake 版本是 Cardinal 安裝的隱藏地雷**
   NekRS 的第三方依賴（LAPACK）寫於 2015 年前，
   cmake_minimum_required(VERSION 2.8) 在 CMake 4.x 已觸發 fatal error。
   安裝前應先確認系統 CMake 版本在 3.5–3.28 之間。

2. **conda 環境版本鎖定是雙面刃**
   moose conda 環境確保 MOOSE 所有組件版本一致，
   但同時把系統工具（CMake）也鎖死了，無法降級。
   在 conda 外安裝 CMake 是唯一出路。

3. **Cardinal 沒有官方公開 Docker image**
   ghcr.io/neams-th-coe/cardinal 路徑不存在或為私有。
   安裝只能從源碼編譯，需要完整的工具鏈環境。

4. **Zapdos 和 Thermochimica 的整合已完成**
   這兩個元件的源碼修復和 Makefile 設定已就緒，
   等 NekRS 問題在 RTXWS 解決後可直接沿用。

5. **WSL2 的 Docker 需要 Windows 端 Docker Desktop 常駐**
   docker daemon 不會自動啟動，每次使用前需確認
   Docker Desktop 已在 Windows 側執行。

---

*工作日誌由 Claude（AI 家教）協助整理*
*記錄 BoBin（蕭伯彬）的 MSR 耦合模擬開發過程*
*GitHub：marchbbxiao/MSR-project*
