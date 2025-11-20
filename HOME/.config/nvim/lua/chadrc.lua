-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "gruvbox",
  transparency = true,

  hl_override = {
    -- override comments
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    -- override CursorLine color and differentiate Visual
    CursorLine = {
      bg = "one_bg",
    },
    Visual = {
      bg = "grey",
    },
  },
}

-- Show all attached LSP clients
M.ui = {
  statusline = {
    modules = {
      lsp = function()
        local clients = vim.lsp.get_clients { bufnr = 0 }
        if not clients or #clients == 0 then
          return ""
        end

        local names = {}
        for _, c in ipairs(clients) do
          table.insert(names, c.name)
        end

        return "%#St_Lsp# LSP ~ " .. table.concat(names, ", ") .. "  "
      end,
    },
  },
}
-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
