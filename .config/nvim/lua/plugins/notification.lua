return {
  -- {
  --   "j-hui/fidget.nvim", -- show lsp progress
  --   config = function()
  --     local fidget = require("fidget")
  --     fidget.setup({
  --       notification = {
  --         override_vim_notify = true, -- Use Fidget for vim.notify()
  --         window = {
  --           winblend = 0,
  --           align = "top",
  --           y_padding = 2,
  --           -- border = "rounded",
  --           -- border_hl = "FidgetBorder",
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss All Notifications",
      },
    },
    opts = {
      stages = "static",
      timeout = 3000,
      background_colour = "#000000",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },
  {
    "mrded/nvim-lsp-notify",
    dependencies = { "rcarriga/nvim-notify" },
    config = function()
      require("lsp-notify").setup({
        notify = require("notify"),
      })
    end,
  },
}
