#
# ~/.bashrc
#
source /usr/share/git/completion/git-prompt.sh
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='\[\033[01;32m\][\u@\h \[\033[01;34m\]\w\[\033[01;32m\]]\$ \[\033[00m\]$(__git_ps1 "\[\033[01;36m\](%s)\[\033[00m\]")\$ '
#PS1='\[\033[01;32m\][\u@\h \[\033[01;34m\]\w\[\033[01;32m\]]\[\033[00m\]$(__git_ps1 " \[\033[01;36m\](%s)\[\033[00m\]")\[$(git diff --quiet 2>/dev/null || git status --porcelain 2>/dev/null | grep -q "??" && echo "\033[01;33m *\033[00m")\]\$ '

#PS1='\[\033[01;32m\][\u@\h \[\033[01;34m\]\w\[\033[01;32m\]]\[\033[00m\]$(__git_ps1 " \[\033[01;36m\](%s)\[\033[00m\]")\[$(git status --porcelain 2>/dev/null | grep -q "^[AM]" || git status --porcelain 2>/dev/null | grep -q "??" && echo "\033[01;33m *\033[00m")\]\$ '


export PATH="$HOME/.config/dotfiles/scripts:$PATH"
#PS1='\[\033[01;32m\][\u@\h \[\033[01;34m\]\w\[\033[01;32m\]]\[\033[00m\]$(__git_ps1 " \[\033[01;36m\](%s)\[\033[00m\]")\[$(./get_git_status.sh | grep -q "??" && echo "\033[01;33m *\033[00m")\]\$ '




PS1='\[\033[01;32m\][\u@\h \[\033[01;34m\]\w\[\033[01;32m\]]\$ \[\033[00m\]$(__git_ps1 "\[\033[01;36m\](%s)\[\033[00m\]")\[\033[01;33m\]$(get_git_status.sh) \[\033[00m\]\$ '
