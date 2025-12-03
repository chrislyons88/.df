require "nvchad.mappings"
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/mappings.lua
-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Remap horizontal terminal to Ctrl+h
map({ "n", "t" }, "<C-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

-- TODO: put some of these with their plugin configs
-- code actions
vim.keymap.set({ "n", "x" }, "<leader>ca", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

-- telescope keymaps
vim.keymap.set("n", "<leader>km", "<cmd>Telescope keymaps<CR>", { desc = "Show keymaps" })

-- load session
vim.keymap.set("n", "<leader>ss", "<cmd>source Session.vim<CR>", { desc = "Source Session.vim" })

-- preview diff hunk inline
vim.keymap.set("n", "<leader>ph", function()
  require("gitsigns").preview_hunk_inline()
end, { desc = "Preview hunk inline" })

-- ignore lint rule
vim.keymap.set("n", "<leader>ir", "<cmd>Rulebook ignoreRule<CR>", { desc = "Ignore Lint rule" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
