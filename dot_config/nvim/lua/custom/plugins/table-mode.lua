vim.pack.add({
	"https://github.com/dhruvasagar/vim-table-mode",
})

vim.keymap.set("n", "<leader>tm", "<cmd>TableModeToggle<CR>", { desc = "Toggle table mode" })
