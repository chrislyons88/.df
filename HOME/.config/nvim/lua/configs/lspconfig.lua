require("nvchad.configs.lspconfig").defaults()
-- https://github.com/mason-org/mason-lspconfig.nvim/tree/main/lua/mason-lspconfig/lsp

local function is_termux()
  return os.getenv "PREFIX" ~= nil and string.find(os.getenv "PREFIX", "/data/data/") ~= nil
end

local function is_macos()
  return vim.loop.os_uname().sysname == "Darwin"
end

local servers = {
  -- vim/lua
  "lua_ls",
  "stylua",

  -- frontend web
  -- "html",
  -- "cssls",
  -- "vuels",
  "eslint",
  "biome",
  "astro-language-server",
  "tailwindcss",
  "vtsls",
  "svelte",

  -- python
  "basedpyright",

  -- rust
  "rust_analyzer",

  -- other
  "bashls",
}

vim.diagnostic.config {
  virtual_text = false, -- 🔥 REQUIRED
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
