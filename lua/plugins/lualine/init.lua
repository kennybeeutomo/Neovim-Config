local M = {}

local themes = {
	["default"] = "16color",
	["pywal16"] = "pywal16-nvim",
	["night-owl"] = "night-owl",
}

local function isDefaultTheme(theme)
	for i,_ in pairs(themes) do
		if i == theme then
			return false
		end
	end
	return true
end

local function autosave()
	if vim.g.autosave then
		return " "
	else
		return ""
	end
end

function M.setup(theme)
	if theme == nil or isDefaultTheme(theme) then
		theme = "default"
	end

	local hidden = vim.o.laststatus == 0

	require("lualine").setup {
		options = {
			icons_enabled = true,
			theme = themes[theme],
			component_separators = { left = "|", right = "|"},
			section_separators = { left = " ", right = " "},
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				-- tabline = 1000,
				winbar = 1000,
			}
		},
		sections = {
			lualine_a = {"mode"},
			lualine_b = {"branch", "diff", "diagnostics"},
			lualine_c = {"filename"},
			lualine_x = {autosave, "encoding", "fileformat", "filetype"},
			lualine_y = {"progress"},
			lualine_z = {"location"}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {"filename"},
			lualine_x = {"location"},
			lualine_y = {},
			lualine_z = {}
		},
		-- tabline = {
		-- 	lualine_a = {
		-- 		{
		-- 			"buffers",
		-- 			symbols = {
		-- 				alternate_file = ""
		-- 			}
		-- 		}
		-- 	},
		-- 	lualine_b = {},
		-- 	lualine_c = {},
		-- 	lualine_x = {},
		-- 	lualine_y = {},
		-- 	lualine_z = {}
		-- },
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	}
	-- 

	if hidden then vim.o.laststatus = 0 end

	require("plugins.lualine.autocommands").setup()
end

return M
