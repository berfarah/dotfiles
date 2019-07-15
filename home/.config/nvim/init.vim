let mapleader = "\<Space>"

"   Plugins
" ----------------------------------------------------------------------------
" Install vim-plug if we don't already have it
if empty(glob("~/.config/nvim/autoload/plug.vim"))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')

" Fancy statusline
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Tooling
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'google/vim-searchindex'
Plug 'tpope/vim-commentary' | Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'eugen0329/vim-esearch'

" Colorscheme
Plug 'kristijanhusak/vim-hybrid-material'

" Testing
Plug 'janko-m/vim-test'

Plug 'vim-scripts/AnsiEsc.vim'
Plug 'Quramy/vison', { 'for': 'json', 'do': ':VisonSetup' }

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'darfink/vim-plist'
Plug 'rstacruz/sparkup', { 'for': ['html', 'css', 'eruby'] }
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'jodosha/vim-godebug', { 'for': 'go' }

" Linting
Plug 'w0rp/ale'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocInstall coc-json coc-snippets coc-tsserver coc-emoji coc-syntax coc-css coc-emmet'}

Plug 'honza/vim-snippets' | Plug 'SirVer/ultisnips'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

filetype plugin indent on                   " required!
call plug#end()


" NERDTree (sidebar)
" ----------------------------------------------------------------------------
" options
let NERDTreeShowHidden=1

" mappings
map <Leader>n :NERDTreeToggle<CR>
map <Leader>\ :NERDTree<CR><c-w>l:NERDTreeFind<CR>

set foldmethod=syntax
set foldlevelstart=99

" Tag generation
let g:gutentags_file_list_command = 'rg --files'

" FZF (fuzzy finder)
" ----------------------------------------------------------------------------
" options
let g:fzf_buffers_jump = 1
let g:fzf_action =
\ { 'enter': 'tab drop',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'CursorLine'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Hide statusline for fzf terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" mappings
nnoremap <C-p> :FZF<CR>
call esearch#map('<C-f>', 'esearch')
nnoremap <Leader>b :Buffers<CR>
nnoremap gst :GFiles?<CR>
if !exists('g:esearch') | let g:esearch = {} | endif
let g:esearch.backend = 'nvim'
let g:esearch.adapter = 'rg'
let g:esearch.regex = 1
let g:esearch.case = 1

" Ale (linter)
" ----------------------------------------------------------------------------
let g:ale_sign_column_always = 1
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_fix_on_save = 1
let g:ale_fixers = {}
let g:ale_lint_on_enter = 0

" Autocomplete mappings
" ----------------------------------------------------------------------------
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

let g:coc_snippet_next = '<tab>'
let g:coc_node_path = '/usr/local/bin/node'

" UltiSnips (snippets)
let g:UltiSnipsExpandTrigger="<nop>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:ulti_expand_or_jump_res = 0

" Airline (status bar)
" ----------------------------------------------------------------------------
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_powerline_fonts=0
let g:airline#extension#ale#enabled = 1
let g:airline_detect_paste=1
let g:airline#extensions#branch#enabled = 1

" Exit terminal with escape
if has("nvim")
  tnoremap <Leader><Esc> <C-\><C-n>
endif

" VimTest
" ----------------------------------------------------------------------------
" options
let test#strategy = "neovim"

" mappings
map <Leader>T :TestFile<CR>
map <Leader>t :TestNearest<CR>
map <Leader>l :TestLast<CR>

" ============================================================================
"   Theming
" ============================================================================
syntax on                                " Syntax on by default

if exists("&termguicolors")              " True colors
  set termguicolors
endif

set background=dark
let g:hybrid_transparent_background = 1
let g:enable_italic_font = 1
let g:enable_bold_font = 1
colorscheme hybrid_material
let g:airline_theme = 'hybrid' " Airline

" ============================================================================
"   Settings
" ============================================================================
set clipboard=unnamed                    " Clipboard support
set title                                " Show the filename in the window titlebar.
set timeoutlen=1000 ttimeoutlen=0        " Remove the delay when escaping from insert-mode
set mouse=a                              " Enable mouse support
set number                               " Show line numbers
set scroll=15                            " CTRL+D scroll amount
set numberwidth=5                        " Width of line numbers column
set wildmenu                             " VIM command completion
set autoread                             " Reload files that have been changed outside of VIM
set history=1000                         " Amount of saved VIM commands
set backspace=indent,eol,start           " Backspace behavior
set list listchars=tab:»·,trail:·,nbsp:·,extends:> " Display extra whitespace
set ignorecase                           " Case insensitive matching
set smartcase                            " Unless we use a capital letter anywhere
set textwidth=100                        " Wrap text after N chars
set colorcolumn=+1                       " Highlight column after text width
set lazyredraw                           " Don't update the screen during macros
set incsearch                            " Highlight while searching
set hlsearch                             " Highlight after entering search
set splitbelow                           " Horizontal split below
set splitright                           " Vertical split right
if exists("&inccommand")                 " Execute search/replace as you're typing
  set inccommand=nosplit
endif
if has('conceal')                        " Conceal markers...
  set conceallevel=2 concealcursor=niv
endif

" Undo / Backup / Swap file locations
" ----------------------------------------------------------------------------
set backupskip=/tmp/*,/private/tmp/*
set directory=$HOME/.config/nvim/swap//
set backupdir=$HOME/.config/nvim/backup//
if exists('+undodir')
  set undodir=$HOME/.config/nvim/undo
  set undofile
endif

" Indentation
" ----------------------------------------------------------------------------
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Trim whitespace (and keep cursor in place)
" ----------------------------------------------------------------------------
function TrimWhiteSpace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

" Trim whitespace when the file is written to or opened
autocmd FileWritePre * :call TrimWhiteSpace()
autocmd FileAppendPre * :call TrimWhiteSpace()
autocmd FilterWritePre * :call TrimWhiteSpace()
autocmd BufWritePre * :call TrimWhiteSpace()

" Syntax highlighting for jbuilder
autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby

" Reselect visual block after indent/outdent
" ----------------------------------------------------------------------------
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Key bindings
" ----------------------------------------------------------------------------

" Make Y consistent with D
nnoremap Y y$

" Nobody ever uses "Ex" mode, and it's annoying to leave
noremap Q <nop>

" Paste using automatic indentation
map <Leader>p :set paste<CR><esc>"*]p:set nopaste<cr>

" Get full path of buffer
map <Leader>cff :let @* = expand("%:p")<CR>
map <Leader>cf :let @* = expand("%")<CR>

" Get full directory of buffer
map <Leader>cdd :let @* = expand("%:p:h")<CR>
map <Leader>cd :let @* = expand("%:h")<CR>

nmap <silent> <Leader>aj <Plug>(ale_next_wrap)
nmap <silent> <Leader>ak <Plug>(ale_previous_wrap)

" Remove highlight
map <Leader>h :noh<CR>
