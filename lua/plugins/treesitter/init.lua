local M = {}

function M.setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "cpp", "c", "lua", "vimdoc", "norg", "markdown",
		                     "markdown_inline", "python" },

		sync_install = false,
		auto_install = false,
		ignore_install = {},
		modules = {},

		highlight = {
			additional_vim_regex_highlighting = false,
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				-- set to `false` to disable one of the mappings
				init_selection = false,
				node_incremental = false,
				scope_incremental = false,
				node_decremental = false,
			},
		},
		indent = {
			enable = true,
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["aa"] = { query = "@parameter.outer", desc = "Select around parameter" },
					["ia"] = { query = "@parameter.inner", desc = "Select inside parameter" },
					["af"] = { query = "@function.outer", desc = "Select around function" },
					["if"] = { query = "@function.inner", desc = "Select inside function" },
					["ac"] = { query = "@class.outer", desc = "Select around class" },
					["ic"] = { query = "@class.inner", desc = "Select inside class" },
					["as"] = { query = "@local.scope", desc = "Select around scope" },
					["is"] = { query = "@local.scope", desc = "Select inside scope" },
					["ab"] = { query = "@block.outer", desc = "Select around block" },
					["ib"] = { query = "@block.inner", desc = "Select inside block" },
				},
				selection_modes = {
				},
				include_surrounding_whitespace = false,
			},
			swap = {
				enable = true,
				swap_previous = {
					["<leader>,"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
				},
				swap_next = {
					["<leader>."] = { query = "@parameter.inner", desc = "Swap next parameter" },
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_previous_start = {
				},
				goto_next_start = {
				},
				goto_previous_end = {
					["<C-,>"] = { query = "@parameter.inner", desc = "Go to previous parameter" },
				},
				goto_next_end = {
					["<C-.>"] = { query = "@parameter.inner", desc = "Go to next parameter" },
				},
			},
		}
	})

	require("nvim-treesitter.install").prefer_git = true
	require("plugins.treesitter.mappings")
end

return M
