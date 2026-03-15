#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "Gathering dependencies"
mkdir -p $HOME/dev/berfarah
git clone https://github.com/berfarah/dotfiles.git $HOME/dev/berfarah/dotfiles
cd $HOME/dev/berfarah/dotfiles && git pull

# ========
printf "Detecting OS... "
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "macos!"

  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo "Installing homebrew dependencies"
  brew bundle

  echo "Configuring miscellaneous mac settings"
  $HOME/dev/berfarah/dotfiles/bin/configure.sh

  echo "Installing FZF shell extensions"
  "$(brew --prefix fzf)/install"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "linux!"

  echo "Installing Linux apps"
  $HOME/dev/berfarah/dotfiles/bin/linux_install.sh
else
  echo "Unsupported OS: $OSTYPE, exiting"
fi

echo "Symlinking dotfiles"
$HOME/dev/berfarah/dotfiles/bin/link.sh

if command -v mise &>/dev/null; then
  echo "Installing Node via mise"
  eval "$(mise activate bash)"
  mise use --global node@23.7.0
  npm i -g typescript typescript-language-server vscode-langservers-extracted
fi

echo "Done!"
