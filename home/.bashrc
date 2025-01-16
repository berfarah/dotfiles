XDG_CONFIG_HOME=$HOME/.config

export PROJECTS_PATH="$HOME/dev"

# Add my scripts to the path
export PATH="$HOME/.bin:$PATH"

# Additional aliases
alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias resource='source ~/.bashrc'
alias dev="cd $PROJECTS_PATH"

# ripgrep
alias ag='rg'

# hub
alias git=hub

# FZF
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--bind tab:toggle-out,shift-tab:toggle-in,ctrl-a:select-all,ctrl-d:deselect-all'

# Node
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init --no-rehash -)" 2> /dev/null
(nodenv rehash &) 2> /dev/null # background rehash - much faster

# GO
export GOPATH="$HOME/Code/golang"
export PATH="$GOPATH/bin:$PATH:/usr/local/opt/go/libexec/bin"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
