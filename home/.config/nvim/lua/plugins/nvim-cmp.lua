-- Set max height of suggestion window
vim.opt.pumheight = 15

local cmp = require('cmp')

local select_opts = {behavior = cmp.SelectBehavior.Select}

if not cmp then return end

local luasnip = require('luasnip')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    keyword_length = 2,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

  },
  sources = {
    { name = 'nvim_lsp'},
    { name = 'buffer' },
    { name = 'luasnip', max_item_count = 5 },
    { name = 'path' },
  }
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
