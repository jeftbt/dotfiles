-- Hardware Acceleration & Performance
hl.env("NVD_BACKEND", "direct")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("__GL_VRR_ALLOWED", "1")

-- Application & GUI Compatibility
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine")

-- Default Applications
hl.env("EDITOR", "helix")
hl.env("VISUAL", "helix")
hl.env("BROWSER", "zen-browser")
hl.env("TERMINAL", "alacritty")
