#!/bin/bash

RUBY_VERSION="2.5.0"
NODE_VERSION="8.9.4"
DOTFILES_DIR="$HOME/dev/berfarah/dotfiles"

echo "Installing dev tools"
xcode-select --install

echo "Gathering dependencies"
mkdir -p $DOTFILES_DIR
curl -sL https://github.com/berfarah/dotfiles/archive/master.tar.gz | tar -xz -C $DOTFILES_DIR --strip-components=1
cd $DOTFILES_DIR

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

# =======================================
# Settings
# =======================================

# iTerm
echo "Copying over old preferences"
chmod 0600 ./plists/*
cp -R ./plists/ ~/Library/Preferences/

# Alfred (enable sync)
echo "Configuring Alfred"
killall Alfred &> /dev/null
defaults write com.runningwithcrayons.Alfred-Preferences-3 syncfolder -string "~/Library/Mobile Documents/com~apple~CloudDocs/Alfred"

# Magnet (konfigure keyboard shortcuts)
echo "Configuring Magnet"
killall Magnet &> /dev/null
defaults write com.crowdcafe.windowmagnet expandWindowEastComboKey -dict keyCode 124 modifierFlags 1572864
defaults write com.crowdcafe.windowmagnet expandWindowWestComboKey -dict keyCode 123 modifierFlags 1572864
defaults write com.crowdcafe.windowmagnet maximizeWindowComboKey -dict keyCode 126 modifierFlags 1572864
defaults write com.crowdcafe.windowmagnet restoreWindowComboKey -dict keyCode 125 modifierFlags 1572864

# Dash (enable sync)
echo "Configuring Dash"
killall Dash &> /dev/null
defaults write com.kapeli.dashdoc.plist syncFolderPath -string "~/Library/Mobile Documents/com~apple~CloudDocs"
defaults write com.kapeli.dashdoc.plist shouldSyncBookmarks -bool true
defaults write com.kapeli.dashdoc.plist shouldSyncDocsets -bool true
defaults write com.kapeli.dashdoc.plist shouldSyncGeneral -bool true
defaults write com.kapeli.dashdoc.plist shouldSyncView -bool true

# Set a bunch of settings
./bin/macos.sh

echo "Done!"
