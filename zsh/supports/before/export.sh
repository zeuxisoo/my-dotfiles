# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=20000
HIST_STAMPS="yyyy-mm-dd" # show the datetime in history records

setopt extended_history       # save command timestamp in `.zsh_histroy`
setopt hist_expire_dups_first # remove duplicates first when HISTFILE > HISTSIZE
setopt hist_ignore_dups       # skip save command when saved.
setopt hist_ignore_all_dups   # delete old command if new command is duplicated
setopt hist_ignore_space      # skip command when start with space
setopt hist_save_no_dups      # skip write duplicate command in the history file
setopt hist_reduce_blanks     # remove blanks before save command
setopt hist_verify            # show command expaned history before running it
setopt inc_append_history     # save command to history file immediately
setopt share_history          # Share command history between all sessions
