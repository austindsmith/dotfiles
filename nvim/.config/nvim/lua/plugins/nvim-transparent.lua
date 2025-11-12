
-- lua/plugins/transparent.lua
return {
  "xiyaowong/nvim-transparent",
  lazy = false,
  opts = {
    extra_groups = {
      "NormalFloat","FloatBorder","SignColumn","EndOfBuffer",
      "LineNr","CursorLineNr","FoldColumn","StatusLine","StatusLineNC",
      "TelescopeNormal","TelescopeBorder","WhichKeyNormal",
      "Pmenu","PmenuSel","PmenuSbar","PmenuThumb",
      "NeoTreeNormal","NeoTreeNormalNC","WinSeparator",
    },
  },
  config = function(_, opts)
    require("transparent").setup(opts)
    require("transparent").clear_prefix("lualine") -- if you use lualine
  end,
}
