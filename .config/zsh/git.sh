# remember:
# gwip to commit wip
# gunwip to uncommit wip

alias gcane="git commit --amend --no-edit"
alias gpc="git push origin HEAD"
alias gpcu="git push --set-upstream origin HEAD"
alias gpf="git push --force-with-lease"
alias gds="git diff --staged"
alias gpr="git push --set-upstream origin HEAD && git pull-request"

nonmaster_branches () {
  CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
  BRANCHES_TO_EXCLUDE="master\|production\|$CURRENT_BRANCH"
  echo `git branch | grep -v $BRANCHES_TO_EXCLUDE` | tr " " "\n"
}
alias prune='nonmaster_branches | xargs -I {} git branch -d {}'

branches_merged_to_master () {
  CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
  BRANCHES_TO_EXCLUDE="master\|production\|$CURRENT_BRANCH"
  echo `git branch --merged master | grep -v $BRANCHES_TO_EXCLUDE` | tr " " "\n"
}
alias prune_master='branches_merged_to_master | xargs -n 1 git branch -d'

branches_merged_to_branch () {
  BRANCH="$1"

  if [ -z $BRANCH ]; then
    echo "Usage: prune_merged_to [branch]"
    exit 1
  fi

  CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
  BRANCHES_TO_EXCLUDE="master\|production\|$CURRENT_BRANCH"
  echo `git branch --merged origin/$BRANCH | grep -v $BRANCHES_TO_EXCLUDE` | tr " " "\n"
}
alias prune_merged_to='branches_merged_to_branch'
