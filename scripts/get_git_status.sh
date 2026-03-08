
#!/bin/bash

# Get the current terminal's working directory
current_dir=$(pwd)


cd "$current_dir" ||  { echo ""; exit 0; }

if ! git rev-parse --show-toplevel >/dev/null 2>&1; then
    exit 0
fi

status=$(git status 2>/dev/null)

dirty=$(echo "$status" | grep "modified:" >/dev/null; echo $?)
untracked=$(echo "$status" | grep "Untracked files" >/dev/null; echo $?)
ahead=$(echo "$status" | grep "Your branch is ahead of" >/dev/null; echo $?)
newfile=$(echo "$status" | grep "new file:" >/dev/null; echo $?)
renamed=$(echo "$status" | grep "renamed:" >/dev/null; echo $?)
deleted=$(echo "$status" | grep "deleted:" >/dev/null; echo $?)

bits=""

if [ "$renamed" = "0" ] || \
   [ "$ahead" = "0" ] || \
   [ "$newfile" = "0" ] || \
   [ "$untracked" = "0" ] || \
   [ "$deleted" = "0" ] || \
   [ "$dirty" = "0" ]; then
    bits="!"
fi

echo "$bits"
