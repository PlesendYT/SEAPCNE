# 🔍 SEAPCNE - Smart Enterprise Archive & Pattern Scanner

**A graphical, feature-rich file searching tool written entirely in Batch**

## ✨ Features

- 🎨 **Modern GUI** with ASCII art and colored interface
- 🔍 **Pattern-based search** across your entire user profile
- 🚫 **Exclude words** from paths AND file contents
- 📁 **6 file type filters** (Config, Text, Code, Web, All, Everything)
- 👁️ **Content preview** (optional, up to 200 chars)
- 🎯 **Excludes entire folders** containing exclude words (e.g., "cargo" if selected)
- ⚡ **Fast PowerShell backend** with Batch frontend
- 📊 **Real-time result counting**
- 🖥️ **CMD/PowerShell compatible**

## 🎮 How it works

1. Enter search term
2. (Optional) Enter words to exclude
3. Choose file type filter (1-6)
4. Choose whether to show previews
5. Watch the magic happen

## 📂 Search paths

- `%USERPROFILE%\.config`
- `%USERPROFILE%`
- `%APPDATA%`
- `%LOCALAPPDATA%`

## 🚀 Usage

Simply double-click `SEAPCNE.bat` or run in CMD:
```
SEAPCNE.bat
📷 Preview:
╔════════════════════════════════════════════════════════════════════════════╗
║      ███████╗███████╗ █████╗ ██████╗  ██████╗███╗   ██╗███████╗              ║
║      ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝████╗  ██║██╔════╝              ║
║      ███████╗█████╗  ███████║██████╔╝██║     ██╔██╗ ██║█████╗                ║
║      ╚════██║██╔══╝  ██╔══██║██╔═══╝ ██║     ██║╚██╗██║██╔══╝                ║
║      ███████║███████╗██║  ██║██║     ╚██████╗██║ ╚████║███████╗              ║
║      ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝╚═╝  ╚═══╝╚══════╝              ║
║           🔍  Smart Enterprise Archive and Pattern Scanner                  ║
╚════════════════════════════════════════════════════════════════════════════╝
```
🛠️ Technical details
Language: Batch + PowerShell hybrid

Platform: Windows 10/11

Dependencies: None (pure native Windows)

Encoding: UTF-8 (chcp 65001)

📄 License
MIT - Do whatever you want with it!

⭐ Star this repo if you find it useful!
