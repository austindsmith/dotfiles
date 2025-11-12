return {
	"uZer/pywal16.nvim",
  lazy = false,
  priority = 1000,
	config = function()
    vim.opt.termguicolors = true
		vim.cmd.colorscheme("pywal16")
	end,
}
