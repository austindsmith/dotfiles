vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

local function should_skip_format(bufnr)
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	return bufname:match("externalsecret") or bufname:match("configmap") or bufname:match("config%-template")
end

require("conform").setup({
	log_level = vim.log.levels.DEBUG,
	formatters = {
		mdformat = {
			command = vim.fn.expand("~/.local.bin/mdformat"),
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		markdown = { "mdformat" },
		terraform = { "terraform_fmt" },
		sh = { "shfmt" },
		json = { "jq" },
	},
	format_on_save = function(bufnr)
		if should_skip_format(bufnr) then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})

vim.keymap.set({ "n", "v" }, "<leader>f", function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if should_skip_format(bufnr) then
		return
	end
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
