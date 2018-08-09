#!/bin/bash

set -e

DIR="$(dirname $(cd $(dirname $0) && pwd -P))"
SOURCE=$DIR/vscode
VSCODE="$HOME/Library/Application Support/Code/User"

echo "Symlinking..."
mkdir -p "$(dirname "$VSCODE")"
gln -sfT "$SOURCE" "$VSCODE"
if [ "$?" -ne "0" ]; then
  echo "Found an existing User directory, backing up..."
  mv "$VSCODE" "$VSCODE.backup" && echo "Backed up to $VSCODE.backup"
  gln -sfT "$SOURCE" "$VSCODE"
fi

extensions=(
  eamodio.gitlens
  eg2.tslint
  lehni.vscode-titlebar-less-macos
  ms-vscode.Go
  rebornix.ruby
  tobiasalthoff.atom-material-theme
  vscodevim.vim
)

for extension in "${extensions[@]}"; do
  code --install-extension $extension
done
