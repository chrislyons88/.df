-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
require("lint").linters_by_ft = {
  python = { "ruff" },
  -- css = { "eslint_d" },
  -- html = { "eslint_d" },
  -- javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  -- vue = { "eslint_d" },
}

-- Auto-run linter on save
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
