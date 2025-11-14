local ns = vim.api.nvim_create_namespace("inline_mode_indicator")

local mode_map = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	V = "V-LINE",
	["\22"] = "V-BLOCK",
	c = "CMD",
	R = "REPLACE",
}

local function show_mode_inline()
	-- clear old indicator
	vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

	-- current mode text
	local mode = vim.api.nvim_get_mode().mode
	local text = mode_map[mode] or mode

	-- current cursor row (0-based)
	local row = vim.api.nvim_win_get_cursor(0)[1] - 1

	-- add virtual text at end of line
	vim.api.nvim_buf_set_extmark(0, ns, row, -1, {
		virt_text = { { "  " .. text .. " ", "CursorLineNr" } }, -- change highlight if you want
		virt_text_pos = "eol",
	})
end

vim.api.nvim_create_autocmd({ "ModeChanged", "CursorMoved", "CursorMovedI" }, {
	callback = show_mode_inline,
})
