#!/bin/bash

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

if ! git diff --quiet --ignore-submodules 2>/dev/null ||
   ! git diff --cached --quiet --ignore-submodules 2>/dev/null ||
   [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
    echo "!"
fi
