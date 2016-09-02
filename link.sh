#!/bin/bash

DIR=$(cd $(dirname $0) && pwd -P)

# Copy over .oh-my-zsh contents if it exists/is not a symlink
if [ -d ~/.oh-my-zsh -a ! -L ~/.oh-my-zsh ]; then
  cp -R ~/.oh-my-zsh/ $DIR/.oh-my-zsh/
fi

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
