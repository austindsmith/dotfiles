vim.pack.add({ { src = "https://github.com/Shatur/neovim-ayu", name = "ayu_dark" } })

require("ayu").setup({
    theme = "dark",
})
vim.cmd.colorscheme("ayu")
