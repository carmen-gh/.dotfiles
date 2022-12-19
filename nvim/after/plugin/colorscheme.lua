-- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_storm.lua

require("tokyonight").setup({
    style = "storm",
    dim_inactive = true,
    on_colors = function(colors)
        colors.hint = "#e6d387"
    end
})

vim.cmd [[colorscheme tokyonight]]
