vim.pack.add({
	"https://github.com/rmagatti/auto-session",
})
require("auto-session").setup({
	auto_restore_enabled = true,
	auto_save_enabled = true,
})
require("mini.bufremove").delete(0, false)
