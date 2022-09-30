vim.opt.clipboard = "unnamedplus"                    -- Clipboard support
vim.opt.title = true                               -- Show the filename in the window titlebar.
vim.opt.timeoutlen = 1000                 -- Remove the delay when escaping from insert-mode
vim.opt.ttimeoutlen = 0
vim.opt.mouse = "a"                              -- Enable mouse support
vim.opt.number = true                              -- Show line numbers
vim.opt.scroll = 15                            -- CTRL+D scroll amount
vim.opt.numberwidth = 5                        -- Width of line numbers column
vim.opt.wildmenu = true                            -- VIM command completion
vim.opt.autoread = true                            -- Reload files that have been changed outside of VIM
vim.opt.history = 1000                         -- Amount of saved VIM commands
vim.opt.backspace = "indent,eol,start"           -- Backspace behavior
vim.opt.list = true
vim.opt.listchars = "tab:»·,trail:·,nbsp:·,extends:>" -- Display extra whitespace
vim.opt.ignorecase = true                           -- Case insensitive matching
vim.opt.smartcase = true                           -- Unless we use a capital letter anywhere
vim.opt.textwidth = 100                        -- Wrap text after N chars
vim.opt.colorcolumn = "101"                       -- Highlight column after text width
vim.opt.lazyredraw = true                           -- Don't update the screen during macros
vim.opt.incsearch = true                           -- Highlight while searching
vim.opt.hlsearch = true                            -- Highlight after entering search
vim.opt.splitbelow = true                          -- Horizontal split below
vim.opt.splitright = true                          -- Vertical split right
vim.opt.inccommand = "nosplit"  -- Execute search/replace as you're typing
-- if has('conceal')                        " Conceal markers...
--   vim.opt.conceallevel = 2
--   vim.opt.concealcursor = "niv"
-- endif

vim.opt.foldmethod = "syntax"
vim.opt.foldlevelstart = 99

-- Undo / Backup / Swap file locations
-- ----------------------------------------------------------------------------
vim.opt.backupskip = "/tmp/*,/private/tmp/*"
vim.opt.directory = vim.fn.expand("$HOME/.config/nvim/swap//")
vim.opt.backupdir = vim.fn.expand("$HOME/.config/nvim/backup//")
vim.opt.undodir = vim.fn.expand("$HOME/.config/nvim/undo")
vim.opt.undofile = true

-- Indentation
-- ----------------------------------------------------------------------------
vim.cmd("filetype plugin indent on")
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Trim whitespace (and keep cursor in place)
-- ----------------------------------------------------------------------------
vim.cmd([[
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
]])
