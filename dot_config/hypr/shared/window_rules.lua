-- Window rules
-- App placement
--swindowrulev2 = workspace 2, class:^(vesktop)$
--swindowrulev2 = float, class:^(vesktop)$, title:^(Picture-in-Picture)$
--swindowrulev2 = workspace 6, class:^(obsidian)$

-- Ignore maximize requests from apps. You'll probably like this.

hl.window_rule({
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    match = {
        class = "^$",
        title = "^$",
        xwayland = 1,
        float = 1,
        fullscreen = 0,
        pin = 0,
    },
    no_focus = true,
})

hl.window_rule({
    match = {
        class = "vesktop",
    },
    workspace = "6",
})

hl.window_rule({
    match = {
        class = "virt-manager",
    },
    workspace = "",
})

hl.window_rule({
    match = {
        class = "godot",
    },
    workspace = "8",
})

hl.window_rule({
    match = {
        class = "vesktop",
        initial_title = "Discord Popout",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "thunar",
    },
    float = true,
    size = "912 612",
})

--windowrule = float on, size 912 612 , match:class obsidian

hl.window_rule({
    name = "move-kitty",
    match = {
        class = "kitty",
    },
    animation = "slide",
    float = true,
})
