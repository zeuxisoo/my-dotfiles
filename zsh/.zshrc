# Const
ZSH_HOME="$HOME/.config/zsh"
ZINIT_HOME="$HOME/.config/zinit"
ZINIT_INSTALLED_PATH=(
    "$(brew --prefix)/opt/zinit"
    $ZINIT_HOME
    "$HOME/.local/share/zinit"
)

# Zinit
zinit_bootstrap_file=""
for installed_path in ${ZINIT_INSTALLED_PATH[*]}; do
    if [[ -f "$installed_path/zinit.zsh" ]]; then
        zinit_bootstrap_file=$installed_path/zinit.zsh
        break
    fi
done

if [[ -z $zinit_bootstrap_file ]]; then
    echo "Please install zinit first, Cannot find in the following paths:\n"
    for installed_path in ${ZINIT_INSTALLED_PATH[*]}; do
        echo "- $installed_path"
    done
    exit 1
fi

typeset -A ZINIT=(
    BIN_DIR  "$ZINIT_HOME/bin"
    HOME_DIR "$ZINIT_HOME"
    COMPINIT_OPTS -C
)

source $zinit_bootstrap_file

# Plugin
zinit ice wait lucid depth"1"
zinit light zsh-users/zsh-autosuggestions # suggest full history

zinit ice wait lucid depth"1"
zinit light zsh-users/zsh-completions # git i[tab], git init --[tab]

zinit ice wait lucid depth"1"
zinit light zsh-users/zsh-syntax-highlighting # highlighting keyword

zinit ice wait lucid depth"1"
zinit light zsh-users/zsh-history-substring-search # up/down search filtered history
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Customize
for file in $ZSH_HOME/supports/.{zsh_function,zsh_export,zsh_alias}; do
    if [[ -r "$file" ]]; then
        source "$file"
    fi
done
unset file
