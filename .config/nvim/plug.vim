" ----------------------------------------------------------------------------
"   Plug
" ----------------------------------------------------------------------------

" Install vim-plug if we don't already have it
if empty(glob("~/.config/nvim/autoload/plug.vim"))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')

" Fancy statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Vim sessions based on git branch/repo
Plug 'berfarah/gitsessions.vim'

" Colorschemes
Plug 'chriskempson/base16-vim'
Plug 'jdkanani/vim-material-theme'
Plug 'rakr/vim-one'
Plug 'raphamorim/lucario'

" Testing
Plug 'janko-m/vim-test'

" Rename files from within vim
Plug 'tpope/vim-eunuch'

" Split navigation that works with tmux
Plug 'christoomey/vim-tmux-navigator'

" Syntax
Plug 'tpope/vim-git', { 'for': 'git' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'rstacruz/sparkup', { 'for': ['html', 'css'] }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'darfink/vim-plist'
Plug 'kchmck/vim-coffee-script'

" Javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'alexbyk/vim-ultisnips-js-testing'

" Ruby
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'janko-m/vim-test', { 'for': 'ruby' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-rake', { 'for': 'ruby' }
Plug 'jgdavey/vim-blockle', { 'for': 'ruby' }

" Alignment in VIM
Plug 'junegunn/vim-easy-align'

" Syntastic: Code linting errors
" Plug 'scrooloose/syntastic', { 'for': ['ruby', 'go', 'javascript', 'css'] }
Plug 'neomake/neomake'

" Searching
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" Line matching via %
Plug 'matchit.zip'

" Better autocomplete
Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Sidebar + git status + persistence
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Fugitive: Git from within Vim
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Split and join lines of code intelligently
Plug 'AndrewRadev/splitjoin.vim'

" Make commenting easier
Plug 'tpope/vim-commentary'

" Sensible VIM!
Plug 'tpope/vim-surround'

" :e a/b/c/d.txt with mkdir -p
Plug 'pbrisbin/vim-mkdir'


" Other plugins require curl
if executable("curl")
    " Gist: Post text to gist.github
    Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
endif

filetype plugin indent on                   " required!
call plug#end()

