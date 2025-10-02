# ! Read at login ! #

# Meta configs #
autoload -U colors && colors
autoload -Uz vcs_info

# Automatic configs required by the tools I use #
eval "$(/opt/homebrew/bin/brew shellenv)"

# oh-my-zsh setup #
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

CASE_SENSITIVE="false"

zstyle ':omz:update' mode disabled  # disable automatic updates
plugins=(git)
source $ZSH/oh-my-zsh.sh

precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b) '
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Overwriting default configs #
HISTSIZE=100000
HISTFILESIZE=200000
