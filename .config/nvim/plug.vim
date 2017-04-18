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

" Tooling
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'brooth/far.vim', { 'do': ':UpdateRemotePlugins' }
Plug 'c0r73x/neotags.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'google/vim-searchindex'
Plug 'junegunn/vim-easy-align'
Plug 'pbrisbin/vim-mkdir'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'

" Colorschemes
Plug 'jdkanani/vim-material-theme'
Plug 'mhartington/oceanic-next'
Plug 'rakr/vim-one'

" Testing
Plug 'janko-m/vim-test'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'darfink/vim-plist'
Plug 'rstacruz/sparkup', { 'for': ['html', 'css', 'eruby'] }
Plug 'tpope/vim-rails'

" Linting
Plug 'w0rp/ale'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" Sidebar + git status + persistence
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'

filetype plugin indent on                   " required!
call plug#end()
