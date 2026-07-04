-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add({
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("*") },
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
})

vim.keymap.set("n", "\\", "<Cmd>Neotree reveal<CR>", { desc = "NeoTree toggle", silent = true })

require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_hidden = false,
		},
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		use_libuv_file_watcher = true,
		window = {
			mappings = {
				["\\"] = "close_window",
			},
		},
	},
})
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			require("neo-tree.command").execute({ action = "show" })
		end
	end,
})
