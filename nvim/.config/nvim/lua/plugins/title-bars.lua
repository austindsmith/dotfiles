return {
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
	{
		"b0o/incline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local incline = require("incline")
			local devicons = require("nvim-web-devicons")

			local mode_map = {
				n = "NORMAL",
				i = "INSERT",
				v = "VISUAL",
				V = "V-LINE",
				["\22"] = "V-BLOCK",
				c = "COMMAND",
				R = "REPLACE",
			}

			incline.setup({
				window = {
					padding = 0,
					margin = { horizontal = 0, vertical = 1 },
					placement = {
						horizontal = "right", -- move whole bar to the right
						vertical = "top",
					},
				},
				render = function(props)
					local mode = vim.api.nvim_get_mode().mode
					local mode_text = mode_map[mode] or mode

					local bufname = vim.api.nvim_buf_get_name(props.buf)
					local filename = vim.fn.fnamemodify(bufname, ":t")
					if filename == "" then
						filename = "[No Name]"
					end

					local ext = vim.fn.fnamemodify(filename, ":e")
					local icon, icon_color = devicons.get_icon_color(filename, ext, { default = true })
					local modified = vim.bo[props.buf].modified

					local mode_bg = "#313244"
					local mode_fg = "#cdd6f4"

					return {
						{
							" " .. mode_text .. " ",
							guibg = mode_bg,
							guifg = mode_fg,
							gui = "bold",
						},
						" ",
						icon and { icon .. " ", guifg = icon_color } or "",
						{ filename .. " ", gui = modified and "bold,italic" or "bold" },
					}
				end,
			})
		end,
	},
}
