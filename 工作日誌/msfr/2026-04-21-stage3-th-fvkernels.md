# 2026-04-21 Stage 3 th.i FVKernels 完成（A電腦）

## 完成項目
- th.i [Variables]：7個變數（vel_x/y/z, pressure, TKE, TKED, T_fluid）
- th.i [AuxVariables]：power_density（OpenMC傳入）
- th.i [FVKernels]：25個kernels完成
  - 質量守恆（1）
  - 動量守恆 x/y/z（12）
  - 能量守恆（4）
  - TKE 輸送方程式（4）
  - TKED 輸送方程式（4）
- 所有區塊加入完整中文詳細註解

## 學到的核心概念
- Re ≈ 958,000 → MSFR 是強湍流，必須用 k-epsilon 模型
- RANS = N-S 時間平均版本，湍流效果打包成 μt = Cμ*k²/ε
- 守恆定律共同結構：時間項 + 對流項 = 擴散項 + 源項
- TKE 和 TKED 互相依賴，兩條方程式聯立求解
- TKE/TKED 初始值不能為零（分母含 k 和 ε）
- Advection（流體移動帶走量）不等於 Convection（溫度差驅動流動）
- SIMPLE 演算法：壓力作為調節器強制滿足 div(v)=0

## 待完成（明天繼續）
- [FVBCs]：入口速度+溫度、出口壓力、壁面無滑移
- [FunctorMaterials]：μt = Cμ*k²/ε（補入動量和能量擴散項）
- [Executioner]：SIMPLE solver

## 環境
- A電腦 WSL2 Ubuntu，Cursor IDE
- 只編輯文字檔，不執行計算
