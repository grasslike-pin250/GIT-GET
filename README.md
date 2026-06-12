<div align="center">

```
  ██████╗ ██╗████████╗        ██████╗ ███████╗████████╗
 ██╔════╝ ██║╚══██╔══╝       ██╔════╝ ██╔════╝╚══██╔══╝
 ██║  ███╗██║   ██║    ─────▶██║  ███╗█████╗     ██║
 ██║   ██║██║   ██║          ██║   ██║██╔══╝     ██║
 ╚██████╔╝██║   ██║          ╚██████╔╝███████╗   ██║
  ╚═════╝ ╚═╝   ╚═╝           ╚═════╝ ╚══════╝   ╚═╝
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  [ v1.0.0 ]  GitHub Repo Downloader  |  CODEX-M41NUL
```

**GitHub Repository Downloader for Termux**

[![Version](https://img.shields.io/badge/version-1.0.0-brightgreen?style=flat-square)](https://github.com/M41NUL/GIT-GET)
[![Platform](https://img.shields.io/badge/platform-Termux%20%7C%20Android-yellow?style=flat-square)](https://github.com/M41NUL/GIT-GET)
[![Language](https://img.shields.io/badge/language-Shell%20Script-green?style=flat-square)](https://github.com/M41NUL/GIT-GET)
[![License](https://img.shields.io/badge/license-MIT-red?style=flat-square)](https://github.com/M41NUL/GIT-GET)
[![Author](https://img.shields.io/badge/dev-CODEX--M41NUL-yellow?style=flat-square)](https://github.com/M41NUL)
[![Telegram](https://img.shields.io/badge/Telegram-Channel-2CA5E0?style=flat-square&logo=telegram)](https://t.me/codexm41nul)
[![Stars](https://img.shields.io/github/stars/M41NUL/GIT-GET?style=flat-square&color=yellow)](https://github.com/M41NUL/GIT-GET/stargazers)
[![Forks](https://img.shields.io/github/forks/M41NUL/GIT-GET?style=flat-square&color=blue)](https://github.com/M41NUL/GIT-GET/network/members)
[![Issues](https://img.shields.io/github/issues/M41NUL/GIT-GET?style=flat-square&color=red)](https://github.com/M41NUL/GIT-GET/issues)
[![Last Commit](https://img.shields.io/github/last-commit/M41NUL/GIT-GET?style=flat-square&color=brightgreen)](https://github.com/M41NUL/GIT-GET/commits/main)
[![Repo Size](https://img.shields.io/github/repo-size/M41NUL/GIT-GET?style=flat-square&color=orange)](https://github.com/M41NUL/GIT-GET)

</div>

---

## What is GIT-GET?

**GIT-GET** is a Termux shell tool that downloads any public GitHub repository directly to your Android device. Choose to save it as a ZIP file or as an extracted folder — no git commands needed.

> Download any public GitHub repo to your Android in seconds.

---

## Features

- Download any public GitHub repo as a ZIP file
- Download and extract any public GitHub repo as a folder
- Accepts full URL or user/repo format
- Auto-detects default branch (main or master)
- Shows file count and size after download
- Gradient block progress bar (Red to Yellow to Green)
- Auto update check from GitHub on every launch
- Smart installer — skips already installed packages
- Yellow / Green / White color scheme

---

## Project Structure

```
GIT-GET/
├── git-get.sh     - Main entry point
├── config.sh      - Tool config and developer info
├── banner.sh      - 3D block shadow ASCII banner + info box
├── downloader.sh  - ZIP and folder download logic
├── utils.sh       - Colors, progress bar, helpers
├── updater.sh     - Auto update from GitHub
├── installer.sh   - Smart installer + launcher
└── version.txt    - Version tracking
```

---

## Installation

### Step 1 - Clone the repo

```bash
git clone https://github.com/M41NUL/GIT-GET.git
cd GIT-GET
```

### Step 2 - Run installer

```bash
bash installer.sh
```

The installer will:
- Update Termux packages
- Install curl, unzip, git
- Skip already installed packages
- Request Android storage permission (once only)
- Auto-launch git-get.sh after a 3-second countdown

### Step 3 - Run manually (after first install)

```bash
cd GIT-GET
bash git-get.sh
```

---

## All Commands

| Command | Description |
|---------|-------------|
| `git clone https://github.com/M41NUL/GIT-GET.git` | Clone the repo |
| `cd GIT-GET` | Enter project folder |
| `bash installer.sh` | Install and launch |
| `bash git-get.sh` | Run manually |
| `git pull origin main` | Pull latest update manually |
| `rm -rf GIT-GET` | Remove / uninstall |

---

## Uninstall

```bash
cd /sdcard
rm -rf GIT-GET
```

---

## Menu Options

```
[1]  Download as ZIP     - Save entire repo as a ZIP file
[2]  Download as Folder  - Extract repo as a folder
[0]  Exit
```

---

## Download as ZIP Example

```
Enter repo URL or user/repo : https://github.com/M41NUL/X-ENCODER-
Save location               : /sdcard/GIT-GET
```

```
+ Download complete!
+ File  : /sdcard/GIT-GET/X-ENCODER-.zip
+ Size  : 24K
```

---

## Download as Folder Example

```
Enter repo URL or user/repo : M41NUL/X-ENCODER-
Save location               : /sdcard/GIT-GET
```

```
+ Download complete!
+ Folder : /sdcard/GIT-GET/X-ENCODER-/
+ Files  : 10
+ Size   : 48K
```

---

## Supported Input Formats

```
https://github.com/M41NUL/X-ENCODER-
https://github.com/M41NUL/X-ENCODER-.git
github.com/M41NUL/X-ENCODER-
M41NUL/X-ENCODER-
```

---

## Developer

<div align="center">

| | |
|--|--|
| **Name** | Md. Mainul Islam |
| **Brand** | CODEX-M41NUL |
| **GitHub** | [github.com/M41NUL](https://github.com/M41NUL) |
| **Telegram** | [t.me/mdmainulislaminfo](https://t.me/mdmainulislaminfo) |
| **Channel** | [t.me/codexm41nul](https://t.me/codexm41nul) |
| **Group** | [t.me/codex_m41nul](https://t.me/codex_m41nul) |
| **YouTube** | [youtube.com/@codexm41nul](https://youtube.com/@codexm41nul) |
| **WhatsApp** | +8801308850528 |
| **Email** | devmainulislam@gmail.com |

</div>

---

## Support

[![Star on GitHub](https://img.shields.io/github/stars/M41NUL/GIT-GET?style=social)](https://github.com/M41NUL/GIT-GET)
[![Telegram](https://img.shields.io/badge/Join-Telegram%20Channel-2CA5E0?style=flat-square&logo=telegram)](https://t.me/codexm41nul)

---

<div align="center">
<sub>© 2026 CODEX-M41NUL. All Rights Reserved.</sub>
</div>
