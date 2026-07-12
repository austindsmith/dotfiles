local M = {}

M.black = "000000"
M.white = "ffffff"
M.blue = "5ac1fe"
M.blueAlt = "59c2ff"
M.cyan = "39bae5"
M.aqua = "95e5cb"
M.aquaAlt = "95e6cb"
M.green = "aad84c"
M.greenAlt = "a9d94b"
M.mint = "77dd77"
M.gold = "feb454"
M.goldAlt = "ffb353"
M.orange = "fe8f40"
M.orangeAlt = "ff8f3f"
M.sand = "e5b572"
M.peach = "f29668"
M.red = "ef7177"
M.purple = "d2a6fe"
M.purpleAlt = "d2a6ff"
M.bronze = "997700"
M.text = "bfbdb6"
M.textMuted = "a6a5a0"
M.textDim = "8c8b88"
M.sage = "628b80"
M.slate = "5a728b"
M.steel = "5577aa"
M.gray = "555555"
M.charcoal = "333333"
M.selectionBase = "66aadd"
M.positiveBase = "00ff00"
M.negativeBase = "ff0000"
M.cautionBase = "ffff00"

M.accent = M.blue
M.accentWarm = M.orange
M.highlight = M.bronze
M.muted = M.gray

M.alpha = {
    opaque = "ff",
    strong = "ee",
    glass = "dd",
    status = "bb",
    inactive = "aa",
    shadow = "99",
    selection = "88",
    hover = "44",
    tint = "3d",
    overlay = "33",
    subtle = "19",
    faint = "11",
    none = "00",
}

function M.rgba(hex, alpha)
    return "rgba(" .. hex .. (alpha or "ff") .. ")"
end

function M.rgb(hex)
    return "rgb(" .. hex .. ")"
end

return M
