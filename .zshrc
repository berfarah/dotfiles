ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bernardo"
XDG_CONFIG_HOME=$HOME/.config

# Add my scripts to path
SCRIPTS_PATH="$HOME/Code/scripts"
export PATH="$PATH:$SCRIPTS_PATH"

# Sourcing
plugins=(rails osx brew gitfast zsh-autosuggestions)
source $XDG_CONFIG_HOME/zsh/git.sh
[ -f $XDG_CONFIG_HOME/zsh/work.sh ] && source $XDG_CONFIG_HOME/zsh/work.sh
source $ZSH/oh-my-zsh.sh

# Additional aliases
alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias resource='source ~/.zshrc'
alias cdc='cd ~/Code'

# NeoVim
if [ -f `which nvim` ]; then
  alias vim="nvim"
  alias vi="nvim"
  export VISUAL="nvim"
  export EDITOR=$VISUAL
fi

# FZF
export FZF_DEFAULT_COMMAND='ag -g ""'

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)" 2> /dev/null

# Node
export PATH="$PATH:/usr/local/share/npm/bin"
export NODE_PATH="/usr/local/lib/node"

# GO
export GOPATH="$HOME/Code/golang"
export PATH="$GOPATH/bin:$PATH:/usr/local/opt/go/libexec/bin"
