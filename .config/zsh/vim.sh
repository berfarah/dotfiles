# Vim mode block cursor
function zle-keymap-select zle-line-init {
    # change cursor shape in iTerm2
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
        viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
    esac

    zle reset-prompt
    zle -R
}

zsh-vim-noop () {}
zsh-vim-exit() { exit }
zle -N zsh-vim-noop
zle -N zsh-vim-exit
zle -N zle-line-init
zle -N zle-keymap-select

bindkey -M vicmd ":" zsh-vim-noop
bindkey -M vicmd ":q" zsh-vim-exit
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "^R" history-incremental-search-backward
bindkey -M vicmd "G" end-of-history
bindkey -M vicmd "gg" beginning-of-history

# NeoVim
if [ -f "$(which nvim)" ]; then
  alias vim="nvim"
  alias vi="nvim"
  export VISUAL="nvim"
  export EDITOR=$VISUAL
fi
