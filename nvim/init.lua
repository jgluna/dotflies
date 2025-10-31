vim.opt.cmdheight = 0
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.backspace = "indent,eol,start"
vim.opt.winborder = "rounded"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.completeopt = { "menuone", "noselect", "popup", "preview" }
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.lsp.log.set_level(vim.log.levels.WARN)
vim.o.termguicolors = true
vim.o.scrolloff = 10

-- Underline cursor in normal/visual/command modes, vertical line in insert mode
-- vim.opt.guicursor = "n-v-c-sm:hor20,i-ci-ve:ver25,r-cr-o:hor20"

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- New way to get log path
    local log_path = vim.fs.joinpath(vim.fn.stdpath("log"), "lsp.log")
    local stat = vim.loop.fs_stat(log_path)
    if stat and stat.size > 10 * 1024 * 1024 then -- If log > 10MB
      vim.fn.writefile({}, log_path)
      print("Cleared large LSP log (" .. math.floor(stat.size / 1024 / 1024) .. "MB)")
    end
  end,
})


vim.pack.add({
  { src = "https://github.com/catppuccin/nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
  { src = "https://github.com/nvim-mini/mini.extra" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" }
})

require 'nvim-web-devicons'.setup()
require("catppuccin").setup({
  transparent_background = true
})
vim.cmd.colorscheme "catppuccin"
require('mini.pick').setup()
require('mini.extra').setup()
require('nvim-autopairs').setup()
require("file_navigator")
require("lsp")
require("formatting")
require("keymaps")
require("status_line")
require('render-markdown').setup()

require 'nvim-treesitter.configs'.setup {
  modules = {},
  ensure_installed = {
    "lua", "vim", "vimdoc", "query",
    "python", "javascript", "typescript",
    "go", "sql", "json", "html", "css"
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}
