vim.lsp.enable({
  "basedpyright",
  "cssls",
  "emmet-ls",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "ts_ls",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,      vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
    vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,     vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
    vim.keymap.set('n', 'gr',         vim.lsp.buf.references,      vim.tbl_extend('force', opts, { desc = 'References' }))
    vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation,  vim.tbl_extend('force', opts, { desc = 'Go to implementation' }))
    vim.keymap.set('n', 'K',          vim.lsp.buf.hover,           vim.tbl_extend('force', opts, { desc = 'Hover docs' }))
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,          vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,     vim.tbl_extend('force', opts, { desc = 'Code action' }))
    vim.keymap.set('n', '<leader>e',  vim.diagnostic.open_float,   vim.tbl_extend('force', opts, { desc = 'Open diagnostic float' }))
    vim.keymap.set('n', ']d',         function() vim.diagnostic.jump({ count = 1 }) end,  vim.tbl_extend('force', opts, { desc = 'Next diagnostic' }))
    vim.keymap.set('n', '[d',         function() vim.diagnostic.jump({ count = -1 }) end, vim.tbl_extend('force', opts, { desc = 'Prev diagnostic' }))
  end,
})

