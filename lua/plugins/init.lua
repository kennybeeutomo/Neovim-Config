require("plugins.lazyinit")
require("plugins.plugins")

local function load(files)
	for _, file in pairs(files) do
		require("plugins." .. file).setup()
	end
end

-- in order
load({
	"mason",

	"treesitter",
	"treesitter-incselect",
	"treesitter-textobjects",
	"autotag",

	"nvtree",
	"lualine",
	"bufferline",
	"gitsigns",
	"toggleterm",
	"telescope",

	"colorizer",
	"zenmode",

	"nvim-cmp",
	"luasnip",
	"lspconfig",
	"dap",
	"indent-blankline",
	"dressing",
})
