require("nvchad.configs.lspconfig").defaults()
-- https://github.com/mason-org/mason-lspconfig.nvim/tree/main/lua/mason-lspconfig/lsp
local servers = {
  -- vim/lua
  "lua_ls",
  "stylua",

  -- frontend web
  -- "html",
  -- "cssls",
  -- "vuels",
  -- "svelte",
  -- "astro-language-server",
  "tailwindcss",
  "vtsls",
  -- "eslint",

  -- python
  "basedpyright",

  -- rust
  "rust_analyzer",

  -- other
  "bashls",
}

vim.diagnostic.config({
  virtual_text = false, -- 🔥 REQUIRED
})

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
