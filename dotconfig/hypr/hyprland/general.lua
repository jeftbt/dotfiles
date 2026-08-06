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
		active_opacity = 0.90,
		inactive_opacity = 0.80,
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 2,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})
