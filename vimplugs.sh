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
  pangloss/vim-javascript.git
  ElmCast/elm-vim
  cespare/vim-toml.git
  elixir-lang/vim-elixir.git
  rust-lang/rust.vim.git
  mileszs/ack.vim.git
  tpope/vim-fugitive.git
  sindresorhus/pure.git
  DFurnes/purer.git
  ajh17/VimCompletesMe
  vim-scripts/dbext.vim.git
  fidian/hexmode.git
  digitaltoad/vim-pug.git
  iamcco/markdown-preview.nvim.git
  statico/vim-javascript-sql.git
  lifepillar/pgsql.vim.git
  vim-scripts/bbcode.git
  ollykel/v-vim.git
  dense-analysis/ale.git
  tpope/vim-vinegar.git
  tpope/vim-abolish.git
  junegunn/goyo.vim
  justinmk/vim-sneak
  rakr/vim-two-firewatch
  zefei/cake16
)

set -e
dir=vimfiles/bundle

if [ -d "$dir" -a -z "$1" ]; then
  if which trash &>/dev/null; then
    echo "▲ Moving old bundle dir to trash"
    trash "$dir"
  elif which gio &>/dev/null; then
    echo "▲ Moving old bundle dir to trash"
    gio trash "$dir"
  else
    temp="$(mktemp -d)"
    echo "▲ Moving old bundle dir to $temp"
    mv "$dir" "$temp"
  fi
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
