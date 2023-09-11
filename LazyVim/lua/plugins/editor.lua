return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      default_component_configs = {
        indent = {
          with_markers = false,
        },
        modified = {
          symbol = "",
        },

        git_status = {
          symbols = {
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
          },
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(_)
            -- auto close
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      window = {
        border = { "", "▁", "", "", "", " ", "", "" },
      },
    },
  },
}
