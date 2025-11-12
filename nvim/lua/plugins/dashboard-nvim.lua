return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("dashboard").setup({
				theme = "hyper",
				config = {
					header = {
						" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
						" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
						" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
						" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
						" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
						" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
					},

					shortcut = {
						{ desc = "Files", group = "Label", action = "Telescope find_files", key = "f" },
						{ desc = "Grep", group = "Label", action = "Telescope live_grep", key = "g" },
						{ desc = "New", group = "Label", action = "ene | startinsert", key = "n" },
						{ desc = "Quit", group = "Label", action = "qa", key = "q" },
					},
					packages = { enable = true },
					project = {
						enable = true,
						limit = 8,
						icon = "",
						label = " Projects",
						-- Use a function if you want cwd-specific open:
						action = function(path)
							vim.cmd("Telescope find_files cwd=" .. path)
						end,
					},
					mru = { enable = true, limit = 10, icon = "", label = " Recent", cwd_only = false },
					footer = {},
				},
			})
		end,
	},
}
