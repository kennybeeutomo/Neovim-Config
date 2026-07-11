local M = {}

function M.colorschemeExists(colorscheme)
	-- Get the vimrc directory
	local vimrcPath = vim.fs.dirname(vim.fn.expand("$MYVIMRC"))
	-- Get the colorschemes directory
	local colorschemesPath = vimrcPath .. "/lua/plugins/colorschemes/"
	-- Get the list of colorschemes in that directory
	local colorschemes = vim.fs.dir(colorschemesPath)
	-- If colorscheme exists in the list, then load it
	for name, type in colorschemes do
		if name == colorscheme and type == "directory" then
			return true
		end
	end
	return false
end

function M.customHighlight(highlight)
	if M.colorschemeExists(vim.g.colors_name) then
		local hl = require("plugins.colorschemes." .. vim.g.colors_name .. ".custom").highlights[highlight]
		if hl ~= nil then
			hl()
		end
	end
end

function M.loadcolorscheme(colorscheme, file)
	if colorscheme == "pywal16" and vim.fn.executable("wal") ~= 1 then
		vim.print("pywal16 not installed!")
		return 1
	end

	require("plugins.colorschemes." .. colorscheme .. "." .. file).setup()

	return 0
end

function M.cleanColorscheme(colorscheme)
	vim.cmd.highlight("clear")
	if M.colorschemeExists(colorscheme) then
		M.loadcolorscheme(colorscheme, "before")
		vim.cmd.colorscheme(colorscheme)
		M.loadcolorscheme(colorscheme, "custom")
	else
		vim.cmd.colorscheme(colorscheme)
	end

	vim.api.nvim_exec_autocmds("User", {
		pattern = "CleanColorscheme",
		data = colorscheme
	})

	vim.g.colors_name = colorscheme
end

function M.refreshpywal()
	if M.isWindows() then
		vim.cmd("silent !wwal")
	end
	M.cleanColorscheme("pywal16")
end

function M.isWindows()
	if vim.uv.os_uname().sysname == "Windows_NT" then
		return true
	end
	return false
end

function M.getShell()
	return vim.fs.basename(vim.api.nvim_get_option_value("shell", {}))
end

function M.spawnTerminal()
	local cwd = vim.uv.cwd()
	local terminal = os.getenv("TERM")
	local commands = {
		alacritty = ' --working-directory '
	}
	local command = "silent !" .. terminal .. commands[terminal] .. "\'" .. cwd .. "\' &"
	vim.cmd(command)
end

function M.cycle(option, options)
	for i, v in ipairs(options) do
		if option == v then
			return options[i % #options + 1]
		end
	end
end

function M.cycleNumbers()
	if vim.o.number and vim.o.relativenumber then
		vim.o.relativenumber = false
	elseif vim.o.number and not vim.o.relativenumber then
		vim.o.number = false
	else
		vim.o.number = true
		vim.o.relativenumber = true
	end
end

function M.toggleConcealCursor()
	if vim.o.concealcursor:find("n") then
		vim.opt.concealcursor:remove("n")
	else
		vim.opt.concealcursor:append("n")
	end
end

function M.updateMinimalUI()
	if vim.g.minimal then
		vim.o.laststatus = 0
		vim.o.showtabline = 0
		vim.o.cmdheight = 0
	else
		vim.o.laststatus = 2
		vim.o.showtabline = 2
		vim.o.cmdheight = 1
	end
end

function M.cleanBufferDelete()
	local bufferNumber = vim.fn.bufnr()
	vim.cmd("bprevious")
	vim.cmd("bw! " .. bufferNumber)
end

return M
