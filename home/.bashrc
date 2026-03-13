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


# FZF
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--bind tab:toggle-out,shift-tab:toggle-in,ctrl-a:select-all,ctrl-d:deselect-all'

# mise (manages Node, Go, etc.)
eval "$(mise activate bash)"

# GO
export GOPATH="$HOME/Code/golang"
export PATH="$GOPATH/bin:$PATH:/usr/local/opt/go/libexec/bin"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
