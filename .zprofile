# ! Read at login ! #

# Meta configs #
autoload -U colors && colors
autoload -Uz vcs_info

# Automatic configs required by the tools I use #
eval "$(/opt/homebrew/bin/brew shellenv)"

# oh-my-zsh setup #
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

CASE_SENSITIVE="true"

zstyle ':omz:update' mode disabled  # disable automatic updates
plugins=(git)
source $ZSH/oh-my-zsh.sh

precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b) '

# Overwriting default configs #
HISTSIZE=100000
HISTFILESIZE=200000


# Added by Toolbox App
export PATH="$PATH:/Users/tom/Library/Application Support/JetBrains/Toolbox/scripts"


# Setting PATH for Python 2.7
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
