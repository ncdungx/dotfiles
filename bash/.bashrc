#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[0;32m\][\u@\h:\W]\$\[\033[0m\] '

if [ -x "$(command -v fcitx5-remote)" ] && [ -n "${DISPLAY}" ]; then
	sleep 0.05 && fcitx5-remote -c >/dev/null 2>&1
fi

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -alh'
alias grep='grep --color=auto'
alias autoremove='pacman -Qdtq | sudo pacman -Rns -'
