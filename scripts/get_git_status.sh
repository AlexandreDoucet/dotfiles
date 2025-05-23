
#!/bin/bash

# Get the current terminal's working directory
current_dir=$(pwd)


cd "$current_dir" ||  { echo ""; exit 0; }

# Check if we're in a Git repository
if [ ! -d ".git" ]; then
  echo ""
  exit 0  # Exit if not inside a Git repo
fi
# Get the Git status and store the result
status=$(git status)

# Echo the git status result

# Get the current terminal's working directory


        status=`git status 2>&1 | tee`
        dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
        untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
        ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
        newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
        renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
        deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
        bits=''
        if [ "${renamed}" == "0" ]; then
                #bits="!${bits}"
                bits="!"
        fi
        if [ "${ahead}" == "0" ]; then
                bits="!"
        fi
        if [ "${newfile}" == "0" ]; then
                bits="!"
        fi
        if [ "${untracked}" == "0" ]; then
                bits="!"
        fi
        if [ "${deleted}" == "0" ]; then
                bits="!"
        fi
        if [ "${dirty}" == "0" ]; then
                bits="!"
        fi
        if [ ! "${bits}" == "" ]; then
                echo "${bits}"
        else
                echo ""
        fi
