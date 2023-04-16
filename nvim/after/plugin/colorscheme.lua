-- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_storm.lua

require("onedark").setup {
    style = 'dark',
    highlights = {
        GitGutterChange = { fg = "$orange" },
        GitSignsChange = { fg = "$orange" },
        GitSignsChangeLn = { fg = "$orange" },
        GitSignsChangeNr = { fg = "$orange" },
        DiagnosticHint = { fg = "$bg_yellow" },
        DiagnosticVirtualTextHint = { fg = "$yellow", bg = "$bg2" },
        WinSeparator = { fg = "#abb2bf" },
        NeoTreeWinSeparator = { fg = "$blue" },
        NeoTreeRootName = { fg = "$blue", fmt = "bold" },
    },
}

require("onedark").load()

-- require("tokyonight").setup({
--     style = "storm",
--     dim_inactive = true,
--     on_colors = function(colors)
--         colors.hint = "#e6d387"
--     end
-- })

vim.cmd [[colorscheme onedark]]
