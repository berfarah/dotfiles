#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "Gathering dependencies"
mkdir -p $HOME/dev/berfarah
git clone https://github.com/berfarah/dotfiles.git $HOME/dev/berfarah/dotfiles
cd $HOME/dev/berfarah/dotfiles && git pull

echo "Installing Oh-My-Zsh"
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# ========
printf "Detecting OS... "
if [[ "$OSTYPE" == "darwin"* ]]; then
  print "macos!"

  echo "Installing Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo "Installing homebrew dependencies"
  brew bundle

  echo "Copying over old preferences"
  chmod 0600 ./plists/*
  cp -R ./plists/ ~/Library/Preferences/

  echo "Configuring miscellaneous mac settings"
  ./bin/configure.sh

  echo "Installing FZF shell extensions"
  /usr/local/opt/fzf/install
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  print "linux!"

  echo "Installing Linux apps"
  ./bin/linux-install.sh
else
  echo "Unsupported OS: $OSTYPE, exiting"
fi

echo "Symlinking dotfiles"
./bin/link.sh

echo "Done!"
