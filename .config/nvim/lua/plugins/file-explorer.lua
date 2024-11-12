return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
    end,
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        filesystem = {
          follow_current_file = { enabled = true },
        },
        enable_git_status = false,
        enable_diagnostics = false,
        default_component_configs = {
          indent = {
            with_markers = false,
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          modified = {
            symbol = "󰐗",
          },
          git_status = {
            symbols = {
              modified = "",
              untracked = "󰡯",
              ignored = "󱞃",
              unstaged = "󰄰",
              staged = "󰄴",
              conflict = "",
            },
          },
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function(_)
              require("neo-tree.command").execute({ action = "close" }) -- auto close
            end,
          },
        },
      })

      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "explorer (toggle)" })
      vim.keymap.set("n", "<leader>ge", "<cmd>Neotree git_status toggle<CR>", { desc = "status explorer" })
    end,
  },
}
