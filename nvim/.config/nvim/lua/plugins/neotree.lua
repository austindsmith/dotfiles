return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				window = {
					mappings = {
						["Z"] = "expand_all_nodes", -- expand recursively
						["z"] = "close_all_nodes", -- collapse all
					},
				},
				filtered_items = {
					visible = true, -- show filtered items
					hide_dotfiles = false, -- do NOT hide dotfiles
          hide_gitignored = false,
					hide_hidden = false, -- (Windows attr; harmless on Linux)
				  never_show = {".git"},
        },
			},
		})
		vim.keymap.set("n", "<C-n>", "<cmd>Neotree filesystem reveal left<cr>")
	end,
}
