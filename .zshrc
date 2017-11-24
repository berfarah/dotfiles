XDG_CONFIG_HOME=$HOME/.config
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="geometry"
ZSH_CUSTOM=$XDG_CONFIG_HOME/zsh

# Add my scripts to the path
export PROJECTS_PATH="$HOME/dev"
export PATH="$HOME/.bin:$PATH"

# Sourcing
plugins=(
  rake-fast
  gitfast
  osx
  vi-mode
  bernardo
)
source $ZSH/oh-my-zsh.sh

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)" 2> /dev/null

# Node
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)" 2> /dev/null

# GO
export GOPATH="$HOME/dev/golang"
export PATH="$GOPATH/bin:$PATH:/usr/local/opt/go/libexec/bin"
