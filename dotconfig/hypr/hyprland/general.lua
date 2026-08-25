-- Core System Configuration Table
hl.config({
    input = {
        kb_layout = "tr",
        kb_options = "altwin:swap_lalt_lwin",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
        },
    },

    general = {
        gaps_in = 4,
        gaps_out = 6,
        border_size = 1,
        col = {
            active_border = "rgb(45475a)",
            inactive_border = "rgb(0d0f12)",
        },
        layout = "dwindle",
        allow_tearing = false,
    },

    decoration = {
        rounding = 0,
        active_opacity = 1,
        inactive_opacity = 0.90,
    },

    dwindle = {
        preserve_split = true,
    },

    render = {
        direct_scanout = 2, -- Tam ekran oyunlarda compositor gecikmesini sıfırlar
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        enable_swallow = true,
        swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
        vrr = 2,
        render_unfocused_fps = 30,
    },

    xwayland = {
        force_zero_scaling = true,
    },
})
