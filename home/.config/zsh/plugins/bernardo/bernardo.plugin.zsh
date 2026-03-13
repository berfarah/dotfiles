PLUGIN="${0:h}"

source "$PLUGIN/macos.zsh"
source "$PLUGIN/alias.zsh"
source "$PLUGIN/projects.zsh"
source "$PLUGIN/git.zsh"
source "$PLUGIN/fzf.zsh"
source "$PLUGIN/vim.zsh"

dump_pids() {
  name="$HOME/.psdump-`date -u +"%Y-%m-%dT%TZ"`"
  pstree > "$name"
  echo "Dumped pids to $name"
}
