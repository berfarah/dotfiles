alias ga='git add'
alias gaa='git add --all'
alias gaip='git add -ip'
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcane="git commit --amend --no-edit"
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gds="git diff --staged"
alias gl='git pull'
alias gp='git push'
alias gpc="git push origin HEAD"
alias gpcu="git push --set-upstream origin HEAD"
alias gpf="git push --force-with-lease"
alias gpr="git pull-request --push --browse"
alias gs='git sync'
alias gst='git status'
alias gsta='git stash save'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'

__git_wip_branch() {
  branch="${1:-`git rev-parse --abbrev-ref HEAD`}"
  git branch -m $branch "wip/$branch"
}

__git_unwip_branch() {
  branch="${1:-`git rev-parse --abbrev-ref HEAD`}"
  git branch -m $branch "${branch#wip/}"
}

alias gbwip='__git_wip_branch'
compdef _git __git_wip_branch=git-branch
alias gbunwip='__git_unwip_branch'
compdef _git __git_unwip_branch=git-branch
