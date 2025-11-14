require "nvchad.autocmds"

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch", -- The highlight group to use (e.g., IncSearch, Visual, or a custom one)
      timeout = 300, -- How long the highlight should last in milliseconds
    }
  end,
  desc = "Briefly highlight yanked text",
})
