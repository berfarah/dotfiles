# Doesn't use ~/.inputrc because zsh doesn't use readline
export KEYTIMEOUT=1
# Vim mode block cursor
function zle-keymap-select zle-line-init {
    # change cursor shape in iTerm2
    case $KEYMAP in
        vicmd)      print -n -- "\e[2 q";;  # block cursor
        viins|main) print -n -- "\e[6 q";;  # line cursor
    esac

    zle reset-prompt
    zle -R
}

autoload -Uz edit-command-line
zsh-vim-noop () {}
zsh-vim-exit() { exit }
zle -N zsh-vim-noop
zle -N zsh-vim-exit
zle -N zle-line-init
zle -N zle-keymap-select
zle -N edit-command-line

bindkey -v
bindkey -M vicmd 'v' edit-command-line
bindkey -M vicmd ":" zsh-vim-noop
bindkey -M vicmd ":q" zsh-vim-exit
bindkey -M vicmd "/" fzf-history-widget
bindkey -M vicmd "?" history-incremental-search-forward
bindkey '^r' fzf-history-widget
bindkey -M vicmd "^r" fzf-history-widget
bindkey -M vicmd "G" end-of-history
bindkey -M vicmd "gg" beginning-of-history

# NeoVim
if (( $+commands[nvim] )); then
  alias vim="nvim"
  alias vi="nvim"
  export VISUAL="nvim"
  export EDITOR=$VISUAL
fi
