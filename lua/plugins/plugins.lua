local utils = require("utils")

local luasnipBuild = "make install_jsregexp"
if utils.isWindows() then
	luasnipBuild = luasnipBuild .. " CC=gcc.exe SHELL=C:/Program\\ Files/Git/bin/sh.exe .SHELLFLAGS=-c"
end

require("lazy").setup({
	{ "nvim-lua/plenary.nvim" },

	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	{ "nvim-treesitter/nvim-treesitter" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,
	},
	{ "shushtain/incselect.nvim" },
	{ "windwp/nvim-ts-autotag" },

	{ "nvim-tree/nvim-web-devicons" },
	{
		"rachartier/tiny-devicons-auto-colors.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		event = "VeryLazy",
		config = require("plugins.devicons-auto-colors").setup,
	},
	{ "nvim-tree/nvim-tree.lua", },

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

	{ "lewis6991/gitsigns.nvim", },

	{
		"akinsho/toggleterm.nvim",
		version = "*",
	},

	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", },
	},

	{
		"NvChad/nvim-colorizer.lua",
	},

	{
		"kwakzalver/duckytype.nvim",
		cmd = { "DuckyType" },
		config = require("plugins.duckytype").setup,
	},

	{
		"folke/zen-mode.nvim",
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
		config = require("plugins.markdownpreview").setup,
	},

	{
		"nvim-neorg/neorg",
		version = "*",
		config = require("plugins.neorg").setup,
		dependencies = {
			"nvim-neorg/tree-sitter-norg",
			"nvim-neorg/tree-sitter-norg-meta",
		}
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = require("plugins.whichkey").setup,
	},

	{ "oxfist/night-owl.nvim", },
	{ "uZer/pywal16.nvim", },

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = require("plugins.autopairs").setup,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},

			-- disable when a .luarc.json file is found
			enabled = function(root_dir)
				return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
			end,
		},
	},

	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = luasnipBuild
	},
	{ "saadparwaiz1/cmp_luasnip" },

	{ "mfussenegger/nvim-dap" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio"
		}
	},

	{ "lukas-reineke/indent-blankline.nvim" },

	{
		"barrett-ruth/live-server.nvim",
		build = "npm add -g live-server",
		cmd = { "LiveServerStart", "LiveServerStop" },
		config = true,
	},

	{ 'stevearc/dressing.nvim' },

	{
		'nvim-flutter/flutter-tools.nvim',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim',
		},
		config = true,
	},
})
