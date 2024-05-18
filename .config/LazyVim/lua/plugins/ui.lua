return {
  -- Noice NOTE: DISABLED
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = false,
        view = "cmdline", -- or cmdline_popup
        format = {
          cmdline = { icon = "" },
        },
      },
      messages = {
        enabled = false, -- to disable cmdline this has to be disabled as well (see docs)
      },
      presets = {
        lsp_doc_border = true,
      },
      views = {
        mini = {
          position = {
            row = -2,
          },
        },
      },
    },
  },
  -- bufferline NOTE: DISABLED
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        modified_icon = "[+]",
        diagnostics = false,
      },
    },
  },
  -- alpha-nvim TODO: replace with dashboard config
  {
    "goolord/alpha-nvim",
    optional = true,
    opts = function(_, dashboard)
      local button = dashboard.button("d", " " .. " Diffview", ":DiffviewOpen<CR>")
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      table.insert(dashboard.section.buttons.val, 4, button)
    end,
  },
  -- Diffview
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
    },
    opts = {
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
    },
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    config = true,
    opts = {
      signs = false,
    },
  -- stylua: ignore
    keys = {
      { "<leader>sT", false},
      { "<leader>st", false},
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTelescope theme=ivy<cr>", desc = "Todo comments" },
      { "<leader>xT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME theme=ivy<cr>", desc = "Todo/Fix/Fixme comments" },
    },
  },
  -- TODO: add lualine
}
