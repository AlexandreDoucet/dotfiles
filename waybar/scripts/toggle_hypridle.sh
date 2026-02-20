if pkill -x hypridle; then
  echo "hypridle stopped"
else
  hypridle &
  echo "hypridle started"
fi
