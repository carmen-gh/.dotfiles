return {
{
  "folke/sidekick.nvim",
  opts = {
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<c-.>",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle",
    },
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select() end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Select CLI",
    },
    {
      "<leader>ad",
      function() require("sidekick.cli").close() end,
      desc = "Detach a CLI Session",
    },
    {
      "<leader>at",
      function() require("sidekick.cli").send({ msg = "{this}" }) end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function() require("sidekick.cli").send({ msg = "{file}" }) end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function() require("sidekick.cli").send({ msg = "{selection}" }) end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    -- Example of a keybinding to open Claude directly
    {
      "<leader>ac",
      function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
      desc = "Sidekick Toggle Claude",
    },
  },
}
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = { enabled = false },
  --     filetypes = {
  --       markdown = true,
  --       help = true,
  --     },
  --   },
  -- },
  -- {
  --   "olimorris/codecompanion.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "hrsh7th/nvim-cmp",
  --     "nvim-telescope/telescope.nvim",
  --     { "stevearc/dressing.nvim", opts = {} },
  --   },
  --   config = function()
  --     require("codecompanion").setup({
  --       strategies = {
  --         chat = {
  --           adapter = "ollama",
  --         },
  --         inline = {
  --           adapter = "ollama",
  --         },
  --         agent = {
  --           adapter = "ollama",
  --         },
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "David-Kunz/gen.nvim",
  --   config = function()
  --     require("gen").setup({
  --       model = "llama3.2",
  --       quit_map = "q",
  --       retry_map = "<c-r>",
  --       accept_map = "<c-cr>",
  --       display_mode = "split", -- The display mode. Can be "float" or "split" or "horizontal-split".
  --       show_prompt = true,
  --       show_model = true,
  --       no_auto_close = false, -- Never closes the window automatically.
  --       hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
  --       init = function(options)
  --         pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
  --       end,
  --       -- Function to initialize Ollama
  --       command = function(options)
  --         local body = { model = options.model, stream = true }
  --         return "curl --silent --no-buffer -X POST http://"
  --           .. options.host
  --           .. ":"
  --           .. options.port
  --           .. "/api/chat -d $body"
  --       end,
  --     })
  --
  --     vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>Gen<CR>", { desc = "AI Prompt selection" })
  --   end,
  -- },
}
