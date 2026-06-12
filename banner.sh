#!/data/data/com.termux/files/usr/bin/bash
# ─────────────────────────────────────────
#  GIT-GET — banner.sh  (3D Block with shadow)
#  Dev: Md. Mainul Islam (CODEX-M41NUL)
# ─────────────────────────────────────────

source "$(dirname "$0")/config.sh"
source "$(dirname "$0")/utils.sh"

print_banner() {
echo -e "${Y}${B}"
echo "  ██████╗ ██╗████████╗        ██████╗ ███████╗████████╗"
echo " ██╔════╝ ██║╚══██╔══╝       ██╔════╝ ██╔════╝╚══██╔══╝"
echo " ██║  ███╗██║   ██║    ─────▶██║  ███╗█████╗     ██║   "
echo " ██║   ██║██║   ██║          ██║   ██║██╔══╝     ██║   "
echo " ╚██████╔╝██║   ██║          ╚██████╔╝███████╗   ██║   "
echo "  ╚═════╝ ╚═╝   ╚═╝           ╚═════╝ ╚══════╝   ╚═╝   "
echo -e "${DIM}${Y}  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░${RST}"
echo -e "  ${W}[ v${VERSION} ]  GitHub Repo Downloader  |  ${Y}CODEX-M41NUL${RST}"
echo ""
}

print_info_box() {
    local rows=(
        "Tool|${TOOL_NAME}"
        "Version|${VERSION}"
        "Dev|${DEV_NAME}"
        "Brand|${DEV_BRAND}"
        "---"
        "GitHub|${DEV_GITHUB}"
        "Telegram|${DEV_TELEGRAM}"
        "Channel|${DEV_CHANNEL}"
        "Group|${DEV_GROUP}"
        "YouTube|${DEV_YOUTUBE}"
        "WhatsApp|${DEV_WHATSAPP}"
        "Email|${DEV_EMAIL}"
    )

    # Auto calc width
    local max_val=0
    for row in "${rows[@]}"; do
        [ "$row" = "---" ] && continue
        local val="${row#*|}"
        [ ${#val} -gt $max_val ] && max_val=${#val}
    done
    local label_w=9
    local W_BOX=$(( 1 + label_w + 2 + max_val + 1 ))
    local title="${TOOL_NAME}  v${VERSION}  -  GitHub Repo Downloader"
    [ ${#title} -gt $(( W_BOX - 2 )) ] && W_BOX=$(( ${#title} + 4 ))

    _border() {
        echo -e "  ${Y}${B}+$(printf '%0.s-' $(seq 1 $W_BOX))+${RST}"
    }
    _center() {
        local text="$1" tc="${2:-$G}"
        local vlen=${#text}
        local lpad=$(( (W_BOX - vlen) / 2 ))
        local rpad=$(( W_BOX - vlen - lpad ))
        printf "  ${Y}${B}|${RST}%*s${tc}${B}%s${RST}%*s${Y}${B}|${RST}\n" \
               "$lpad" "" "$text" "$rpad" ""
    }
    _row() {
        local label="$1" value="$2" lc="${3:-$Y}"
        local lpad=$(( label_w - ${#label} ))
        local used=$(( 1 + label_w + 2 + ${#value} + 1 ))
        local rpad=$(( W_BOX - used ))
        printf "  ${Y}${B}|${RST} ${lc}${B}%s${RST}%*s  ${W}%s${RST}%*s${Y}${B}|${RST}\n" \
               "$label" "$lpad" "" "$value" "$rpad" ""
    }

    _border
    _center "$title"
    _border

    local in_links=0
    for row in "${rows[@]}"; do
        if [ "$row" = "---" ]; then
            _border; in_links=1; continue
        fi
        local label="${row%%|*}"
        local value="${row#*|}"
        if [ $in_links -eq 0 ]; then
            case "$label" in
                Tool|Version) _row "$label" "$value" "$G" ;;
                *)             _row "$label" "$value" "$Y" ;;
            esac
        else
            case "$label" in
                GitHub)   _row "$label" "$value" "$G" ;;
                YouTube)  _row "$label" "$value" "$R" ;;
                Email)    _row "$label" "$value" "$W" ;;
                *)        _row "$label" "$value" "$Y" ;;
            esac
        fi
    done

    _border
    _center "$COPYRIGHT" "$Y"
    _border
    echo ""
}
