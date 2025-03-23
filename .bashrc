#
# ~/.bashrc
#
source /usr/share/git/completion/git-prompt.sh
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\033[01;32m\][\u@\h \[\033[01;34m\]\w\[\033[01;32m\]]\$ \[\033[00m\]$(__git_ps1 "\[\033[01;36m\](%s)\[\033[00m\]")\$ '
