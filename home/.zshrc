XDG_CONFIG_HOME=$HOME/.config
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="geometry"
ZSH_CUSTOM=$XDG_CONFIG_HOME/zsh

# Add my scripts to the path
export PROJECTS_PATH="$HOME/dev"
export PATH="$HOME/.bin:$PATH"

# Sourcing
plugins=(
  golang
  # rake-fast
  gitfast
  osx
  bernardo
)
source $ZSH/oh-my-zsh.sh

# Ruby
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init --no-rehash -)" 2> /dev/null
# (rbenv rehash &) 2> /dev/null # background rehash - much faster

# Node
# export PATH="$HOME/.nodenv/bin:$PATH"
# eval "$(nodenv init --no-rehash -)" 2> /dev/null
# (nodenv rehash &) 2> /dev/null # background rehash - much faster

# GO
export GOPATH="$HOME/dev/golang"
export PATH="$GOPATH/bin:$PATH:/usr/local/opt/go/libexec/bin"

eval "$(direnv hook zsh)"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

export AWS_CONFIG_FILE=$PROJECTS_PATH/samsara/backend/.aws/config
export AWS_DEFAULT_PROFILE=readonly

ssh-dev() {
  ssh -t devbox 'cd /home/ubuntu/co/backend && exec $SHELL -l' || \
    taskrunner devbox/run
}
