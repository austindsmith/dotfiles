-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- leaders before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Import UI settings
require("config.ui")

-- Import custom configs
require("config.keymaps")

-- Imports vim-options under the lua directory
require("config.vim-options")

-- Imports terminal toggle under the lua directory
require("terminal-toggle")

-- Load plugins + options
require("lazy").setup("plugins", {
	checker = { enabled = true },
})

-- vim.cmd([[autocmd VimEnter * Neotree]])
