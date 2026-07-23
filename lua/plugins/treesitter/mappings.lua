local incremental_selection = require("nvim-treesitter.incremental_selection")
local set = vim.keymap.set

set({"n", "v"}, "<C-h>", incremental_selection.node_decremental, { desc = "Decrement node selection" })
set({"n", "v"}, "<C-l>", incremental_selection.node_incremental, { desc = "Increment node selection" })
