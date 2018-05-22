#!/bin/bash

DIR="$(dirname $(cd $(dirname $0) && pwd -P))"

DOTFILES=$DIR/home/.[a-z]*

for source_file in $DOTFILES; do
  target_file="$HOME/$(basename $source_file)"
  # Overwrite symlinks, files and directories with the new symlink
  ln -nsfF $source_file $target_file
done
