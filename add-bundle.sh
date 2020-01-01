#!/bin/bash

plugin="ctrlp kien/ctrlp.vim.git"

for p in "$plugin"; do
  echo "$p" | while read pref repo; do
    echo git subtree add --squash --prefix=bundle/${pref} https://github.com/${repo} master
  done
done
