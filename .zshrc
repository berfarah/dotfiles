ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bernardo"
XDG_CONFIG_HOME=$HOME/.config

export PROJECTS_PATH="$HOME/dev"

# Add my scripts to the path
export PATH="$HOME/.bin:$PATH"

# Sourcing
plugins=(rails osx gitfast rake-fast vi-mode)
source $ZSH/oh-my-zsh.sh
source $HOME/.fzf.zsh
source $XDG_CONFIG_HOME/zsh/git.sh
source $XDG_CONFIG_HOME/zsh/vim.sh

# Additional aliases
alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias resource='source ~/.zshrc'
alias dev="cd $PROJECTS_PATH"

# ripgrep
unalias rg
alias ag='rg'

# hub
alias git=hub

# FZF
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--bind tab:toggle-out,shift-tab:toggle-in,ctrl-a:select-all,ctrl-d:deselect-all'

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)" 2> /dev/null

# Node
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)" 2> /dev/null

# GO
export GOPATH="$HOME/Code/golang"
export PATH="$GOPATH/bin:$PATH:/usr/local/opt/go/libexec/bin"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
