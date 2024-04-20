-- Catppuccin Theme
-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   lazy = false,
--   priority = 1000,
--   opts = {
--     flavour = "macchiato", -- "latte, frappe, macchiato, mocha"
--     background = { -- :h background
--       dark = "mocha",
--     },
--     -- transparent_background = true,
--     integrations = {
--       alpha = true,
--       cmp = true,
--       dap = true,
--       dap_ui = true,
--       fidget = true,
--       gitsigns = true,
--       harpoon = true,
--       markdown = true,
--       mason = true,
--       mini = true,
--       neotree = true,
--       neotest = true,
--       native_lsp = {
--         enabled = true,
--         underlines = {
--           errors = { "undercurl" },
--           hints = { "undercurl" },
--           warnings = { "undercurl" },
--           information = { "undercurl" },
--         },
--         inlay_hints = {
--           background = true,
--         },
--       },
--       treesitter = true,
--       treesitter_context = true,
--       rainbow_delimiters = true,
--       semantic_tokens = true,
--       telescope = {
--         enabled = true,
--       },
--       which_key = true,
--     },
--     custom_highlights = function(colors)
--       return {
--         Pmenu = { bg = colors.surface0 },
--         PmenuSel = { bg = colors.surface1 },
--         NormalFloat = { bg = colors.surface0 },
--         FloatBorder = { bg = colors.surface0 },
--         TelescopeNormal = { bg = colors.surface0 },
--         TelescopePromptPrefix = { fg = colors.blue },
--         TelescopeSelection = { bg = colors.surface1, fg = colors.text },
--         TelescopeMatching = { fg = colors.blue },
--         TelescopeSelectionCaret = { fg = colors.blue },
--         MiniHipatternsTodo = { fg = colors.yellow },
--         MiniHipatternsFixme = { bg = colors.red, fg = colors.base },
--         MiniHipatternsHack = { bg = colors.peach, fg = colors.base },
--         MiniHipatternsNote = { fg = colors.teal },
--         MiniIndentscopeSymbol = { fg = colors.surface2 },
--         GitSignsChange = { fg = colors.yellow },
--         -- GitSignsChange = { fg = "#FFD700" },
--         GitSignsAdd = { fg = "#00A36C" },
--       }
--     end,
--   },
--   config = function(_, opts)
--     require("catppuccin").setup(opts)
--     vim.cmd("colorscheme catppuccin")
--   end,
-- }

-- One Nord Theme
-- return {
--   -- https://github.com/rmehri01/onenord.nvim
--   "rmehri01/onenord.nvim",
--   lazy = false, -- We want the colorscheme to load immediately when starting Neovim
--   priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
--   config = function()
--     vim.cmd("colorscheme onenord") -- Replace this with your favorite colorscheme
--   end,
-- }
--
-- return {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   lazy = false,
--   config = function()
--     vim.cmd("colorscheme rose-pine") -- Replace this with your favorite colorscheme
--   end,
-- }

-- Tokyo Night Theme
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd([[colorscheme tokyonight-storm]])
  end,
}
