ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bernardo"
XDG_CONFIG_HOME=$HOME/.config

# Add my scripts to path
SCRIPTS_PATH="$HOME/Code/scripts"
export PATH="$PATH:$SCRIPTS_PATH"

# Sourcing
plugins=(rails osx gitfast)
source $XDG_CONFIG_HOME/zsh/git.sh
source $ZSH/oh-my-zsh.sh

# Additional aliases
alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias resource='source ~/.zshrc'
alias cdc='cd ~/Code'

# NeoVim
if [ -f "$(which nvim)" ]; then
  alias vim="nvim"
  alias vi="nvim"
  export VISUAL="nvim"
  export EDITOR=$VISUAL
fi

# ripgrep
unalias rg
alias ag="rg"

# hub
alias git=hub

# FZF
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--bind tab:toggle-out,shift-tab:toggle-in'

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)" 2> /dev/null

# Node
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)" 2> /dev/null

# GO
export GOPATH="$HOME/Code/golang"
export PATH="$GOPATH/bin:$PATH:/usr/local/opt/go/libexec/bin"

export PATH="$HOME/.yarn/bin:$PATH"
