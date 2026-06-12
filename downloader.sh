#!/data/data/com.termux/files/usr/bin/bash
# ─────────────────────────────────────────
#  GIT-GET — downloader.sh
#  Dev: Md. Mainul Islam (CODEX-M41NUL)
# ─────────────────────────────────────────

source "$(dirname "$0")/config.sh"
source "$(dirname "$0")/utils.sh"

# ── Parse repo input ──────────────────────────────────────────────────────────
# Accepts:
#   https://github.com/user/repo
#   https://github.com/user/repo.git
#   user/repo
#   github.com/user/repo

parse_repo_input() {
    local input="$1"
    # Strip .git suffix
    input="${input%.git}"
    # Strip https://github.com/ or github.com/
    input="${input#https://github.com/}"
    input="${input#http://github.com/}"
    input="${input#github.com/}"
    echo "$input"
}

get_repo_name() {
    local slug="$1"
    echo "${slug#*/}"
}

get_repo_owner() {
    local slug="$1"
    echo "${slug%%/*}"
}

# ── Check if repo exists ──────────────────────────────────────────────────────
check_repo() {
    local slug="$1"
    local code
    code=$(curl -o /dev/null -s -w "%{http_code}" \
           "https://github.com/${slug}" 2>/dev/null)
    [ "$code" = "200" ]
}

# ── Get default branch ────────────────────────────────────────────────────────
get_default_branch() {
    local slug="$1"
    # Try to get branch from redirect
    local branch
    branch=$(curl -sI "https://github.com/${slug}/archive/HEAD.zip" 2>/dev/null \
             | grep -i "location:" \
             | grep -oP '(?<=archive/refs/heads/)[^/]+(?=\.zip)' \
             | tr -d '\r')
    [ -z "$branch" ] && branch="main"
    echo "$branch"
}

# ── Download as ZIP ───────────────────────────────────────────────────────────
download_zip() {
    local slug="$1"
    local save_dir="$2"
    local repo_name; repo_name=$(get_repo_name "$slug")
    local branch; branch=$(get_default_branch "$slug")
    local zip_url="https://github.com/${slug}/archive/refs/heads/${branch}.zip"
    local out_file="${save_dir}/${repo_name}.zip"

    mkdir -p "$save_dir"

    info_msg "Repo    : ${slug}"
    info_msg "Branch  : ${branch}"
    info_msg "Saving  : ${out_file}"
    echo ""

    spinner "Connecting to GitHub" 2

    # Download with progress
    if curl -L --progress-bar "$zip_url" -o "$out_file" 2>&1 | \
       while IFS= read -r line; do
           printf "\r  ${Y}${B}>${RST}  ${W}Downloading...  %s${RST}  " "$line"
       done; then
        echo ""
        if [ -f "$out_file" ] && [ -s "$out_file" ]; then
            local size; size=$(du -sh "$out_file" | cut -f1)
            ok_msg "Download complete!"
            ok_msg "File    : ${out_file}"
            ok_msg "Size    : ${size}"
            return 0
        else
            err_msg "Download failed or file is empty."
            return 1
        fi
    else
        echo ""
        err_msg "Download failed. Check repo URL and internet connection."
        return 1
    fi
}

# ── Download as Folder ────────────────────────────────────────────────────────
download_folder() {
    local slug="$1"
    local save_dir="$2"
    local repo_name; repo_name=$(get_repo_name "$slug")
    local branch; branch=$(get_default_branch "$slug")
    local zip_url="https://github.com/${slug}/archive/refs/heads/${branch}.zip"
    local tmp_zip="/data/data/com.termux/files/usr/tmp/gitget_${repo_name}.zip"
    local out_dir="${save_dir}/${repo_name}"

    mkdir -p "$save_dir"
    mkdir -p "$(dirname "$tmp_zip")"

    info_msg "Repo    : ${slug}"
    info_msg "Branch  : ${branch}"
    info_msg "Saving  : ${out_dir}/"
    echo ""

    spinner "Connecting to GitHub" 2

    # Download ZIP to temp
    if ! curl -L --progress-bar "$zip_url" -o "$tmp_zip" 2>&1 | \
       while IFS= read -r line; do
           printf "\r  ${Y}${B}>${RST}  ${W}Downloading...  %s${RST}  " "$line"
       done; then
        echo ""
        err_msg "Download failed."
        return 1
    fi
    echo ""

    if [ ! -f "$tmp_zip" ] || [ ! -s "$tmp_zip" ]; then
        err_msg "Downloaded file is empty."
        return 1
    fi

    progress_bar "Extracting files"

    # Extract
    local tmp_extract="/data/data/com.termux/files/usr/tmp/gitget_extract_${repo_name}"
    rm -rf "$tmp_extract"
    mkdir -p "$tmp_extract"

    if ! unzip -q "$tmp_zip" -d "$tmp_extract" 2>/dev/null; then
        err_msg "Extraction failed."
        rm -f "$tmp_zip"
        return 1
    fi

    # Move extracted folder to destination
    # GitHub extracts as reponame-branchname/
    local extracted_dir
    extracted_dir=$(ls "$tmp_extract" | head -1)

    rm -rf "$out_dir"
    mv "${tmp_extract}/${extracted_dir}" "$out_dir"

    # Cleanup
    rm -f "$tmp_zip"
    rm -rf "$tmp_extract"

    local file_count; file_count=$(find "$out_dir" -type f | wc -l)
    local size; size=$(du -sh "$out_dir" | cut -f1)

    ok_msg "Download complete!"
    ok_msg "Folder  : ${out_dir}/"
    ok_msg "Files   : ${file_count}"
    ok_msg "Size    : ${size}"
    return 0
}

# ── Menu handlers ─────────────────────────────────────────────────────────────
handle_download_zip() {
    clear_screen
    print_banner
    print_info_box
    echo -e "  ${G}${B}[ DOWNLOAD AS ZIP ]${RST}\n"
    separator

    local repo_input
    repo_input=$(prompt_input "Enter repo URL or user/repo" \
                 "https://github.com/M41NUL/X-ENCODER-  or  M41NUL/X-ENCODER-")
    [ -z "$repo_input" ] && { err_msg "No input."; pause; return; }

    local slug; slug=$(parse_repo_input "$repo_input")
    local parts; parts=$(echo "$slug" | tr '/' '\n' | wc -l)
    if [ "$parts" -lt 2 ]; then
        err_msg "Invalid repo format. Use: user/repo"
        pause; return
    fi

    local save_dir
    save_dir=$(prompt_input "Save location" "/sdcard/GIT-GET")
    [ -z "$save_dir" ] && save_dir="$DEFAULT_SAVE_DIR"
    save_dir=$(echo "$save_dir" | sed 's|/*$||')

    echo ""
    spinner "Checking repository" 2

    if ! check_repo "$slug"; then
        err_msg "Repository not found: ${slug}"
        err_msg "Make sure it is a public repo."
        pause; return
    fi
    ok_msg "Repository found."
    echo ""

    download_zip "$slug" "$save_dir"
    pause
}

handle_download_folder() {
    clear_screen
    print_banner
    print_info_box
    echo -e "  ${G}${B}[ DOWNLOAD AS FOLDER ]${RST}\n"
    separator

    local repo_input
    repo_input=$(prompt_input "Enter repo URL or user/repo" \
                 "https://github.com/M41NUL/X-ENCODER-  or  M41NUL/X-ENCODER-")
    [ -z "$repo_input" ] && { err_msg "No input."; pause; return; }

    local slug; slug=$(parse_repo_input "$repo_input")
    local parts; parts=$(echo "$slug" | tr '/' '\n' | wc -l)
    if [ "$parts" -lt 2 ]; then
        err_msg "Invalid repo format. Use: user/repo"
        pause; return
    fi

    local save_dir
    save_dir=$(prompt_input "Save location" "/sdcard/GIT-GET")
    [ -z "$save_dir" ] && save_dir="$DEFAULT_SAVE_DIR"
    save_dir=$(echo "$save_dir" | sed 's|/*$||')

    echo ""
    spinner "Checking repository" 2

    if ! check_repo "$slug"; then
        err_msg "Repository not found: ${slug}"
        err_msg "Make sure it is a public repo."
        pause; return
    fi
    ok_msg "Repository found."
    echo ""

    download_folder "$slug" "$save_dir"
    pause
}
