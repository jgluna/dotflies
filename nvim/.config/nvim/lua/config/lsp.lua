vim.lsp.enable({
  "cssls",   -- npm i -g vscode-langservers-extracted
  "gopls",
  "html",
  "jsonls",
  "basedpyright",   -- npm i -g basedpyright
  "ts_ls",
  "lua_ls",
  "emmet-ls"
})
vim.lsp.config("lua_ls",
  {
    settings = {
      Lua = {
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        }
      }
    }
  })

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "basic",
        autoSearchPaths = false,
        useLibraryCodeForTypes = false,
      }
    }
  }
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "stuff" })

    local methods = vim.lsp.protocol.Methods
    if client:supports_method(methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

