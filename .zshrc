# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
# ZSH_THEME="tjkirch"
# ZSH_THEME="duellj"
# ZSH_THEME="fino-time"
ZSH_THEME="fox"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vagrant)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/python:$PATH

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

greplog() {
    if [[ $# < 2 ]]; then
        echo "Usage: getlog log_path match_word"
    elif [[ ! -a $1 ]]; then
        echo "File not exists: $1"
    else
        cat $1 | grep $2 | awk '{ printf "%-20s %-10s %-25s %s\n", $1, $3, substr($4, 2), $7 }'
    fi
}
