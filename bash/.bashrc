#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[0;32m\][\u@\h:\W]\$\[\033[0m\] '

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -alh'
alias grep='grep --color=auto'

alias ru='paru'
alias autoremove='pacman -Qdtq | sudo pacman -Rns -'
alias upgrade-lts='sudo pacman -S linux-lts linux-lts-headers'
