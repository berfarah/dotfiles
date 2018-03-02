# Based on Geometry
# https://github.com/frmendes/geometry

PROMPT_SYMBOL='▲'
EXIT_VALUE_SYMBOL="%{$fg[red]%}△%{$reset_color%}"
RPROMPT_SYMBOL='◇'

GIT_DIRTY="%{$fg[red]%}⬡%{$reset_color%}"
GIT_CLEAN="%{$fg[green]%}⬢%{$reset_color%}"
GIT_REBASE="\uE0A0"
GIT_UNPULLED="⇣"
GIT_UNPUSHED="⇡"

GIT_STAGED="%{$fg[cyan]%}+"
GIT_MODIFIED="%{$fg[yellow]%}~"
GIT_NEW="%{$fg[red]%}…%{$reset_color%}"

prompt_geometry_git_branch() {
  ref=$(git symbolic-ref --short HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $ref
}

prompt_geometry_git_dirty() {
  st="$(git status --porcelain --ignore-submodules)"
  if test -z $st; then
    echo $GIT_CLEAN
  else
    staged="$(git_staged_count $st)"
    modified="$(git_modified_count $st)"
    new="$(git_new_count $st)"
    echo "$staged$modified$new:: $GIT_DIRTY"
  fi
}

git_staged_count() {
  count="$(echo $1 | grep '^ \?A' | wc -l)"
  if test $count -ne 0; then
    echo "$GIT_STAGED${count##*( )}%{$reset_color%} "
  fi
}

git_modified_count() {
  count="$(echo $1 | grep '^ \?M' | wc -l)"
  if test $count -ne 0; then
    echo "$GIT_MODIFIED${count##*( )}%{$reset_color%} "
  fi
}

git_new_count() {
  if test -n "$(echo $1 | grep '^ \??')"; then
    echo "$GIT_NEW "
  fi
}

prompt_geometry_git_rebase_check() {
  git_dir=$(git rev-parse --git-dir)
  if test -d "$git_dir/rebase-merge" -o -d "$git_dir/rebase-apply"; then
    echo "$GIT_REBASE"
  fi
}

prompt_geometry_git_remote_check() {
  local_commit=$(git rev-parse @ 2>&1)
  remote_commit=$(git rev-parse @{u} 2>&1)
  common_base=$(git merge-base @ @{u} 2>&1) # last common commit
  commit_difference=$(git rev-list --count HEAD..origin 2>/dev/null)

  if [[ $local_commit == $remote_commit ]]; then
    echo ""
  else
    if [[ $common_base == $remote_commit ]]; then
      echo "$commit_difference $GIT_UNPUSHED"
    elif [[ $common_base == $local_commit ]]; then
      echo "$commit_difference n$GIT_UNPULLED"
    else
      echo "$GIT_UNPUSHED $GIT_UNPULLED"
    fi
  fi
}

prompt_geometry_git_symbol() {
  echo "$(prompt_geometry_git_rebase_check) $(prompt_geometry_git_remote_check) "
}

prompt_geometry_git_info() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "$(prompt_geometry_git_symbol)%F{242}$(prompt_geometry_git_branch)%{$reset_color%} :: $(prompt_geometry_git_dirty)"
  fi
}

prompt_geometry_print_title() {
  print -n '\e]0;'
  print -Pn $1
  print -n '\a'
}

# Show current command in title
prompt_geometry_set_cmd_title() {
  prompt_geometry_print_title "${2} @ %m"
}

# Prevent command showing on title after ending
prompt_geometry_set_title() {
  prompt_geometry_print_title '%~'
}

prompt_geometry_render() {
  PROMPT="
%(?.$PROMPT_SYMBOL.$EXIT_VALUE_SYMBOL) %{$fg[yellow]%}%3~%{$reset_color%} "

  PROMPT2=" $RPROMPT_SYMBOL "
  RPROMPT="$(prompt_geometry_git_info)"
}

prompt_geometry_setup() {
  autoload -U add-zsh-hook

  add-zsh-hook preexec prompt_geometry_set_cmd_title
  add-zsh-hook precmd prompt_geometry_set_title
  add-zsh-hook precmd prompt_geometry_render
}

prompt_geometry_setup
