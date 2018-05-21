#!/bin/bash

DIR="$(dirname $(cd $(dirname $0) && pwd -P))"

DOTFILES=$DIR/home/.[a-z]*

for source_file in $DOTFILES; do
  target_file="$HOME/$(basename $source_file)"
  echo "ln -sf $source_file $target_file"
  ln -s $source_file $target_file
done
