return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
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
        extensions = {},
        defaults = {
          path_display = {
            "filename_first",
          },
          prompt_prefix = "  ",
          selection_caret = "  ",
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
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files theme=dropdown previewer=false<cr>", { desc = "files"})
      vim.keymap.set("n", "<leader>fs", builtin.live_grep, {desc = "string"})
      vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "git files" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "find word under cursor"})
      vim.keymap.set("x", "<leader>fs", builtin.grep_string, { desc = "find selection"})
      vim.keymap.set("n", "<leader>gf", builtin.git_status, { desc = "find modified file" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true theme=dropdown previewer=false<cr>", { desc = "buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "help" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "keymaps" })
      vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles theme=dropdown previewer=false<cr>", { desc = "oldfiles" })
      vim.keymap.set("n", "<leader>fm", function() require('telescope').extensions.notify.notify() end, { desc ="messages"})
      -- stylua: ignore end

      -- extensions
      require("telescope").load_extension("fzf")
    end,
  },
}
