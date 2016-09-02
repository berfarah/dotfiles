#!/bin/bash

DIR=$(cd $(dirname $0) && pwd -P)
DOTFILES=`find $DIR \
  -not -name ".git" \
  -not -name ".gitignore" \
  -not -name "link.sh"\
  -not -name "README.md" \
  -mindepth 1 \
  -maxdepth 1 \
  2>/dev/null`

for file in $DOTFILES; do
  destination=$HOME/`basename $file`
  rm -rf $destination
  ln -s $file $destination
done
