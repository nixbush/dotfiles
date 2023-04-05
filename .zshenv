##############################
# Environment Variables
##############################
# Core environment
export EDITOR="nvim"

# ZSH Config
export HISTFILE=~/.cache/history
export HISTSIZE=1000
export SAVEHIST=1000
export KEYTIMEOUT=1

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# GTK Settings
export GTK_THEME='Dracula'

# Qt Settings
export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME=qt5ct

# Less config
export LESS='-FiJMRWXx3 -z4'
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'
