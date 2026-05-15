return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,         -- smarter rules with Treesitter
    map_cr = true,           -- hit <CR> inside pairs to newline+indent
    fast_wrap = {},
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
    -- If you use nvim-cmp, also add:
    -- local cmp_ap = require("nvim-autopairs.completion.cmp")
    -- local cmp = require("cmp")
    -- cmp.event:on("confirm_done", cmp_ap.on_confirm_done())
  end,
}
