local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use "wbthomason/packer.nvim" -- Have packer manage itself    

	-- LSP 

	-- use 'neovim/nvim-lspconfig'

	-- Themes 
	use 'Mofiqul/vscode.nvim'
	use 'bluz71/vim-nightfly-colors'
	use { "catppuccin/nvim", as = "catppuccin" }
	use "rebelot/kanagawa.nvim"

	-- Languages support - Terraform
	use "hashivim/vim-terraform"


	-- Terminal Plugin
	use {"akinsho/toggleterm.nvim", tag = '*'}

	-- Telescope 
	use {
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.3',
		requires = { 
			{
				'nvim-lua/plenary.nvim'
			} 
		}
	}

	-- Harpoon 
	use 'ThePrimeagen/harpoon'


	-- Nvim Tree
	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-tree/nvim-web-devicons'

	-- Git Plugins
	use 'tpope/vim-fugitive'
	use 'lewis6991/gitsigns.nvim'

	-- Comments plugins
	use 'numToStr/Comment.nvim'

	-- Undo History
	use 'mbbill/undotree'

	-- NVim Airline
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'

	use 'folke/trouble.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	-- Indent plugins
	use {
		"lukas-reineke/indent-blankline.nvim",
		tag = 'v3.8.2',
	}


	-- Markdown Preview
	use 'iamcco/markdown-preview.nvim'

	-- Disabled plugins
	--[[ use 'romgrk/barbar.nvim' ]]

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
