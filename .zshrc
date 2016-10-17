ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bernardo"
XDG_CONFIG_HOME=$HOME/.config

# Add my scripts to path
SCRIPTS_PATH="$HOME/Code/scripts"
export PATH="$PATH:$SCRIPTS_PATH"

# Sourcing
plugins=(rails osx brew gitfast zsh-autosuggestions)
source $XDG_CONFIG_HOME/zsh/git.sh
source $ZSH/oh-my-zsh.sh
[ -f $XDG_CONFIG_HOME/zsh/work.sh ] && source $XDG_CONFIG_HOME/zsh/work.sh

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

# ripgrep
unalias rg
alias ag="rg"
alias ack="rg"
alias grep="rg"

# hub
alias git='hub'
eval "$(hub alias -s)"

# FZF
export FZF_DEFAULT_COMMAND='rg --files'

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)" 2> /dev/null

# Node
export PATH="$PATH:/usr/local/share/npm/bin"
export NODE_PATH="/usr/local/lib/node"

# GO
export GOPATH="$HOME/Code/golang"
export PATH="$GOPATH/bin:$PATH:/usr/local/opt/go/libexec/bin"
