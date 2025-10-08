return {
  { "tpope/vim-projectionist" }, -- TODO: checkout https://github.com/rgroli/other.nvim instead of vim-projectionist
  { "tpope/vim-sleuth" },
  { "folke/ts-comments.nvim", event = "VeryLazy", opts = {} },
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      scope = { enabled = true, show_start = false },
    },
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
      }
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "helix",
        spec = {
          { "<leader>1", hidden = true },
          { "<leader>2", hidden = true },
          { "<leader>3", hidden = true },
          { "<leader>4", hidden = true },
          { "<leader>5", hidden = true },
          { "<leader>lg", hidden = true },
          { "<leader>o", hidden = true },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>f", group = "file" },
          { "<leader>g", group = "git" },
          { "<leader>u", group = "toggle" },
          { "<leader>q", group = "quit" },
          { "<leader>x", group = "quickfix" },
        },
      })
    end,
  },
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      -- support plugins which only support nvim-web-devicons
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  { "nvim-mini/mini.ai", version = false, opts = { n_lines = 500 } },
  { "nvim-mini/mini.surround", version = false, opts = {} },
  { "nvim-mini/mini.splitjoin", version = false, opts = {} },
  { "nvim-mini/mini.move", version = false, opts = {} },
  { "nvim-mini/mini.pairs", version = false, opts = {} },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
