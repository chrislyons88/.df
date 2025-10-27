return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "mfussenegger/nvim-lint",
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lint"
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- vim/lua
        "vim",
        "lua",
        "vimdoc",
        -- frontend web
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "json",
        "graphql",
        "vue",
        "svelte",
        "tsx",
        -- general purpose
        "markdown",
        "markdown_inline",
        "mermaid",
        "toml",
        "yaml",
        "xml",
        "csv",
        "dockerfile",
        "terraform",
        "tmux",
        "ssh_config",
        "regex",
        -- backend and shell
        "bash",
        "python",
        "rust",
        "sql",
      },
      auto_install = true, -- Enable automatic installation of missing parsers
    },

}
