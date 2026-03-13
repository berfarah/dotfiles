export XDG_CONFIG_HOME="$HOME/.config"
eval "$(/opt/homebrew/bin/brew shellenv)"

# =========================================================
# Completion
# =========================================================
autoload -Uz compinit
# Only regenerate .zcompdump once per day
if [[ -z "$ZSH_COMPDUMP" ]]; then
  ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
fi
if [[ "$ZSH_COMPDUMP"(#qNmh-24) ]]; then
  compinit -C
else
  compinit
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CONFIG_HOME}/zsh/.zcompcache"

# =========================================================
# History
# =========================================================
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# =========================================================
# Shell options
# =========================================================
setopt AUTO_CD
setopt AUTO_PUSHD
setopt INTERACTIVE_COMMENTS

# =========================================================
# Colors
# =========================================================
autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
alias ls="ls -G"

# =========================================================
# PATH & Environment
# =========================================================
export PROJECTS_PATH="$HOME/dev"
export PATH="$HOME/.bin:$PATH"

# mise (manages Node, Go, etc.)
eval "$(mise activate zsh)"

# Go
export GOPATH="$HOME/dev/golang"
export PATH="$GOPATH/bin:$PATH"

# =========================================================
# Plugins
# =========================================================
source "$XDG_CONFIG_HOME/zsh/plugins/bernardo/bernardo.plugin.zsh"

# =========================================================
# Prompt — Starship (must be after bindkey -v in vim.zsh)
# =========================================================
eval "$(starship init zsh)"
