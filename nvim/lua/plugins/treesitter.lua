return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Treesitter
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "javascript" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }


