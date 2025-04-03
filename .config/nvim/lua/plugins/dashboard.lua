return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }
    -- Set menu
    dashboard.section.buttons.val = {
      -- dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert <CR>"),
      -- dashboard.button("f", "  Find file", "<cmd>Telescope find_files theme=dropdown previewer=false<CR>"),
      -- dashboard.button("o", "  Recent files", "<cmd>Telescope oldfiles theme=dropdown previewer=false<cr>"),
      dashboard.button("d", "  Diffview", "<cmd>DiffviewOpen<CR>"),
      dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:h<CR>"),
      dashboard.button("u", "  Update", "<cmd>Lazy update<cr>"),
      dashboard.button("q", "  Close", ":qa<CR>"),
    }

    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"

    alpha.setup(dashboard.opts)
  end,
}
