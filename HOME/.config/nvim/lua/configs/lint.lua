-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
require("lint").linters_by_ft = {
  python = { "ruff" },
  css = { "biome" },
  html = { "biome" },
  javascript = { "biome" },
  typescript = { "biome" },
  typescriptreact = { "biome" },
  -- vue = { "eslint_d" },
}

-- Auto-run linter on save
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
