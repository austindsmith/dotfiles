local c = require("themes.polycarbonate-ayu-dark")
local d = require("device")

hl.config({
    general = {
        gaps_in = d.gaps_in,
        gaps_out = d.gaps_out,
        border_size = 2,
        col = {
            active_border = { colors = { c.rgba(c.accent, c.alpha.strong), c.rgba(c.purple, c.alpha.strong) }, angle = 45 },
            inactive_border = c.rgba(c.slate, c.alpha.inactive),
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
})
