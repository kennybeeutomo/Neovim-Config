local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local treesitterCustom = augroup("treesitterCustom", { clear = true })
autocmd('BufRead', {
	group = treesitterCustom,
	callback = function()
		local installed_parsers = require("nvim-treesitter").get_installed()
		if vim.tbl_contains(installed_parsers, vim.bo.filetype) then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.treesitter.start()
			return
		end
	end,
	desc = "Start Treesitter Highlighting"
})
