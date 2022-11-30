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

		-- lua functions (used by many plugins)
		use("nvim-lua/plenary.nvim")

		-- essential plugins
		use("tpope/vim-surround")
		use("tpope/vim-repeat")
		use("vim-scripts/ReplaceWithRegister")
		use("numToStr/Comment.nvim")

		-- indent lines
		use("lukas-reineke/indent-blankline.nvim")

		-- rainbow brackets
		use("p00f/nvim-ts-rainbow")

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

		-- notify
		use("rcarriga/nvim-notify")

		-- icons
		use("kyazdani42/nvim-web-devicons")

		-- theme
		-- use({ "EdenEast/nightfox.nvim", run = ":NightfoxCompile" })
		use({ "catppuccin/nvim", as = "catppuccin" })
		-- use("navarasu/onedark.nvim")

		-- statusline
		use("nvim-lualine/lualine.nvim")
		use("arkav/lualine-lsp-progress")
		-- fuzzy finding w/ telescope
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

		-- autocompletion
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("saadparwaiz1/cmp_luasnip")

		-- snippets
		use("L3MON4D3/LuaSnip")
		use("rafamadriz/friendly-snippets")

		-- managing & installing lsp servers, linters & formatters
		use("williamboman/mason.nvim")
		use("williamboman/mason-lspconfig.nvim")

		-- configuring lsp servers
		use("neovim/nvim-lspconfig")
		use("hrsh7th/cmp-nvim-lsp")
		use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
		use({ "glepnir/lspsaga.nvim", branch = "main" }) --enhanced lsp ui
		-- use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)

		-- formatting & linting
		use("jose-elias-alvarez/null-ls.nvim")
		use("jayp0521/mason-null-ls.nvim")

		-- Debug Adapter Protocol client implementation
		use("mfussenegger/nvim-dap")
		use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

		-- treesitter configuration
		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				require("nvim-treesitter.install").update({ with_sync = true })
			end,
		})

		-- auto closing
		use("windwp/nvim-autopairs")
		-- use("windwp/nvim-ts-autotag")

		-- git integration
		use("lewis6991/gitsigns.nvim")
		use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

		-- markdown preview
		use({
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
		})

		-- terminal
		use({ "akinsho/toggleterm.nvim", tag = "*" })

		use("ThePrimeagen/vim-be-good")

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
})
