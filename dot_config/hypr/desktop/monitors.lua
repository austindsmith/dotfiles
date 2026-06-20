-- Monitors

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@144",
    position = "0x0",
    scale = "1",
})

hl.monitor({
    output = "DP-1",
    mode = "1920x1080@144",
    position = "1920x0",
    scale = "1",
})

hl.monitor({
    output = "DP-3",
    mode = "1920x1080@144",
    position = "1000x-1080",
    scale = "1",
})

-- rightmost, 270° clockwise
hl.monitor({
    output = "DP-2",
    mode = "1920x1080@144",
    position = "3840x-550",
    scale = "1",
    transform = 3,
})
