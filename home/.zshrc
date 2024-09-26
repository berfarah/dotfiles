XDG_CONFIG_HOME=$HOME/.config
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="geometry"
ZSH_CUSTOM=$XDG_CONFIG_HOME/zsh
eval $(/opt/homebrew/bin/brew shellenv)

# Add my scripts to the path
export PROJECTS_PATH="$HOME/dev"
export PATH="$HOME/.bin:$PATH"

# Sourcing
plugins=(
  golang
  rake-fast
  gitfast
  macos
  bernardo
)
source $ZSH/oh-my-zsh.sh

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init --no-rehash -)" 2> /dev/null
(rbenv rehash &) 2> /dev/null # background rehash - much faster

# Node
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init --no-rehash -)" 2> /dev/null
(nodenv rehash &) 2> /dev/null # background rehash - much faster

# GO
export GOPATH="$HOME/dev/golang"
export PATH="$GOPATH/bin:$PATH:/usr/local/opt/go/libexec/bin"
