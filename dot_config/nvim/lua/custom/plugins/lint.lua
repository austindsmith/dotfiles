vim.pack.add({
	"https://github.com/mfussenegger/nvim-lint",
})

local lint = require("lint")

lint.linters.kubeconform = {
	name = "kubeconform",
	cmd = "kubeconform",
	stdin = true,
	args = { "-output", "text", "-summary=false", "-ignore-missing-schemas", "-" },
	stream = "stdout",
	ignore_exitcode = true,
	parser = function(output, bufnr)
		local diagnostics = {}
		for line in output:gmatch("[^\r\n]+") do
			local msg = line:match("^stdin%s*%-?%s*(.+)$")
			if msg then
				table.insert(diagnostics, {
					lnum = 0,
					col = 0,
					message = msg,
					severity = vim.diagnostic.severity.ERROR,
					source = "kubeconform",
					bufnr = bufnr,
				})
			end
		end
		return diagnostics
	end,
}

lint.linters_by_ft = {
	lua = { "selene" },
	python = { "ruff" },
	markdown = { "markdownlint-cli2" },
	yaml = { "yamllint" },
	terraform = { "tflint" },
	dockerfile = { "hadolint" },
	sh = { "shellcheck" },
}

local function is_k8s_manifest(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local text = table.concat(lines, "\n")
	return text:match("apiVersion:") and text:match("kind:")
end

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function(args)
		if not vim.bo.modifiable then
			return
		end
		if vim.bo.filetype == "yaml" and is_k8s_manifest(args.buf) then
			lint.try_lint("yamllint")
			lint.try_lint("kubeconform")
		else
			lint.try_lint()
		end
	end,
})
