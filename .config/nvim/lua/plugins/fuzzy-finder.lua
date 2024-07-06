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
      require("telescope").setup({
        extensions = {},
        defaults = {
          path_display = {
            filename_first = {
              reverse_directories = true,
            },
          },
          prompt_prefix = "  ",
          selection_caret = " ",
          layout_config = {
            prompt_position = "top",
          },
          mappings = {
            n = {
              ["q"] = require("telescope.actions").close,
            },
          },
        },
      })

      local builtin = require("telescope.builtin")

      -- keys
      -- stylua: ignore start
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files theme=dropdown previewer=false<cr>", { desc = "files"})
      vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "string" })
      vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "git files" })
      vim.keymap.set("n", "<leader>gf", builtin.git_status, { desc = "find modified file" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true theme=dropdown previewer=false<cr>", { desc = "buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "help" })
      vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles theme=dropdown previewer=false<cr>", { desc = "oldfiles" })
      vim.keymap.set("n", "<leader>fd", function()
        builtin.find_files({ cwd = "~/.dotfiles", prompt_title = "dotfiles" })
      end, { desc = "dotfiles" })
      -- stylua: ignore end

      -- extensions
      require("telescope").load_extension("fzf")
    end,
  },
}
