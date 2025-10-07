vim.keymap.set(
  'n',
  '<leader>f',
  function() require('conform').format({ lsp_fallback = true }) end,
  { desc = 'Format document' }
)
vim.keymap.set('n', '<leader>w', ':write<CR>', { desc = 'Writes current buffer' })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'Quit NVIM' })
vim.keymap.set('n', '<leader>sf', function()
  if vim.fn.system('git rev-parse --is-inside-work-tree 2>/dev/null'):match('true') then
    vim.cmd('Pick files tool="git"')
  else
    vim.cmd('Pick files')
  end
end, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sb', ':Pick buffers<CR>', { desc = 'Search Buffers' })
vim.keymap.set('n', '<leader>sg', function()
  if vim.fn.system('git rev-parse --is-inside-work-tree 2>/dev/null'):match('true') then
    vim.cmd('Pick grep_live tool="git"')
  else
    vim.cmd('Pick grep_live')
  end
end, { desc = 'Search Grep' })
vim.keymap.set('n', '<leader>r', ':Pick resume<CR>', { desc = 'Resume search' })
vim.keymap.set('n', '<leader>sd', ':Pick diagnostic scope="current"<CR>', { desc = 'Search Diagnostics in current buffer' })
vim.keymap.set('n', '<leader>sad', ':Pick diagnostic<CR>', { desc = 'Search All Diagnostics' })
vim.keymap.set('n', '<leader>n', ':Oil<CR>', { desc = 'Navigate folders' })

vim.keymap.set('n', '<Esc>', function()
  -- Close any floating windows
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then -- floating window
      vim.api.nvim_win_close(win, false)
    end
  end
end, { desc = 'Close floating windows' })
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { silent = true })
