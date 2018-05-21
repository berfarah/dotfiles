alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias resource='source ~/.zshrc'
alias dev="$PROJECTS_PATH"
alias l="ls -lahp"
alias git=hub
function knoch-cd() {
  cd $(knoch show "$@")
}
function _knoch-cd() {
  projects=($(knoch ls --name-only))
  if [ $#projects -eq 0 ]; then
    _message "No projects found"
    return
  fi
  _values "projects" $projects
}
compdef _knoch-cd knoch-cd
