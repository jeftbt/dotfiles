-- Layer Rules (Blur for Waybar, Dunst, Hyprlauncher, Hyprshutdown)
hl.layer_rule({
	match = { namespace = "hyprlauncher" },
	blur = true,
})

hl.layer_rule({
	match = { namespace = "hyprshutdown" },
	blur = true,
})

hl.layer_rule({
	match = { namespace = "wlogout" },
	blur = true,
})

hl.layer_rule({
	match = { namespace = "waybar" },
	blur = true,
	ignore_alpha = 0.1,
})

hl.layer_rule({
	match = { namespace = "notifications" },
	blur = true,
	ignore_alpha = 0.5,
})

-- Window Rules
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




