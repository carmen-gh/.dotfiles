return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "explorer" },
      { "<leader>E", false },
      { "<leader>fe", false },
      { "<leader>fE", false },
    },
    opts = {
      close_if_last_window = true,
      default_component_configs = {
        indent = {
          with_markers = false,
        },
        modified = {
          symbol = "",
        },
        git_status = {
          symbols = {
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
          },
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(_)
            -- auto close
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
-- stylua: ignore
    keys = {
      -- disable
      { "<leader>/", false },
      { "<leader><space>", false },
      { "<leader>fF", false },
      { "<leader>fR", false },
      { "<leader>fT", false }, -- not working
      { "<leader>fc", false },
      { "<leader>fn", false }, -- not working
      { "<leader>ft", false }, -- not working
      { "<leader>gs", false },
      { "<leader>sC", false },
      { "<leader>sD", false },
      { "<leader>sG", false },
      { "<leader>sH", false },
      { "<leader>sM", false },
      { "<leader>sR", false },
      { "<leader>sS", false },
      { "<leader>sW", false },
      { "<leader>sa", false },
      { "<leader>sb", false },
      { "<leader>sc", false },
      { "<leader>sd", false },
      { "<leader>sg", false },
      { "<leader>sh", false },
      { "<leader>sk", false },
      { "<leader>sm", false },
      { "<leader>so", false },
      { "<leader>ss", false },
      { "<leader>sw", false },
      { '<leader>s"', false },
      -- change a kemap
      { "<leader>fb", "<cmd>Telescope buffers theme=dropdown previewer=false sort_mru=true sort_lastused=true<cr>", desc = "buffers" },
      { "<leader>fd", function() require("telescope.builtin").find_files({ cwd = "~/.dotfiles", prompt_title = "dotfiles" }) end, desc = "dotfiles" },
      { "<leader>ff", "<cmd>Telescope find_files theme=dropdown previewer=false<cr>", desc = "files" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "help pages" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "keymaps" },
      { "<leader>fo", "<cmd>Telescope oldfiles theme=dropdown previewer=false<cr>", desc = "oldfiles" },
      { "<leader>fr", "<cmd>Telescope lsp_references theme=ivy path_display={'tail'}<cr>", desc = "reference" },
      { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc="string (live grep)" },
      { "<leader>gb", "<cmd>Telescope git_branches theme=dropdown previewer=false<cr>", desc = "branch" },
      { "<leader>xd", "<cmd>Telescope diagnostics theme=ivy<cr>", desc = "diagnostics" },
    },
    opts = {
      defaults = {
        prompt_prefix = "  ",
      },
    },
  },
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      require("harpoon"):setup(opts)
    end,
-- stylua: ignore
    keys = {
      { "<leader>hm", function() require("harpoon"):list():append() end, desc = "mark file", },
      { "<leader>hl", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "list marked files", },
      { "<leader>ha", function() require("harpoon"):list():select(1) end, desc = "file 1", },
      { "<leader>hs", function() require("harpoon"):list():select(2) end, desc = "file 2", },
      { "<leader>hd", function() require("harpoon"):list():select(3) end, desc = "file 3", },
      { "<leader>hf", function() require("harpoon"):list():select(4) end, desc = "file 4", },
      { "<leader>hg", function() require("harpoon"):list():select(5) end, desc = "file 5", },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

    -- stylua: ignore start
    map("n", "]h", gs.next_hunk, "next hunk")
    map("n", "[h", gs.prev_hunk, "prev hunk")
    map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "stage hunk")
    map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "reset hunk")
    map("n", "<leader>gS", gs.stage_buffer, "stage buffer")
    map("n", "<leader>gu", gs.undo_stage_hunk, "unstage hunk")
    map("n", "<leader>gR", gs.reset_buffer, "reset buffer")
    map("n", "<leader>gp", gs.preview_hunk, "preview hunk")
    map("n", "<leader>gl", function() gs.blame_line({ full = true }) end, "blame line")
    -- map("n", "<leader>ghd", gs.diffthis, "diff this")
    -- map("n", "<leader>ghD", function() gs.diffthis("~") end, "diff this ~")
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "gitSigns select hunk")
      end,
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        mode = { "n", "v" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>h"] = { name = "+harpoon" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    opts = {
      enable_default_keybindings = false,
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      window = {
        border = { "", "▁", "", "", "", " ", "", "" },
      },
    },
  },
}
