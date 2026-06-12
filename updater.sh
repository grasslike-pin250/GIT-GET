#!/data/data/com.termux/files/usr/bin/bash
# ─────────────────────────────────────────
#  GIT-GET — updater.sh
#  Dev: Md. Mainul Islam (CODEX-M41NUL)
# ─────────────────────────────────────────

source "$(dirname "$0")/config.sh"
source "$(dirname "$0")/utils.sh"

SCRIPT_DIR="$(dirname "$0")"

FILES_TO_UPDATE=(
    "git-get.sh"
    "config.sh"
    "banner.sh"
    "downloader.sh"
    "utils.sh"
    "updater.sh"
)

_version_gt() {
    [ "$(printf '%s\n' "$2" "$1" | sort -V | head -n1)" != "$1" ]
}

check_and_update() {
    local frames=("|" "/" "-" "\\")
    local i=0
    local end_at=$(( $(date +%s) + 5 ))

    while [ "$(date +%s)" -lt "$end_at" ]; do
        printf "\r  ${Y}${B}%s${RST}  ${W}Checking for updates...${RST}  " \
               "${frames[$((i % 4))]}"
        sleep 0.1
        (( i++ ))
    done

    local remote_ver
    remote_ver=$(curl -fsSL "$VERSION_URL" 2>/dev/null | tr -d '[:space:]')

    if [ -z "$remote_ver" ]; then
        printf "\r  ${Y}${B}!${RST}  ${W}Could not reach GitHub. Skipping.${RST}      \n"
        return
    fi

    if _version_gt "$remote_ver" "$VERSION"; then
        printf "\r  ${G}${B}+${RST}  ${W}Update found: v%s -> v%s${RST}      \n" \
               "$VERSION" "$remote_ver"
        _apply_update
    else
        printf "\r  ${G}${B}+${RST}  ${W}Already up to date (v%s)${RST}      \n" \
               "$VERSION"
    fi
}

_apply_update() {
    info_msg "Downloading updates..."
    local failed=0
    for fname in "${FILES_TO_UPDATE[@]}"; do
        if curl -fsSL "${GITHUB_RAW}/${fname}" -o "${SCRIPT_DIR}/${fname}" 2>/dev/null; then
            chmod +x "${SCRIPT_DIR}/${fname}"
        else
            warn_msg "Failed: $fname"
            (( failed++ ))
        fi
    done
    [ "$failed" -eq 0 ] && ok_msg "Update complete!" || warn_msg "Some files failed."
    sleep 1
}
