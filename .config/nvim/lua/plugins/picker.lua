return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-mini/mini.icons" },
  -- cmd = "FzfLua",
  config = function()
    local fzf = require("fzf-lua")

    fzf.config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    fzf.config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    fzf.config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"

    fzf.setup({
      fzf_colors = true,
      defaults = {
        formatter = "path.dirname_first",
      },
      files = {
        hidden = true,
        cwd_prompt = false,
        actions = {
          ["alt-h"] = { fzf.actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ["alt-h"] = { fzf.actions.toggle_hidden },
        },
      },
      lsp = {
        symbols = {
          symbol_fmt = function(s)
            return s:lower() .. "\t"
          end,
          child_prefix = false,
        },
        code_actions = {
          -- TODO remove title
          -- prompt = " ",
          previewer = nil,
        },
      },
    })
      -- stylua: ignore start
      -- buffer
      vim.keymap.set( "n", "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true previewer=false<cr>", { desc = "switch buffer" })
      vim.keymap.set("n", "<leader>/", "<cmd>FzfLua grep_curbuf <cr>", { desc = "live grep current buffer" })

      -- files
      vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "files" })
      vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "grep" })
      vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua git_status previewer=false winopts={width=0.4}<cr>", { desc = "modified files (git)" })
      vim.keymap.set("n", "<leader>fo", "<cmd>FzfLua oldfiles previewer=false winopts={width=0.4}<cr>", { desc = "oldfiles" })

      vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua resume<cr>", { desc = "resume" }) -- TODO check lsp references
      vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>", { desc = "word under cursor" })
      vim.keymap.set("x", "<leader>fw", "<cmd>FzfLua grep_visual<cr>", { desc = "selected word" })
      vim.keymap.set("n", '<leader>f"', "<cmd>FzfLua registers<cr>", { desc = "registers" })
      vim.keymap.set("n", '<leader>fh', "<cmd>FzfLua helptags<cr>", { desc = "helptags" })
      vim.keymap.set("n", '<leader>fk', "<cmd>FzfLua keymaps<cr>", { desc = "keymaps" })

      -- lsp
      vim.keymap.set("n", '<leader>fd', "<cmd>FzfLua diagnostics_document<cr>", { desc = "diagnostics document" })
      vim.keymap.set("n", '<leader>fD', "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "diagnostics workspace" })
      vim.keymap.set("n", '<leader>fs', "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "symbols document" })
      vim.keymap.set("n", '<leader>fS', "<cmd>FzfLua lsp_live_workspace_symbols<cr>", { desc = "symbols workspace" })
      vim.keymap.set("n", '<leader>gr', "<cmd>FzfLua lsp_references<cr>", { desc = "git branches" })
      vim.keymap.set("n", '<leader>fb', "<cmd>FzfLua dap_breakpoints<cr>", { desc = "breakpoints" })

      -- git
      vim.keymap.set("n", '<leader>gb', "<cmd>FzfLua git_branches<cr>", { desc = "git branches" })
      vim.keymap.set("n", '<leader>gt', "<cmd>FzfLua git_tags<cr>", { desc = "git tags" })

      -- spell
      vim.keymap.set("n", '<leader>s', "<cmd>FzfLua spell_suggest<cr>", { desc = "spell suggest" })


      -- UI select
      require("fzf-lua").register_ui_select(function(_, items)
        local min_h, max_h = 0.15, 0.70
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end
        return {
          winopts = {relative='cursor', height = h, width = 0.40, row = 0.40, preview = { hidden = "hidden" } },
        }
      end)
  end,
}
