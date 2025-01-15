function d() { cd ~/dev/$1; }
function _dev_compl() { _files -/ -W ~/dev; }
compdef _dev_compl d

_list_repos() {
  rg --no-ignore --hidden --iglob "*.git/config" --files |
    grep -v "golang\|plugged" |
    sed -e 's/\/.git\/config$//'
}
