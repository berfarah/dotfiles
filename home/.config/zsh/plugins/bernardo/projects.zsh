function _dev() {
  cd ~/dev/$1
}
compctl -/ -W ~/dev _dev
alias d="_dev"

_list_repos() {
  rg --no-ignore --hidden --iglob "*.git/config" --files |
    grep -v "golang\|plugged" |
    sed -e 's/\/.git\/config$//'
}
