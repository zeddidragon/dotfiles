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
ignore_vimplugs=1

canonicalize_path() {
    if [ -d "$1" ]; then
        _canonicalize_dir_path "$1"
    else
        _canonicalize_file_path "$1"
    fi
}

_canonicalize_dir_path() {
    (cd "$1" 2>/dev/null && pwd -P)
}

_canonicalize_file_path() {
    local dir file
    dir=$(dirname -- "$1")
    file=$(basename -- "$1")
    (cd "$dir" 2>/dev/null && printf '%s/%s\n' "$(pwd -P)" "$file")
}

link() {
  path=$(canonicalize_path $1)
  target=$2
  as="$HOME/$target"
  rm $as 2> /dev/null
  echo "$path -> $as"
  ln -s $path $as
}

for path in ./*; do
  file="${path##*/}"
  check=ignore_${file%.[^.]*}

  if [[ ${!check} = "1" ]]; then continue; fi
  link $path ".$file"
done

link ./vimfiles .vim
link ./z/z.sh z.sh
mkdir -p "$HOME/.zfunctions"
