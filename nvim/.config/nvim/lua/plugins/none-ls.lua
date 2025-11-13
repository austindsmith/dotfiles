return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,

				-- YAML
				null_ls.builtins.formatting.yamlfmt,

				-- Ansible diagnostics
				null_ls.builtins.diagnostics.ansiblelint,

				-- NEW: Prettier for CSS/JS/TS/etc
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"css",
						"scss",
						"html",
						"json",
						"yaml",
						"markdown",
					},
				}),
			},
		})

		-- Format current buffer
		vim.keymap.set("n", "<leader>gf", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Format file" })

		-- OPTIONAL: auto-format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				vim.lsp.buf.format({ bufnr = args.buf })
			end,
		})
	end,
}
