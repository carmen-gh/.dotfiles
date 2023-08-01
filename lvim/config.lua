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
-- TODO change from t to D ? t would then be used for test 
-- remove trouble if references and todo list shown with telescope?
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
lvim.builtin.which_key.mappings["l"]["R"] = { ":LspRestart<cr>", lvim.icons.kind.Null .. " Restart" }
-- TODO remap lsp next and previous diagnostics
-- TODO add remap for treesj see docu https://github.com/Wansmer/treesj
lvim.builtin.which_key.mappings["l"]["J"] = { ":lua require('treesj').toggle()<CR>", " Join/splitting blocks of code" }


------------------------------------------------------------------------------------------------------------------------
-- Options
------------------------------------------------------------------------------------------------------------------------
vim.opt.relativenumber = true
vim.opt.colorcolumn = "+1"
vim.opt.textwidth = 120
vim.opt.autoread = true
vim.opt.termguicolors = true


------------------------------------------------------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------------------------------------------------------
lvim.plugins = {
  { "tpope/vim-sleuth" },
  { "tpope/vim-repeat" },
  {
    "folke/trouble.nvim",
    cmd = "Troubletoggle",
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
    config = function()
      require("catppuccin").setup({
        dim_inactive = {
          enabled = true,
          shade = "light",
          percentage = 0.8,
        },
      })
    end,
    priority = 1000
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },
  {
    "Wansmer/treesj",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead"
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  { "HiPhish/rainbow-delimiters.nvim" },
  "simrat39/rust-tools.nvim",
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    version = 'legacy',
    config = function()
      require("fidget").setup(
        {
          text = {
            spinner = "dots"
          }
        }
      )
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript", "toml" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/neotest",
  "nvim-neotest/neotest-python"
}


------------------------------------------------------------------------------------------------------------------------
-- builtin
------------------------------------------------------------------------------------------------------------------------
lvim.colorscheme = "catppuccin-frappe"
-- lvim.lsp.automatic_servers_installation = false
lvim.builtin.lir.active = false
lvim.builtin.terminal.active = false
lvim.builtin.breadcrumbs.active = false

lvim.builtin.dap.breakpoint.text = lvim.icons.git.FileIgnored
lvim.builtin.which_key.setup.icons.separator = lvim.icons.ui.ChevronRight
table.insert(lvim.builtin.alpha.dashboard.section.buttons.entries,
  { "d", "  Diffview", ":DiffviewOpen<CR>" })

lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true

lvim.builtin.bufferline.options.show_buffer_icons = false
lvim.builtin.bufferline.options.show_buffer_close_icons = false
lvim.builtin.bufferline.options.modified_icon = "[+]"
lvim.builtin.bufferline.options.color_icons = false
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.bufferline.options.diagnostics = ""

local components = require "lvim.core.lualine.components"
-- lualine show different mode icon = 
lvim.builtin.lualine.sections.lualine_b = {}
lvim.builtin.lualine.sections.lualine_c = { components.branch, components.diagnostics }
lvim.builtin.lualine.sections.lualine_x = { components.lsp, components.filetype }
lvim.builtin.lualine.sections.lualine_y = {}
lvim.builtin.lualine.extensions = { 'trouble' }

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
-- quit nvimtree if last window
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

-- autoreload buffer after change on disk (e.g. lazygit toggleterm)
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})


------------------------------------------------------------------------------------------------------------------------
-- rust
------------------------------------------------------------------------------------------------------------------------
-- install via Mason: codelldb, rustfmt, rust-analyzer
pcall(function()
  require("rust-tools").setup {
    tools = {
      executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
      reload_workspace_from_cargo_toml = true,
      runnables = {
        use_telescope = true,
      },
      inlay_hints = {
        auto = true,
        only_current_line = false,
        show_parameter_hints = false,
        parameter_hints_prefix = "<-",
        other_hints_prefix = "=>",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "Comment",
      },
      hover_actions = {
        border = "rounded",
      },
      on_initialized = function()
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
          pattern = { "*.rs" },
          callback = function()
            local _, _ = pcall(vim.lsp.codelens.refresh)
          end,
        })
      end,
    },
    dap = {
      -- adapter= codelldb_adapter,
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    server = {
      on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        local rt = require "rust-tools"
        vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
      end,

      capabilities = require("lvim.lsp").common_capabilities(),
      settings = {
        ["rust-analyzer"] = {
          lens = {
            enable = true,
          },
          checkOnSave = {
            enable = true,
            command = "clippy",
          },
        },
      },
    },
  }
end)

lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.codelldb = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
end

vim.api.nvim_set_keymap("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>", { noremap = true, silent = true })

lvim.builtin.which_key.mappings["R"] = {
  name = "Rust",
  r = { "<cmd>RustRunnables<Cr>", "Runnables" },
  t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
  m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
  c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
  p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
  d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
  v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
  R = {
    "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
    "Reload Workspace",
  },
  o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
  y = { "<cmd>lua require'crates'.open_repository()<cr>", "[crates] open repository" },
  P = { "<cmd>lua require'crates'.show_popup()<cr>", "[crates] show popup" },
  i = { "<cmd>lua require'crates'.show_crate_popup()<cr>", "[crates] show info" },
  f = { "<cmd>lua require'crates'.show_features_popup()<cr>", "[crates] show features" },
  D = { "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "[crates] show dependencies" },
}

------------------------------------------------------------------------------------------------------------------------
-- python
------------------------------------------------------------------------------------------------------------------------

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } } }

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- setup testing
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    })
  }
})

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }


-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
