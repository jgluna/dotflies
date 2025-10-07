require('conform').setup({
  log_level = vim.log.levels.DEBUG,
  formatters_by_ft = {
    python = { "black" }, -- or "autopep8", "ruff_format"
    sql = function(bufnr)
      local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
      local filepath = vim.api.nvim_buf_get_name(bufnr)
      -- Use sqlfmt for dbt model files
      if filepath:match("/models/") or filepath:match("/macros/") then
        return { "sqlfmt" }
      end
      if content:match("::") or filepath:match("postgres") or filepath:match("pg_") then
        return { "sql_formatter_postgres" }
      end
      if content:match("VARCHAR2") or content:match("NUMBER") or filepath:match("oracle") then
        return { "sql_formatter_oracle" }
      end
      return { "sql_formatter_plain" } -- or sql_formatter_oracle
    end,
    -- sql = { "sql_formatter" },   -- or "sqlfluff"
    -- Keep LSP formatting for these:
    json = { lsp_format = "fallback" },
    lua = { lsp_format = "fallback" },
    go = { lsp_format = "fallback" },
    typescript = { lsp_format = "fallback" },
    javascript = { lsp_format = "fallback" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
  },
  formatters = {
    black={
      timeout_ms = 10000,
    },
    sqlfmt = {
      timeout_ms = 10000,
    },
    sql_formatter_plain = {
      command = "sql-formatter",
      args = { "--language", "sql" },
      stdin = true,
    },
    sql_formatter_postgres = {
      command = "sql-formatter",
      args = { "--language", "postgresql" },
      stdin = true,
    },
    sql_formatter_oracle = {
      command = "sql-formatter",
      args = { "--language", "plsql" },
      stdin = true,
    },
  },
})
