#!/bin/bash

plugins="ctrlp kien/ctrlp.vim.git
fugitive tpope/vim-fugitive.git
nerdtree scrooloose/nerdtree.git
rainbow_parentheses kien/rainbow_parentheses.vim.git
plantuml aklt/plantuml-syntax.git
markdown plasticboy/vim-markdown
tabular godlygeek/tabular
vim-msbuild heaths/vim-msbuild.git
rust rust-lang/rust.vim"

for p in "$plugins"; do
  echo "$p" | while read pref repo; do
    git subtree pull --squash --prefix=bundle/${pref} https://github.com/${repo} master
  done
done
