# brew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

# starship
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# zoxide
export _ZO_DATA_DIR=$HOME/.config/zoxide

# fnm
if cmd_exists "fnm"; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi
