# ~/.bash_profile

if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi

if [[ "$(tty)" == "/dev/tty1" ]] && uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi

eval "$(devenv hook bash)"
