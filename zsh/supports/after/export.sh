# brew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

# starship
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# zoxide
export _ZO_DATA_DIR=$HOME/.config/zoxide

# fzf
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
    --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
    --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
    --color=selected-bg:#494d64 \
    --color=border:#363a4f,label:#cad3f5"

# fnm
if cmd_exists "fnm"; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi
