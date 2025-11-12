return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<c-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>ff", builtin.buffers, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						-- include dotfiles and follow symlinks by default
						find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
						-- if you prefer ripgrep:
						-- find_command = { "rg", "--files", "--hidden", "--follow", "-g", "!.git" },
					},
					live_grep = {
						additional_args = function()
							return { "--hidden", "--glob", "!.git" }
						end,
					},
				},

				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
