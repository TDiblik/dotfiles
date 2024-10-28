# ! Read at every instance start ! #

# Enviroment variables #
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Ruby
export PATH="$PATH:/opt/homebrew/opt/ruby/bin"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include $CPPFLAGS"

# Go
export PATH="$PATH:$HOME/go/bin"

# Java - latest
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include $CPPFLAGS"

# Java - 11
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include $CPPFLAGS"

# Maven
export M2_HOME="/opt/homebrew/Cellar/maven/3.9.9/libexec"
alias mvn-run="mvn clean package && mvn exec:java"

# Python - pyenv
export PATH="${HOME}/.pyenv/shims:${PATH}"

# C++
export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"

# LLVM
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include $CPPFLAGS"

# Postgres Tools
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include $CPPFLAGS"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig $PKG_CONFIG_PATH"

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

# Tell GPG where to read input from
export GPG_TTY=$(tty) 


# Aliases #
alias cls="clear"
alias ls="ls -a"
alias vim="nvim"
alias fsize="du -hd 1"
alias nmap="sudo nmap"
alias git-submodules-update="git submodule update --init --recursive --remote --merge"
alias ss="kitten ssh"
alias htop="sudo htop"
alias finder="open"

alias tls="tmux list-sessions"
alias tas="tmux attach-session -t"
alias trm="tmux kill-session -t"
alias tkill="tmux kill-server"
alias trename="tmux rename-session -t "
alias tsave="tmux-session save"
alias trestore="tmux-session restore"
alias trs="tmux-session restore"


# UI #
export PROMPT='%F{80}[%1~]%{$reset_color%} %{$fg[cyan]%}${vcs_info_msg_0_}%{$reset_color%}%F{218}>%{$reset_color%} '


# Other #
