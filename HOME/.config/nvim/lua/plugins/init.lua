return {
  -- ===================================
  -- Loading Syntax highlghter, LSP, Lint & Formatting options
  -- for supported languages in the ./configs directory
  -- ===================================

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require "configs.treesitter"
    end,
  },

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
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- ===================================
  -- Additional plugins
  -- ===================================

  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      -- `opts` contains NvChad's existing gitsigns config
      -- opts.signs = vim.tbl_extend("force", opts.signs or {}, {
      -- })

      -- Add a new option or change an existing one
      -- opts.numhl = true
      opts.word_diff = true -- Toggle with `:Gitsigns toggle_word_diff`
      opts.current_line_blame = true -- Toggle with `:Gitsigns toggle_current_line_blame`
      opts.current_line_blame_opts = {
        virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
        delay = 666,
      }

      return opts
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- https://github.com/numToStr/Comment.nvim?tab=readme-ov-file#-usage
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
  },

  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },

      -- optional picker via telescope
      { "nvim-telescope/telescope.nvim" },
      -- optional picker via fzf-lua
      { "ibhagwan/fzf-lua" },
      -- .. or via snacks
      {
        "folke/snacks.nvim",
        opts = {
          terminal = {},
        },
      },
    },
    event = "LspAttach",
    opts = {},
  },

  -- Code minimap on right side
  {
    "gorbit99/codewindow.nvim",
    event = "VeryLazy",
    config = function()
      local codewindow = require "codewindow"
      codewindow.setup {
        -- active_in_terminals = false, -- Should the minimap activate for terminal buffers
        -- auto_enable = false, -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
        -- exclude_filetypes = { "help" }, -- Choose certain filetypes to not show minimap on
        -- max_minimap_height = nil, -- The maximum height the minimap can take (including borders)
        -- max_lines = nil, -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
        minimap_width = 12, -- The width of the text part of the minimap
        -- use_lsp = true, -- Use the builtin LSP to show errors and warnings
        -- use_treesitter = true, -- Use nvim-treesitter to highlight the code
        -- use_git = true, -- Show small dots to indicate git additions and deletions
        width_multiplier = 3, -- How many characters one dot represents
        -- z_index = 1, -- The z-index the floating window will be on
        -- show_cursor = true, -- Show the cursor position in the minimap
        screen_bounds = "background", -- How the visible area is displayed, "lines": lines above and below, "background": background color
        window_border = "none", -- The border style of the floating window (accepts all usual options)
        -- relative = "win", -- What will be the minimap be placed relative to, "win": the current window, "editor": the entire editor
        -- events = { "TextChanged", "InsertLeave", "DiagnosticChanged", "FileWritePost" }, -- Events that update the code window
      }
      codewindow.apply_default_keybinds()
    end,
  },

  -- https://github.com/jbyuki/venn.nvim?tab=readme-ov-file#usage
  {
    "jbyuki/venn.nvim",
    event = "VeryLazy",
  },

  -- https://github.com/kylechui/nvim-surround?tab=readme-ov-file#rocket-usage
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
  },

  {
    "bngarren/checkmate.nvim",
    ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
    opts = {
      -- files = { "*.md" }, -- any .md file (instead of defaults)
    },
  },

  -- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-move.md#default-config
  { "nvim-mini/mini.move", event = "VeryLazy", version = false, opts = {} },

  -- highlight selected word
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure {
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 200,
        filetypes_denylist = { "NvimTree", "lazy", "alpha" },
      }
    end,
  },

  { "chrisgrieser/nvim-rulebook", event = "VeryLazy" },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup {
        options = {
          multilines = {
            enabled = true,
          },
          show_source = {
            enabled = true,
          },
        },
      }
    end,
  },

  -- make icon colors match colorscheme
  -- {
  --   "rachartier/tiny-devicons-auto-colors.nvim",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   event = "VeryLazy",
  --   config = function()
  --     require("tiny-devicons-auto-colors").setup()
  --   end,
  -- },

  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    version = "*", -- use the latest stable version
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>yh",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>y",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<leader>-",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- mark netrw as loaded so it's not loaded at all.
      --
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 1
    end,
  },

  -- ===================================
  -- Folke plugins
  -- ===================================

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    -- https://github.com/folke/snacks.nvim/tree/main?tab=readme-ov-file#-usage
    opts = {
      animate = { enabled = true },
      bigfile = { enabled = true },
      -- bufdelete = { enabled = true },
      -- dashboard = { enabled = true },
      -- debug = { enabled = true },
      dim = { enabled = true },
      -- explorer = { enabled = true },
      -- gh = { enabled = true },
      -- git = { enabled = true },
      -- gitbrowse = { enabled = true },
      -- image = { enabled = true },
      indent = { enabled = true },
      -- input = { enabled = true },
      -- keymap = { enabled = true },
      -- layout = { enabled = true },
      -- lazygit = { enabled = true },
      -- notifier = { enabled = true },
      -- notify = { enabled = true },
      picker = { enabled = true },
      -- profiler = { enabled = true },
      quickfile = { enabled = true },
      -- rename = { enabled = true },
      -- scope = { enabled = true },
      scratch = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      -- terminal = { enabled = true },
      -- toggle = { enabled = true },
      -- util = { enabled = true },
      -- win = { enabled = true },
      -- words = { enabled = true },
      zen = { enabled = true },
    },
    keys = {

      -- zen mode
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },

      -- floating todo
      {
        "<leader>T.",
        function()
          require("lazy").load { plugins = { "checkmate.nvim" } }

          vim.schedule(function()
            local root = vim.fn.getcwd() -- project root
            local file = root .. "/todo.md" -- use existing todo.md in project

            -- create file if needed
            if vim.fn.filereadable(file) == 0 then
              vim.fn.writefile({}, file)
            end

            Snacks.scratch.open {
              ft = "markdown",
              file = file, -- now points to project todo
            }
          end)
        end,
        desc = "Toggle Project Todo",
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" },
        },
      },
    },
    keys = {
      { "<leader>dd", "<cmd>Noice dismiss<CR>", desc = "Dismiss Noice popups" },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000", -- enables using transparency without error warnings
    },
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>td",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tD",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>ts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>tl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>tL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>tq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      -- {
      --   "r",
      --   mode = "o",
      --   function()
      --     require("flash").remote()
      --   end,
      --   desc = "Remote Flash",
      -- },
      -- {
      --   "R",
      --   mode = { "o", "x" },
      --   function()
      --     require("flash").treesitter_search()
      --   end,
      --   desc = "Treesitter Search",
      -- },
      -- {
      --   "<c-s>",
      --   mode = { "c" },
      --   function()
      --     require("flash").toggle()
      --   end,
      --   desc = "Toggle Flash Search",
      -- },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local base46 = require "base46"
      local colors = base46.get_theme_tb "base_30"
      return {
        colors = {
          error = { colors.red, "DiagnosticError", "ErrorMsg" },
          warning = { colors.yellow, "DiagnosticWarn", "WarningMsg" },
          info = { colors.nord_blue, "DiagnosticInfo" },
          hint = { colors.vibrant_green, "DiagnosticHint" },
          default = { colors.dark_purple, "Identifier" },
          test = { colors.fg, "Identifier" }, -- example
        },
        -- // TODO: = { icon = " ", color = "info" },
        -- // HACK: = { icon = " ", color = "warning" },
        -- // WARN: = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        -- // PERF: = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        -- // NOTE: = { icon = " ", color = "hint", alt = { "INFO" } },
        -- // TEST: = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        -- // WARNING: = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        -- // FIX: = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      }
    end,
  },

  -- ===================================
  -- AI things
  -- ===================================

  -- codecompanion ai
  -- https://codecompanion.olimorris.dev/
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- event = "VeryLazy", -- Load after startup
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    opts = {
      strategies = {
        -- Local model (Ollama)
        chat = {
          adapter = "ollama",
          -- model = "codellama:7b-instruct",
          model = "deepseek-coder-v2:16b",
        },
      },
    },
    keys = {
      {
        "<C-a>",
        "<cmd>CodeCompanionActions<CR>",
        desc = "Open the action palette",
        mode = { "n", "v" },
      },
      {
        "<Leader>a",
        "<cmd>CodeCompanionChat Toggle<CR>",
        desc = "Toggle a chat buffer",
        mode = { "n", "v" },
      },
      {
        "<LocalLeader>a",
        "<cmd>CodeCompanionChat Add<CR>",
        desc = "Add code to a chat buffer",
        mode = { "v" },
      },
    },
  },
  -- For rendering MD buffer
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    opts = {
      bullet = { enabled = false }, -- ← removes the unwanted bullet in Checkmate
      -- checkbox = {
      --   enabled = true,
      --   unchecked = "",
      --   checked = "",
      -- },
    },
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },
}
