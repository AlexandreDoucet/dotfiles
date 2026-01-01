#
# ~/.bashrc
#
#
export LFS=/mnt/lfs


source /usr/share/git/completion/git-prompt.sh
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias hypr_reload_paper='sh ~/.config/hypr/hyprpaper'
alias obsidian_a='cd ~/Documents/ObsidianVault/Obsidian/ && git pull && nvim ~/Documents/ObsidianVault/Obsidian/'
oobsidian() {
  cd ~/Documents/ObsidianVault/Obsidian/ || return;
  git pull;
  nvim ~/Documents/ObsidianVault/Obsidian/;

  timestamp=$(date +"%Y-%m-%d %H:%M:%S");
  git add -A;
  git commit -m "Update Obsidian notes - $timestamp";
  git push

  git status;
  cd -
}


bashrc() {
  path="$HOME/.config/dotfiles"

  cd "$path" || return
  git pull

  nvim "$path/.bashrc"

  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  git add -A

  # only commit if there are changes
  if ! git diff --cached --quiet; then
    git commit -m "Update bashrc - $timestamp"
    git push
  fi

  git status
  cd - >/dev/null || return
}


#PS1='\[\033[01;32m\][\u@\h \[\033[01;34m\]\w\[\033[01;32m\]]\$ \[\033[00m\]$(__git_ps1 "\[\033[01;36m\](%s)\[\033[00m\]")\$ '
#PS1='\[\033[01;32m\][\u@\h \[\033[01;34m\]\w\[\033[01;32m\]]\[\033[00m\]$(__git_ps1 " \[\033[01;36m\](%s)\[\033[00m\]")\[$(git diff --quiet 2>/dev/null || git status --porcelain 2>/dev/null | grep -q "??" && echo "\033[01;33m *\033[00m")\]\$ '

#PS1='\[\033[01;32m\][\u@\h \[\033[01;34m\]\w\[\033[01;32m\]]\[\033[00m\]$(__git_ps1 " \[\033[01;36m\](%s)\[\033[00m\]")\[$(git status --porcelain 2>/dev/null | grep -q "^[AM]" || git status --porcelain 2>/dev/null | grep -q "??" && echo "\033[01;33m *\033[00m")\]\$ '


export PATH="$HOME/.config/dotfiles/scripts:$PATH"
#PS1='\[\033[01;32m\][\u@\h \[\033[01;34m\]\w\[\033[01;32m\]]\[\033[00m\]$(__git_ps1 " \[\033[01;36m\](%s)\[\033[00m\]")\[$(./get_git_status.sh | grep -q "??" && echo "\033[01;33m *\033[00m")\]\$ '




PS1='\[\033[01;32m\][\u@\h \[\033[01;34m\]\w\[\033[01;32m\]]\$ \[\033[00m\]$(__git_ps1 "\[\033[01;36m\](%s)\[\033[00m\]")\[\033[01;33m\]$(get_git_status.sh) \[\033[00m\]\$ '
. "$HOME/.cargo/env"

[[ "$(tty)" == /dev/tty1 ]] && Hyprland

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH="/home/adoucet/.rustup/toolchains/esp/xtensa-esp-elf/esp-15.2.0_20250920/xtensa-esp-elf/bin:$PATH"
export LIBCLANG_PATH="/home/adoucet/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-20.1.1_20250829/esp-clang/lib"


export PATH="/home/adoucet/.rustup/toolchains/esp/xtensa-esp-elf/esp-15.2.0_20250920/xtensa-esp-elf/bin:$PATH"
export LIBCLANG_PATH="/home/adoucet/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-20.1.1_20250829/esp-clang/lib"

source $HOME/export-esp.sh



if [ -z "$SSH_AGENT_PID" ]; then
    eval "$(ssh-agent -s)"
fi

if ! ssh-add -l > /dev/null; then
    ssh-add ~/.ssh/gitlab_ed25519
    ssh-add ~/.ssh/id_ed25519
fi
