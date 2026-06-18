local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    svelte = { "prettierd" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2500,
    lsp_fallback = true,
  },
}

return options
