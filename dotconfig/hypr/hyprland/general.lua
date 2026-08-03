-- Core System Configuration Table
hl.config({
	input = {
		kb_layout = "tr",
		kb_variant = "",
		kb_model = "",
		kb_options = "altwin:swap_lalt_lwin",
		kb_rules = "",
		follow_mouse = 1,
		touchpad = {
			natural_scroll = true,
		},
		sensitivity = 0,
	},

	general = {
		gaps_in = 5,
		gaps_out = 7,
		border_size = 1,
		col = {
			active_border = "rgb(45475a)",
			inactive_border = "rgb(0d0f12)",
		},
		layout = "dwindle",
		allow_tearing = false,
	},

	decoration = {
		rounding = 8,
		active_opacity = 0.90,
		inactive_opacity = 0.80,
		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			vibrancy = 0.1696,
		},
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 2,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})
