#!/data/data/com.termux/files/usr/bin/bash
# ─────────────────────────────────────────
#  GIT-GET — git-get.sh  (main)
#  Dev: Md. Mainul Islam (CODEX-M41NUL)
# ─────────────────────────────────────────

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/utils.sh"
source "$SCRIPT_DIR/banner.sh"
source "$SCRIPT_DIR/updater.sh"
source "$SCRIPT_DIR/downloader.sh"

_menu_header() {
    echo -e "\n  ${Y}${B}+$(printf '%0.s=' $(seq 1 44))+${RST}"
    echo -e "  ${Y}${B}|${G}          MAIN MENU  --  GIT-GET          ${Y}|${RST}"
    echo -e "  ${Y}${B}+$(printf '%0.s=' $(seq 1 44))+${RST}\n"
}

_option() {
    echo -e "  ${Y}${B}[$1]${RST}  ${G}${B}$2${RST}"
    echo -e "        ${DIM}${W}$3${RST}\n"
}

main_menu() {
    while true; do
        clear_screen
        print_banner
        print_info_box
        _menu_header

        _option "1" "Download as ZIP" \
            "Download entire repo as a ZIP file"
        _option "2" "Download as Folder" \
            "Download and extract repo as a folder"
        _option "0" "Exit" \
            "Quit GIT-GET"
        separator

        local choice
        choice=$(prompt_input "Select option")

        case "$choice" in
            1) handle_download_zip ;;
            2) handle_download_folder ;;
            0)
                echo -e "\n  ${G}${B}Goodbye from GIT-GET!${RST}"
                echo -e "  ${Y}github.com/M41NUL  |  t.me/codexm41nul${RST}\n"
                exit 0 ;;
            *)
                warn_msg "Invalid option."
                sleep 1 ;;
        esac
    done
}

# ── Entry point ───────────────────────────────────────────────────────────────
clear_screen
print_banner
separator
info_msg "Initializing GIT-GET..."
echo ""
check_and_update
echo ""
ok_msg "Ready! Loading main menu..."
sleep 1
main_menu
