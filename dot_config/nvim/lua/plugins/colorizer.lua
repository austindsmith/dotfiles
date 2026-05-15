
-- lua/plugins/colorizer.lua
return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    filetypes = { "*" },
    user_default_options = {
      names = false,         -- "red", "blue", etc.
      RGB = true, RRGGBB = true, RRGGBBAA = true,
      AARRGGBB = true, rgb_fn = true, hsl_fn = true,
      css = true, css_fn = true, tailwind = false,
      mode = "background",   -- or "virtualtext" to show a colored block next to the code
      virtualtext = "■",
    },
  },
}
