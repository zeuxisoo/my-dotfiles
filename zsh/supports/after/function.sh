htpass() {
    if (( $# < 2 )) then
        echo "Usage: htpass username password"
    else
        if which htpasswd &> /dev/null; then
            htpasswd -nbs $1 $2
        else
            ruby -e "require 'digest/sha1'; require 'base64'; print '{SHA}' + Base64.encode64(Digest::SHA1.digest('$1'))"
        fi
    fi
}

grep_log() {
    if [[ $# < 2 ]]; then
        echo "Usage: getlog log_path match_word"
    elif [[ ! -a $1 ]]; then
        echo "File not exists: $1"
    else
        cat $1 | grep $2 | awk '{ printf "%-20s %-10s %-25s %s\n", $1, $3, substr($4, 2), $7 }'
    fi
}

brew_up() {
    if hash brew 2>/dev/null; then
        echo "#> Updating brew ..."
        brew update

        echo "#> Upgrading brew ..."
        brew upgrade

        echo "#> Upgrading brew cask ..."
        brew upgrade --cask

        echo "#> Prune unused links and folders, and cleanup old brew files"
        brew prune
        brew cleanup
    fi
}

# https://superuser.com/a/1154859
video_to_gif() {
    ffmpeg -y -i "${1}" -vf fps=${3:-10},scale=${2:-320}:-1:flags=lanczos,palettegen "${1}.png"
    ffmpeg -i "${1}" -i "${1}.png" -filter_complex "fps=${3:-10},scale=${2:-320}:-1:flags=lanczos[x];[x][1:v]paletteuse" "${1}".gif
    rm "${1}.png"
}

vscode_insiders_clean() {
    rm -rf "$HOME/Library/Caches/com.microsoft.VSCodeInsiders"
    rm -rf "$HOME/Library/Application Support/Code - Insiders/Cache"
    rm -rf "$HOME/Library/Application Support/Code - Insiders/CachedData"
    rm -rf "$HOME/Library/Application Support/Code - Insiders/CachedExtensionVSIXs"
    rm -rf "$HOME/Library/Application Support/Code - Insiders/Service Worker/CacheStorage"
    rm -rf "$HOME/Library/Application Support/Code - Insiders/User/workspaceStorage"
    rm -rf "$HOME/Library/Application Support/Code - Insiders/User/globalStorage"
    rm -rf "$HOME/Library/Application Support/Code - Insiders/User/History"

    code-insiders "$@"
}
