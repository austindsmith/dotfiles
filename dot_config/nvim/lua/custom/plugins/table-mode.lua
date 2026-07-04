vim.pack.add({
	"https://github.com/dhruvasagar/vim-table-mode",
})

vim.g.table_mode_corner = "|"

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.cmd("silent! TableModeEnable")
	end,
})

vim.keymap.set("n", "<leader>tm", "<cmd>TableModeToggle<CR>", { desc = "Toggle table mode" })
