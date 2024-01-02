-- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_storm.lua
--
-- require("onedark").setup {
--     style = 'dark',
--     highlights = {
--         GitGutterChange = { fg = "$orange" },
--         GitSignsChange = { fg = "$orange" },
--         GitSignsChangeLn = { fg = "$orange" },
--         GitSignsChangeNr = { fg = "$orange" },
--         DiagnosticHint = { fg = "$bg_yellow" },
--         DiagnosticVirtualTextHint = { fg = "$yellow", bg = "$bg2" },
--         WinSeparator = { fg = "#abb2bf" },
--         NeoTreeWinSeparator = { fg = "$blue" },
--         NeoTreeRootName = { fg = "$blue", fmt = "bold" },
--     },
-- }

-- require("onedark").load()

-- require("tokyonight").setup({
--     style = "storm",
--     dim_inactive = true,
--     on_colors = function(colors)
--         colors.hint = "#e6d387"
--     end
-- })

-- vim.cmd [[colorscheme onedark]]
--

local frappe = require("catppuccin.palettes").get_palette "frappe"


require("catppuccin").setup({
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    term_colors = false,
    dim_inactive = {
        enabled = true,
        shade = "light",
        percentage = 0.35,
    },
    custom_highlights = {
        GitGutterChange = { fg = frappe.peach },
        GitSignsChange = { fg = frappe.peach },
        GitSignsChangeLn = { fg = frappe.peach },
        GitSignsChangeNr = { fg = frappe.peach },
        DiagnosticHint = { fg = frappe.rosewater },
        DiagnosticVirtualTextHint = { fg = frappe.yello, bg = frappe.surface2 },
        WinSeparator = { fg = "#abb2bf" },
        NeoTreeWinSeparator = { fg = frappe.blue },
        NeoTreeRootName = { fg = frappe.blue, style = { "bold "} },
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        mason = true,
        neotree = true,
        telescope = true,
        notify = false,
        lsp_saga = true,
        gitgutter = true,
        which_key = true,
        lsp_trouble = true,
        treesitter = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
