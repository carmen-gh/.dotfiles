-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


------------------------------------------------------------------------------------------------------------------------
-- Keymappings
------------------------------------------------------------------------------------------------------------------------
lvim.keys.insert_mode["jj"] = "<ESC>"
lvim.keys.normal_mode["x"] = '"_x'            -- delete single character without copying into register
lvim.keys.visual_mode["<leader>p"] = [["_dP]] -- paste and keep
lvim.keys.normal_mode["<leader>d"] = [["_d]]
lvim.keys.normal_mode["YY"] = "va{Vy}"        -- copy function or json object
lvim.builtin.which_key.mappings["-"] = { "<cmd>split<CR>", "split horizontally" }
lvim.builtin.which_key.mappings["|"] = { "<cmd>vs<CR>", "split vertically" }
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
  o = { "<cmd>TodoTrouble<cr>", "todo" },
}

------------------------------------------------------------------------------------------------------------------------
-- Options
------------------------------------------------------------------------------------------------------------------------
vim.opt.relativenumber = true
vim.opt.colorcolumn = "+1"
vim.opt.textwidth = 120


------------------------------------------------------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------------------------------------------------------
lvim.plugins = {
  { "tpope/vim-sleuth" },
  { "tpope/vim-repeat" },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },
  { "lunarvim/colorschemes" },
  { "mrjones2014/nvim-ts-rainbow" },
}


------------------------------------------------------------------------------------------------------------------------
-- builtin
------------------------------------------------------------------------------------------------------------------------
lvim.colorscheme = "catppuccin-frappe"
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.lir.active = false
lvim.builtin.dap.breakpoint.text = lvim.icons.git.FileIgnored
lvim.builtin.which_key.setup.icons.separator = lvim.icons.ui.ChevronRight

lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true

lvim.builtin.bufferline.options.show_buffer_icons = false
lvim.builtin.bufferline.options.show_buffer_close_icons = false
lvim.builtin.bufferline.options.modified_icon = "[+]"
lvim.builtin.bufferline.options.color_icons = false
lvim.builtin.bufferline.options.diagnostics = ""

local components = require "lvim.core.lualine.components"
-- lualine show different mode icon = 
lvim.builtin.lualine.sections.lualine_c = { 'diagnostics' }
lvim.builtin.lualine.sections.lualine_x = { components.lsp, components.filetype }
lvim.builtin.lualine.sections.lualine_y = { }
lvim.builtin.lualine.extensions = { 'trouble' }

lvim.builtin.terminal.active = true


lvim.builtin.telescope = {
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      height = 0.8,         -- adjust the height of the results window
      width = 0.8,          -- adjust the width of the results window
      -- Adjust the following options as needed:
      preview_cutoff = 120, -- Maximum number of characters to display in the preview column
      -- results_width = 0.6,
      horizontal = {
        preview_width = 0.5, -- Adjust the width of the preview column
      },
    },
  },
}


------------------------------------------------------------------------------------------------------------------------
-- Autocommands
------------------------------------------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
    end
  end
})
