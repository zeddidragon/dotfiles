#!/usr/bin/env bash
#
# Usage: ./update.sh [pattern]
#
# Specify [pattern] to update only repos that match the pattern.

repos=(
  morhetz/gruvbox
  kchmck/vim-coffee-script
  airblade/vim-gitgutter
  wavded/vim-stylus
  tikhomirov/vim-glsl
  plasticboy/vim-markdown
  pangloss/vim-javascript
  ElmCast/elm-vim
  cespare/vim-toml
  elixir-lang/vim-elixir
  rust-lang/rust.vim
  mileszs/ack.vim
  tpope/vim-fugitive
  sindresorhus/pure
  DFurnes/purer
  ajh17/VimCompletesMe
  vim-scripts/dbext.vim
  fidian/hexmode
  digitaltoad/vim-pug
  iamcco/markdown-preview.nvim
  statico/vim-javascript-sql
  lifepillar/pgsql.vim
  vim-scripts/bbcode
  ollykel/v-vim
  dense-analysis/ale
  tpope/vim-vinegar
  tpope/vim-abolish
  junegunn/goyo.vim
  goldfeld/vim-seek
  junegunn/limelight.vim
  zah/nim.vim
  sgur/vim-editorconfig
  calviken/vim-gdscript3
  martinda/Jenkinsfile-vim-syntax
)

set -e
dir=vimfiles/bundle

if [ -d "$dir" -a -z "$1" ]; then
  temp="$(mktemp -d)"
  echo "▲ Moving old bundle dir to $temp"
  mv "$dir" "$temp"
fi

mkdir -p "$dir"

for repo in ${repos[@]}; do
  if [ -n "$1" ]; then
    if ! (echo "$repo" | grep -i "$1" &>/dev/null) ; then
      continue
    fi
  fi
  plugin="$(basename $repo | sed -e 's/\.git$//')"
  dest="$dir/$plugin"
  rm -rf "$dest"
  (
    git clone --depth=1 -q "https://github.com/$repo" "$dest"
    rm -rf "$dest/.git"
    echo "· Cloned $repo"
    [ "$plugin" = "onehalf" ] && (mv "$dest" "$dest.TEMP" && mv "$dest.TEMP/vim" "$dest" && rm -rf "$dest.TEMP")
  ) &
done
wait
