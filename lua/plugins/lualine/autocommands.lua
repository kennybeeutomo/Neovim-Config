local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local del = vim.api.nvim_clear_autocmds

local lualine = require("lualine")

function M.setup()
	local lualineCustom = augroup("lualineCustom", { clear = true })
	autocmd({ "User" }, {
		pattern = "AutosaveToggle",
		group = lualineCustom,
		callback = function()
			lualine.refresh()
		end,
		desc = "Refresh lualine on toggling autosave"
	})

	autocmd("User", {
		pattern = "CleanColorscheme",
		group = lualineCustom,
		callback = function(arg)
			require("plugins.lualine").setup(arg.data)
		end,
		desc = "Set lualine theme on colorscheme change"
	})

	-- When status line is hidden, prevent lualine
	-- from reappearing unexpectedly, such as when
	-- changing colorschemes
	del({
		group = "lualine",
		event = { "ColorScheme", "OptionSet" }
	})
end

return M
