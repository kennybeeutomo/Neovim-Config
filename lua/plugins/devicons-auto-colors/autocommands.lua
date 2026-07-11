local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

function M.setup()
	local deviconsCustom = augroup("deviconsCustom", { clear = true })
	autocmd("User", {
		pattern = "CleanColorscheme",
		group = deviconsCustom,
		callback = function(arg)
			require("plugins.devicons-auto-colors").apply(arg.data)
			-- require("plugins.devicons-auto-colors").setup()
		end,
		desc = "Setup devicons on colorscheme change"
	})
end

return M
