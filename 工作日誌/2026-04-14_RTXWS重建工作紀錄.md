# 📝 RTXWS 工作站系統重生與運算環境建置日誌 (2026-04-09 ~ 2026-04-10)

## 📌 1. 執行背景與目標
* **設備名稱**：RTXWS (WinFast WS2030)
* **維護人員**：蕭伯彬 (Bo-Bin Xiao) & Gemini (AI 協作)
* **原始狀態**：Ubuntu 18.04 LTS，NVIDIA 驅動程式崩潰，`apt` 依賴性嚴重損毀，網路 IP 配置失效。
* **最終目標**：執行 Clean Install 升級至 Ubuntu 24.04 LTS，並恢復雙 Tesla V100S 算力與 4TB 儲存倉庫。

---

## 🖥️ 2. 硬體與軟體終態規格彙整

### 2.1 核心硬體 (Hardware Specs)
| 項目 | 詳細規格 | 備註 |
| :--- | :--- | :--- |
| **主機型號** | **WinFast WS2030** | 專業伺服器級架構 |
| **處理器** | Dual Intel® Xeon® Silver 系列 | 雙路高效能 CPU |
| **算力核心 (GPU)** | **2 x NVIDIA Tesla V100S-PCIE-32GB** | 總顯存 64GB HBM2 |
| **系統硬碟 (OS)** | **512.11 GB Samsung NVMe SSD** | 掛載於 `/` |
| **數據倉庫 (Data)** | **4.00 TB HGST Enterprise HDD** | 掛載於 `~/data` |

### 2.2 運算環境 (Software & Environment)
| 項目 | 版本 / 設定 | 備註 |
| :--- | :--- | :--- |
| **作業系統** | **Ubuntu 24.04.4 LTS** | Noble Numbat |
| **核心核心** | Linux Kernel 6.8+ | 2026 最新穩定版 |
| **NVIDIA Driver** | **535.288.01** | 正式版穩定驅動 |
| **CUDA Version** | **12.2** | 支援最新深度學習框架 |
| **輸入法** | **IBus-新酷音 (Chewing)** | 支援 Shift 秒切中英 |

### 2.3 網路配置 (Static IP)
* **IP Address**: `192.168.27.190`
* **Netmask**: `255.255.255.0`
* **Gateway**: `192.168.27.254`
* **DNS**: `192.168.60.39`

---

## 📅 3. 詳細執行日誌

### 第一階段：診斷與系統重建 (2026-04-09)
1. **問題確認**：確認舊系統 18.04 驅動程式與 `nvidia-cuda-dev` 產生嚴重版本衝突，導致 `nvidia-smi` 失效。
2. **決策執行**：放棄修補損毀的依賴項，決議透過 Live USB 執行全新安裝 (Clean Install) 以節省時間並確保長期穩定。
3. **OS 安裝細節**：
    * 選擇「預設安裝」以保持系統純淨，減少不必要的文書套件。
    * 手動指定 512GB NVMe 為系統碟，避免動到 4TB 數據碟。

### 第二階段：BIOS 修復與網路恢復 (2026-04-10 AM)
1. **開機障礙排除**：重啟後卡在 `DXE--Ready to Boot`。
    * **診斷**：主機板嘗試從已移除的隨身碟或損毀的舊引導分區開機。
    * **修復**：拔除隨身碟，透過 `F11` Boot Menu 手動導向新的 `UEFI: Samsung NVMe` 開機。
2. **網路重連**：
    * 進入 24.04 桌面，手動配置 IPv4 為 `Manual` 模式。
    * 套用 NARI 內網固定 IP 參數，成功通過 `ping google.com` 測試（延遲約 2.7ms）。

### 第三階段：GPU 算力與儲存擴充 (2026-04-10 PM)
1. **NVIDIA 驅動部署**：
    * 執行 `sudo ubuntu-drivers autoinstall` 安裝官方建議的 535 版本。
    * **驗證**：`nvidia-smi` 成功顯示兩張 V100S，顯存運行狀態正常。
2. **4TB 數據磁碟掛載**：
    * 識別區塊裝置 `sda` 為 HGST 4TB 硬碟。
    * 建立實體掛載點：`mkdir ~/data`。
    * **自動掛載配置**：
        * 獲取 UUID：`sudo blkid /dev/sda`。
        * 編輯 `/etc/fstab`：`UUID=... /home/ubuntu/data ext4 defaults 0 2`。
        * 修正權限：`sudo chown -R ubuntu:ubuntu ~/data`。

### 第四階段：使用者體驗優化
1. **輸入法配置**：
    * 安裝 `ibus-chewing` (新酷音)。
    * **技術突破**：透過 `gsettings set org.gnome.desktop.input-sources show-all-sources true` 強制解鎖隱藏的繁體中文來源。
    * **體驗同步**：設定 Shift 鍵切換中英文，達成類 Windows 新注音的操作感。

---

## ⚠️ 4. 維護注意事項
1. **大數據存放**：請務必將大型運算數據存放在 `~/data` 下，避免 NVMe 系統碟空間耗盡導致開機失敗。
2. **開機檢查**：若未來重啟卡住，請優先檢查硬體是否有未拔除的 USB 裝置。
3. **系統備份**：`/etc/fstab` 備份檔位於 `/etc/fstab.bak`，若修改磁碟分區請務必同步更新。

---
*文件產生於 2026-04-10*
*服務對象：蕭伯彬 (Bo-Bin Xiao)*
