require "nvchad.mappings"
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/mappings.lua
-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Remap horizontal terminal to Ctrl+`
map({ "n", "t" }, "<C-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
