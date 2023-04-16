-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer
local status, packer = pcall(require, "packer")
if not status then
    return
end

-- add list of plugins to install
return packer.startup({
    function(use)
        -- packer can manage itself
        use("wbthomason/packer.nvim")

        -- theme
        use("folke/tokyonight.nvim")
        use("navarasu/onedark.nvim")
        use({ "levouh/tint.nvim",
            config = function()
                require("tint").setup()
            end,
        })

        -- lua functions (used by many plugins)
        use("nvim-lua/plenary.nvim")

        -- lsp
        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v1.x',
            requires = {
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
        }
        use("glepnir/lspsaga.nvim")
        use("onsails/lspkind.nvim")

        -- formatter & linter
        use({
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            "jayp0521/mason-null-ls.nvim",
        })

        -- syntax highlighting
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
        })
        -- rainbow brackets
        use("p00f/nvim-ts-rainbow")
        -- auto close brackets
        use({
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({})
            end,
        })
        -- indent line
        use("lukas-reineke/indent-blankline.nvim")
        -- detect tapstop and shiftwidth automatically
        use("tpope/vim-sleuth")

        -- file explorer
        use({
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            },
        })
        use({
            "nvim-telescope/telescope.nvim",
            tag = "0.1.x",
            requires = { { "nvim-lua/plenary.nvim" } },
        })
        use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

        use("ThePrimeagen/harpoon")

        -- statusline
        use("nvim-lualine/lualine.nvim")
        use("arkav/lualine-lsp-progress")

        -- git
        use({
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup()
            end,
        })
        use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

        -- essential plugins
        use("tpope/vim-surround")
        use("tpope/vim-repeat")
        use("vim-scripts/ReplaceWithRegister")
        use({
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end,
        })

        -- terminal
        use({ "akinsho/toggleterm.nvim", tag = "*" })

        -- Todo
        use {
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup {
                    signs = false,
                    keywords = {
                        TODO = { color = "warning" },
                    }
                }
            end
        }
        use {
            "folke/trouble.nvim",
            requires = "nvim-tree/nvim-web-devicons",
            config = function()
                require("trouble").setup()
            end
        }

        if packer_bootstrap then
            require('packer').sync()
        end

    end,
})
