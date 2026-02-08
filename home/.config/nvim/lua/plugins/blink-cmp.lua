-- Set max height of suggestion window
vim.opt.pumheight = 15

require('blink.cmp').setup({
  completion = {
    keyword = { range = 'prefix' },
    list = {
      selection = { preselect = true, auto_insert = false },
    },
    documentation = { auto_show = true },
  },

  signature = { enabled = true },

  sources = {
    default = { 'lsp', 'buffer', 'path', 'snippets' },
  },

  keymap = {
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<C-Space>'] = { 'show' },
    ['<C-e>'] = { 'hide' },
    ['<C-d>'] = { 'scroll_documentation_down' },
    ['<C-f>'] = { 'scroll_documentation_up' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-n>'] = { 'select_next', 'fallback' },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    -- Displays hover information about the symbol under the cursor
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    -- Jump to the definition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    -- Jump to declaration
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    -- Lists all the implementations for the symbol under the cursor
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    -- Jumps to the definition of the type symbol
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)

    -- Lists all the references
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    -- Displays a function's signature information
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- Renames all references to the symbol under the cursor
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)

    -- Selects a code action available at the current cursor position
    vim.keymap.set({'n', 'x'}, '<F4>', vim.lsp.buf.code_action, opts)

    -- Show diagnostics in a floating window
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)

    -- Move to the previous diagnostic
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({count = -1}) end, opts)

    -- Move to the next diagnostic
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({count = 1}) end, opts)
  end
})
