vim.pack.add({ "https://github.com/akinsho/toggleterm.nvim" })
require("toggleterm").setup({
	open_mapping = [[<C-t>]],
	direction = "float",
})
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
