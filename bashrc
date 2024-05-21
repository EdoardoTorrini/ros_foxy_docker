# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# for pwndbg
LC_CTYPE=C.UTF-8

export DISPLAY=:10.0
export XDG_RUNTIME_DIR=~/.cache/xdgr
source /opt/ros/foxy/setup.bash
