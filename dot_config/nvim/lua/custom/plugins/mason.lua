vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = false,
	ensure_installed = { "lua_ls", "pyright" },
})
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"pyright",
		"selene",
		"stylua",
		"ruff",
		"markdownlint-cli2",
		"yamllint",
		"tflint",
		"terraform-ls",
		"hadolint",
		"shellcheck",
		"shfmt",
		"yaml-language-server",
		"taplo",
		"ansible-lint",
		"dockerfile-language-server",
	},
})
