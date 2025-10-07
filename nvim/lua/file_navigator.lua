  require("oil").setup({
    columns = {
    "icon",
    },
    keymaps = {
      ["ss"] = "actions.select_split",
      ["vv"] = "actions.select_vsplit",
    },
  })
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      if vim.fn.argc() == 0 then
        require("oil").open()
      end
    end,
  })

