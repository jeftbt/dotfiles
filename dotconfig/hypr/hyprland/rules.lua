hl.window_rule({
	-- Suppress maximize requests from all apps
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "spotify-on-special-workspace",
	match = {
		class = "^[Ss]potify$",
	},
	workspace = "special:spotify",
})

hl.window_rule({
	name = "fix-xwayland-video-bridge",
	match = {
		class = "xwaylandvideobridge",
	},
	no_focus = true,
	no_initial_focus = true,
	opacity = 0.0,
})

hl.window_rule({
	name = "satty-floating",
	match = {
		class = ".*[Ss]atty.*",
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = "picture-in-picture",
	match = {
		title = "^(Picture-in-Picture)$",
	},
	float = true,
	pin = true,
})

hl.window_rule({
	name = "system-floating-tools",
	match = {
		class = "^(pavucontrol|blueman-manager|nm-connection-editor)$",
	},
	float = true,
})

-- Smart gaps / Single application fullscreen rules (Tek uygulama varken tam ekran / boşluksuz yapma)
hl.workspace_rule({
	workspace = "w[tv1]",
	gaps_in = 0,
	gaps_out = 0,
	border_size = 0,
	no_rounding = true,
})

hl.workspace_rule({
	workspace = "f[1]",
	gaps_in = 0,
	gaps_out = 0,
	border_size = 0,
	no_rounding = true,
})


