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
  vim-scripts/VimCompletesMe
  vim-scripts/dbext.vim
  fidian/hexmode
  digitaltoad/vim-pug
  iamcco/markdown-preview.nvim
  statico/vim-javascript-sql
  vim-scripts/bbcode
  ollykel/v-vim
  dense-analysis/ale
  tpope/vim-vinegar
  junegunn/goyo.vim
  goldfeld/vim-seek
  junegunn/limelight.vim
  sgur/vim-editorconfig
  martinda/Jenkinsfile-vim-syntax
  junegunn/fzf
  tmux-plugins/vim-tmux-focus-events
  ziglang/zig.vim
  radgeRayden/vim-scopes
  leafgarland/typescript-vim
  othree/html5.vim
  evanleck/vim-svelte
  neoclide/coc.nvim
  kenn7/vim-arsync
  habamax/vim-godot 
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
  echo "Cloning $repo"
  if [ -n "$1" ]; then
    if ! (echo "$repo" | grep -i "$1" &>/dev/null) ; then
      continue
    fi
  fi
  plugin="$(basename $repo | sed -e 's/\.git$//')"
  dest="$dir/$plugin"
  rm -rf "$dest"
  echo "· Cloning $repo"
  (
    git clone --depth=1 -q "https://github.com/$repo" "$dest"
    rm -rf "$dest/.git"
    [ "$plugin" = "onehalf" ] && (mv "$dest" "$dest.TEMP" && mv "$dest.TEMP/vim" "$dest" && rm -rf "$dest.TEMP")
  ) &
done
wait
