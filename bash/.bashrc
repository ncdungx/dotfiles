#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    exec tmux new-session -A -s ${USER} >/dev/null 2>&1
fi

PS1='\[\033[0;32m\][\u@\h:\W]\$\[\033[0m\] '

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -alh'
alias grep='grep --color=auto'

alias autoremove='pacman -Qdtq | sudo pacman -Rns -'
