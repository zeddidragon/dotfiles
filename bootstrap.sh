#!/usr/bin/env bash

# dotfiles bootstrapper, written exactly as advanced as I currently need it
# if you had something already that matches the dotfile name,
# then tough, it's getting deleted

ignore_vimfiles=1
ignore_keymap=1
ignore_z=1
ignore_submodules=1
ignore_bootstrap=1
ignore_cache=1

link() {
  path=$1
  file="${path##*/}"
  target=$2
  as="$HOME/$target"
  rm $as
  ln -s $path $as
}

for path in ./*; do
  file="${path##*/}"
  check=ignore_${file%.[^.]*}

  if [[ ${!check} = "1" ]]; then continue; fi
  link $path ".$file"
done

link ./vimfiles .vim
link ./z/z.sh .z.sh
mkdir -p "$HOME/.zfunctions"
link ./submodules/pure/pure.zsh .zfunctions/prompt_pure_setup
link ./submodules/pure/async.zsh .zfunctions/async
