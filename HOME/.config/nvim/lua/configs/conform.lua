local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    -- javascript = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
