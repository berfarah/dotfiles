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

  echo "Copying over old preferences"
  chmod 0600 ./plists/*
  cp -R ./plists/ ~/Library/Preferences/

  echo "Configuring miscellaneous mac settings"
  $HOME/dev/berfarah/dotfiles/bin/configure.sh

  echo "Installing FZF shell extensions"
  "$(brew --prefix fzf)/install"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "linux!"

  echo "Installing Linux apps"
  $HOME/dev/berfarah/dotfiles/bin/linux-install.sh
else
  echo "Unsupported OS: $OSTYPE, exiting"
fi

echo "Installing Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"



echo "Symlinking dotfiles"
$HOME/dev/berfarah/dotfiles/bin/link.sh

echo "Done!"
