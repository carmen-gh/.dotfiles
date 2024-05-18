return {
  {
    "letieu/wezterm-move.nvim",
    keys = {
      -- stylua: ignore start
      {"<C-h>", function() require("wezterm-move").move("h") end,},
      {"<C-j>", function() require("wezterm-move").move("j") end,},
      {"<C-k>", function() require("wezterm-move").move("k") end,},
      {"<C-l>", function() require("wezterm-move").move("l") end,},
      -- stylua: ignore end
    },
  },
}
