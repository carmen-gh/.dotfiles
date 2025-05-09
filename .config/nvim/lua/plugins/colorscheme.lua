return {
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha", -- "latte, frappe, macchiato, mocha"
      background = { -- :h background
        dark = "mocha",
      },
      integrations = {
        blink_cmp = true,
        dadbod_ui = true,
        dap = true,
        dap_ui = true,
        fidget = true,
        gitsigns = true,
        markdown = true,
        mason = true,
        neotree = true,
        neotest = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
          inlay_hints = {
            background = true,
          },
        },
        notify = true,
        treesitter = true,
        treesitter_context = true,
        rainbow_delimiters = true,
        semantic_tokens = true,
        telescope = {
          enabled = true,
        },
        which_key = true,
      },
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.surface2 },
          Pmenu = { bg = colors.surface0 },
          PmenuSel = { bg = colors.blue, fg = colors.base },
          NormalFloat = { bg = colors.surface0 },
          FloatBorder = { bg = colors.surface0 },
          TelescopeNormal = { bg = colors.surface0 },
          TelescopePromptTitle = { fg = colors.teal },
          TelescopePromptPrefix = { fg = colors.teal },
          TelescopePromptBorder = { fg = colors.teal, bg = colors.surface0 },
          TelescopeSelection = { bg = colors.surface1, fg = colors.text },
          TelescopeMatching = { fg = colors.blue },
          TelescopeSelectionCaret = { bg = colors.surface1, fg = colors.teal },
          GitSignsChange = { fg = colors.peach },
          LazyGitFloat = { bg = colors.mantle },
          LazyGitBorder = { fg = colors.mantle },
          IblScope = { fg = colors.surface2 },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },
}

-- Tokyonight
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd("colorscheme tokyonight-moon")
--   end,
-- }

-- One Nord
-- ( rainbow delimiters not supported)
-- return {
--   "rmehri01/onenord.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function(_, opts)
--     vim.cmd("colorscheme onenord")
--   end,
-- }

-- Everforest
-- return {
--   "neanias/everforest-nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd("colorscheme everforest")
--   end,
-- }

-- Kanagawa
-- ( rainbow delimiters not supported)
-- return {
--   "rebelot/kanagawa.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- Default options:
--     require("kanagawa").setup({
--       compile = false, -- enable compiling the colorscheme
--       undercurl = true, -- enable undercurls
--       commentStyle = { italic = true },
--       functionStyle = {},
--       keywordStyle = { italic = true },
--       statementStyle = { bold = true },
--       typeStyle = {},
--       transparent = false, -- do not set background color
--       dimInactive = false, -- dim inactive window `:h hl-NormalNC`
--       terminalColors = true, -- define vim.g.terminal_color_{0,17}
--       colors = { -- add/modify theme and palette colors
--         palette = {},
--         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
--       },
--       overrides = function(colors) -- add/modify highlights
--         local theme = colors.theme
--         return {
--           Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
--           PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
--           PmenuSbar = { bg = theme.ui.bg_m1 },
--           PmenuThumb = { bg = theme.ui.bg_p2 },
--         }
--       end,
--       theme = "wave", -- Load "wave" theme when 'background' option is not set
--       background = { -- map the value of 'background' option to a theme
--         dark = "wave", -- try "dragon" !
--         light = "lotus",
--       },
--     })
--
--     vim.cmd("colorscheme kanagawa")
--   end,
-- }
