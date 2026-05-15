return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			-- existing mappings
			vim.keymap.set("n", "<c-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>ff", builtin.buffers, {})

			-- vertical split + Telescope
			vim.keymap.set("n", "<leader>vs", function()
				vim.cmd("vsplit") -- create vertical split
				vim.cmd("wincmd l") -- move to the right split
				builtin.find_files() -- run the same picker as <C-p>
			end, { desc = "Vsplit + Telescope find files" })

			-- horizontal split + Telescope
			vim.keymap.set("n", "<leader>hs", function()
				vim.cmd("split") -- create horizontal split
				vim.cmd("wincmd j") -- move to the bottom split
				builtin.find_files() -- same picker, new window
			end, { desc = "Hsplit + Telescope find files" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
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
