return {
  -- Noice
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
  -- bufferline currently disable
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
  -- alpha-nvim
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
    event = "VeryLazy",
    opts = {
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
    },
  },
  -- TODO add lualine
}
