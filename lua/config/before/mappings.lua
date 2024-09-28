vim.g.mapleader = ' '
local set = vim.keymap.set

-- General
set("n", "<leader>qq", "<cmd>qa!<cr>", { desc = "Quit All" })
set("n", "<leader>qw", "<cmd>wqa!<cr>", { desc = "Save and quit All" })

-- Options
set("n", "<leader>trn", function()
	vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle Relative Number" })

-- Surround
set("v", "<leader>s(", "c(<Esc>pa)<Esc>", { desc = "Surround in ()" })
set("v", "<leader>s[", "c[<Esc>pa]<Esc>", { desc = "Surround in []" })
set("v", "<leader>s{", "c{<Esc>pa}<Esc>", { desc = "Surround in {}" })
set("v", "<leader>s\'", "c'<Esc>pa'<Esc>", { desc = "Surround in ''" })
set("v", "<leader>s\"", "c\"<Esc>pa\"<Esc>", { desc = "Surround in \"\"" })
set("v", "<leader>s<", "c<<Esc>pa><Esc>", { desc = "Surround in <>" })

-- Buffers
set("n", "<leader>qb", "<cmd>bd<cr>", { desc = "Delete buffer" })
set("n", "<Tab>", "<cmd>bn<cr>", { desc = "Next Buffer" })
set("n", "<S-Tab>", "<cmd>bN<cr>", { desc = "Previous Buffer" })

-- NvimTree
set("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "Focus NvimTree" })
set("n", "<leader>n", "<cmd>NvimTreeClose<cr>", { desc = "Close NvimTree" })
set("n", "<leader>cd", "<cmd>cd %:h<cr>", { desc = "cd to directory of current file" })

-- Beautifier
set("n", "<leader>s", "T{i<cr><esc>t}a<cr><esc>", { desc = "Expand curly braces" })

-- Terminal
set("n", "<M-v>", "<cmd>ToggleTerm direction=vertical size=60<cr>", { desc = "Show terminal vertically" })
set("n", "<M-h>", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Show terminal horizontally" })
set("n", "<M-n>", "<cmd>ToggleTerm direction=tab<cr>", { desc = "Show terminal in a tab" })
set("t", "<M-v>", "<cmd>ToggleTerm<cr>", { desc = "Hide terminal" })
set("t", "<M-h>", "<cmd>ToggleTerm<cr>", { desc = "Hide terminal" })
set("t", "<M-n>", "<cmd>ToggleTerm<cr>", { desc = "Hide terminal" })

-- Run / Compile
local function execTerm(command, focus)
	if focus then
		vim.cmd("TermExec cmd=\"" .. command .. "\" go_back=0")
	else
		vim.cmd("TermExec cmd=\"" .. command .. "\"")
	end
end

local function runOrCompile(opts)
	opts = opts or {}
	local cls = opts.cls or false
	local focus = opts.focus or false
	local filetype = vim.bo.filetype

	local function exec(command)
		execTerm(command, focus)
	end

	local commands = {
		python = function() exec(vim.api.nvim_buf_get_name(0)) end,
		c = function () exec("make && make run") end,
		cpp = function () exec("make && make run") end,
	}

	if commands[filetype] then
		if cls then exec("cls") end
		commands[filetype]()
	else
		print("No run command for " .. filetype .. " yet")
	end
end

set("n", "<leader>rr", function() runOrCompile() end, { desc = "Run / Compile" })
set("n", "<leader>rn", function() runOrCompile({cls = true}) end, { desc = "Run / Compile then clear" })
set("n", "<leader>rf", function() runOrCompile({focus = true}) end, { desc = "Run / Compile then focus" })

-- Windows
set("n", "<leader>wv", "<C-w>v", { desc = "New vertical window" })
set("n", "<leader>wh", "<C-w>s", { desc = "New horizontal window" })

-- Colorizer
set("n", "<leader>ct", "<cmd>ColorizerToggle<cr>", { desc = "Toggle Colorizer" })
set("n", "<leader>cr", "<cmd>ColorizerReloadAllBuffers<cr>", { desc = "Reload Colorizer" })

-- Selection
set("n", "<leader>a", "ggVG", { desc = "Select all" })

-- Telescope
set("n", "<leader>ff", "<cmd>Telescope find_files<cr><esc>", { desc = "Find files" })
set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr><esc>", { desc = "Old files" })
set("n", "<leader>fb", "<cmd>Telescope buffers<cr><esc>", { desc = "Buffers" })

-- Fold
set("n", "<leader>o", "zo", { desc = "Open fold" })
set("n", "<leader>O", "zc", { desc = "Close fold" })

-- Markdown Preview
set("n", "<leader>md", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Preview Markdown" })

-- LSP
set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Go to declaration" })
set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover" })
set("n", "gr", vim.lsp.buf.references, { desc = "LSP: References" })
set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature help" })

-- Format
set("n", "<leader>\\f", function()
	local file = vim.api.nvim_buf_get_name(0)
	vim.cmd("!clang-format -i " .. file)
end, { desc = "clang-format current file" })

-- Search
set("n", "<esc>", "<cmd>noh<cr>")

-- WhichKey
set("n", "\\", "<cmd>WhichKey<cr>")

-- -- Command Mode
-- set("n", ":", "q:i", { desc = "Open command mode in vim mode" })
