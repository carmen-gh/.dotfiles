return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      telescope.setup({
        extensions = {
          undo = {
            mappings = {
              i = {
                ["<cr>"] = require("telescope-undo.actions").yank_additions,
                ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                ["<C-cr>"] = require("telescope-undo.actions").restore,
                -- alternative defaults, for users whose terminals do questionable things with modified <cr>
                ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
                ["<C-r>"] = require("telescope-undo.actions").restore,
              },
              n = {
                ["y"] = require("telescope-undo.actions").yank_additions,
                ["Y"] = require("telescope-undo.actions").yank_deletions,
                ["u"] = require("telescope-undo.actions").restore,
              },
            },
          },
        },
        defaults = {
          path_display = function(_, path)
            local cwd = vim.fn.getcwd() -- Get the current working directory
            local rel_path = string.gsub(path, cwd .. "/", "") -- Make the path relative to cwd
            local directory = vim.fn.fnamemodify(rel_path, ":h") -- Extract the directory
            local filename = vim.fn.fnamemodify(rel_path, ":t") -- Extract the filename
            local formatted = string.format("%s/%s", directory, filename)
            local highlights = { { { 0, #directory }, "Comment" } } -- set highlight group for directory
            return formatted, highlights
          end,
          prompt_prefix = "  ",
          selection_caret = "󰄾 ",
          file_ignore_patterns = {
            ".DS_Store",
            ".git/",
            "deps/",
            "erl_crash",
          },
          mappings = {
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          oldfiles = {
            prompt_title = "History",
          },
          buffers = {
            mappings = {
              i = {
                ["<C-x>"] = "delete_buffer",
              },
            },
          },
        },
      })

      -- keys
      -- stylua: ignore start
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", { desc = "files"})
      vim.keymap.set("n", "<leader>fs", builtin.live_grep, {desc = "string"})
      vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "git files" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "find word under cursor"})
      vim.keymap.set("x", "<leader>fs", builtin.grep_string, { desc = "find selection"})
      vim.keymap.set("n", "<leader>gf", builtin.git_status, { desc = "find modified file" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true theme=dropdown previewer=false<cr>", { desc = "buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "help" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "keymaps" })
      vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles theme=dropdown previewer=false<cr>", { desc = "oldfiles" })
      vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "undo history"})
      -- lsp
      vim.keymap.set("n", "<leader>xd", "<cmd>Telescope diagnostics theme=ivy<cr>", { desc = "diagnostics" })
      vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references theme=ivy<cr>", { desc = "go to references" })
      vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references theme=ivy<cr>", { desc = "references" })
      -- git
      vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches theme=dropdown previewer=false<cr>", { desc = "branch" })
      -- stylua: ignore end

      -- extensions
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("undo")
      require("telescope").load_extension("flutter")
    end,
  },
}
