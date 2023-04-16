local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- NOTE: `opts = {}` is the same as calling `require('myPlugin').setup({})`
local plugins = {
  "navarasu/onedark.nvim",
  "nvim-lua/plenary.nvim",
  "glepnir/lspsaga.nvim",
  "onsails/lspkind.nvim",
  "p00f/nvim-ts-rainbow",
  "lukas-reineke/indent-blankline.nvim",
  "tpope/vim-sleuth",
  "nvim-lualine/lualine.nvim",
  "arkav/lualine-lsp-progress",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "vim-scripts/ReplaceWithRegister",
  "williamboman/mason.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "jayp0521/mason-null-ls.nvim",
  {
    "levouh/tint.nvim",
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      { 'williamboman/mason.nvim' }, -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-buffer' }, -- Optional
      { 'hrsh7th/cmp-path' }, -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' }, -- Optional
      -- Snippets
      { 'L3MON4D3/LuaSnip' }, -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make"
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim"
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*"
  },
  {
    "windwp/nvim-autopairs",
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
  }


}

local opts = {}

require("lazy").setup(plugins, opts)




-- -- Todo
-- use {
--   "folke/todo-comments.nvim",
--   requires = "nvim-lua/plenary.nvim",
--   config = function()
--     require("todo-comments").setup {
--       signs = false,
--       keywords = {
--         TODO = { color = "warning" },
--       }
--     }
--   end
-- }
-- use {
--   "folke/trouble.nvim",
--   requires = "nvim-tree/nvim-web-devicons",
--   config = function()
--     require("trouble").setup()
--   end
-- }
