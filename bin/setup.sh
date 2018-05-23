#!/bin/bash

RUBY_VERSION="2.5.0"
NODE_VERSION="8.9.4"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Installing dev tools"
xcode-select --install

echo "Gathering dependencies"
mkdir -p $HOME/dev/berfarah
git clone git@github.com:berfarah/dotfiles.git $HOME/dev/berfarah/dotfiles
cd $HOME/dev/berfarah/dotfiles

echo "Installing Oh-My-Zsh"
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

echo "Installing Homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing homebrew dependencies"
brew bundle

echo "Installing FZF shell extensions"
/usr/local/opt/fzf/install

echo "Symlinking dotfiles"
./bin/link.sh

echo "Setting up Ruby"
eval "$(rbenv init -)" 2> /dev/null
git clone git://github.com/tpope/rbenv-ctags.git ~/.rbenv/plugins/rbenv-ctags
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
gem install --conservative gem-ctags bundler rubocop

echo "Setting up Node"
eval "$(nodenv init -)" 2> /dev/null
nodenv install $NODE_VERSION
nodenv global $NODE_VERSION
yarn global add eslint typescript

echo "Copying over old preferences"
chmod 0600 ./plists/*
cp -R ./plists/ ~/Library/Preferences/

# Set a bunch of settings
./bin/macos.sh

echo "Done!"
