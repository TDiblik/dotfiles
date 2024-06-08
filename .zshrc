# ! Read at every instance start ! #

# Enviroment variables #
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export GPG_TTY=$(tty) # Tell GPG where to read input from


# Aliases #
alias ls="ls -a"
alias vim="nvim"
alias fsize="du -hd 1"
alias nmap="sudo nmap"
alias git-submodules-update="git submodule update --init --recursive --remote --merge"

alias tls="tmux list-sessions"
alias tas="tmux attach-session -t"
alias trm="tmux kill-session -t"
alias tkill="tmux kill-server"
alias trename="tmux rename-session -t "
alias tsave="tmux-session save"
alias trestore="tmux-session restore"
alias trs="tmux-session restore"


export PROMPT='%F{80}[%1~]%{$reset_color%} %{$fg[cyan]%}${vcs_info_msg_0_}%{$reset_color%}%F{218}>%{$reset_color%} '
