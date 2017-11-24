let mapleader = "\<Space>"

" ============================================================================
"   Plugins
" ============================================================================
source ~/.config/nvim/plug.vim

" NERDTree (sidebar)
" ----------------------------------------------------------------------------
" options
let NERDTreeShowHidden=1

" mappings
map <Leader>n :NERDTreeToggle<CR>
map <Leader>\ :NERDTree<CR><c-w>l:NERDTreeFind<CR>

" FZF (fuzzy finder)
" ----------------------------------------------------------------------------
" options
let g:fzf_buffers_jump = 1
let g:fzf_action =
\ { 'enter': 'tab drop',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Conditional'],
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

" mappings
nnoremap <C-p> :FZF<CR>
nnoremap <C-f> :Ag<Space>
nnoremap <Leader>b :Buffers<CR>
nnoremap gst :GFiles?<CR>

" Search through vim maps
nmap <Leader><Tab> <plug>(fzf-maps-n)
xmap <Leader><Tab> <plug>(fzf-maps-x)
omap <Leader><Tab> <plug>(fzf-maps-o)

" Ale (linter)
" ----------------------------------------------------------------------------
let g:ale_sign_column_always = 1
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_fix_on_save = 0
let g:ale_fixers = {}

" Deoplete (autocomplete)
" ----------------------------------------------------------------------------
" options
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#syntax#min_keyword_length = 3
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#tag#cache_limit_size = 500000000
let g:deoplete#max_list = 30

" mappings
inoremap <expr><C-g> deoplete#mappings#undo_completion()
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"

" UltiSnips (snippets)
" ----------------------------------------------------------------------------
" mappings
let g:UltiSnipsExpandTrigger="<nop>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:ulti_expand_or_jump_res = 0

" use enter to expand snippet suggestions
function ExpandSnippetOrCarriageReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

" Airline (status bar)
" ----------------------------------------------------------------------------
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline_powerline_fonts=0
let g:airline#extension#ale#enabled = 1

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

if exists("&termguicolors")
  set termguicolors
endif

set background=dark
colorscheme material-theme
let g:airline_theme = 'base16_flat' " Airline

" ============================================================================
"   Settings
" ============================================================================
set clipboard=unnamed                    " Clipboard support
set title                                " Show the filename in the window titlebar.
set timeoutlen=1000 ttimeoutlen=0        " Remove the delay when escaping from insert-mode
set mouse=a                              " Enable mouse support
set number
set numberwidth=5
set laststatus=2
set ruler
set wildmenu
set autoread
set history=1000
set tabpagemax=50
set backspace=indent,eol,start
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
set ignorecase                           " Case insensitive matching
set smartcase                            " Unless we use a capital letter anywhere
if exists("&inccommand")
  set inccommand=nosplit
endif

" Make it obvious where 80 characters is
set textwidth=100
set colorcolumn=+1
set lazyredraw

" Undo / Backup / Swap file locations
" ----------------------------------------------------------------------------
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

" Search highlighting
" ----------------------------------------------------------------------------
set incsearch " Highlight while searching
set hlsearch  " Highlight after entering search

" Window splitting behaviour
" ----------------------------------------------------------------------------
set splitbelow
set splitright

" For conceal markers.
" ----------------------------------------------------------------------------
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

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


" ============================================================================
"   Key Bindings
" ============================================================================
set list listchars=trail:.,extends:>

map <F2> :call TrimWhiteSpace()<CR>
map! <F2> :call TrimWhiteSpace()<CR>

" Make Y consistent with D
nnoremap Y y$

" Nobody ever uses "Ex" mode, and it's annoying to leave
noremap Q <nop>

" stupid window what are you for even
map q: :q<CR>

" Reselect visual block after indent/outdent: http://vimbits.com/bits/20
" ----------------------------------------------------------------------------
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Repurpose arrow keys to navigating windows
" ----------------------------------------------------------------------------
nnoremap <left> <C-w>h
nnoremap <right> <C-w>l
nnoremap <up> <C-w>k
nnoremap <down> <C-w>j

command Gcane :!git commit --amend --no-edit %
command Gadd :!git add %

set scroll=15

" Leader mappings
" ----------------------------------------------------------------------------

" Paste using automatic indentation
map <Leader>p :set paste<CR><esc>"*]p:set nopaste<cr>

" Get full path of buffer
map <Leader>cff :let @* = expand("%:p")<CR>
map <Leader>cf :let @* = expand("%")<CR>

" Get full directory of buffer
map <Leader>cdd :let @* = expand("%:p:h")<CR>
map <Leader>cd :let @* = expand("%:h")<CR>

" Remove highlight
map <Leader>h :noh<CR>

" Syntax highlighting for jbuilder
au BufNewFile,BufRead *.json.jbuilder set ft=ruby
