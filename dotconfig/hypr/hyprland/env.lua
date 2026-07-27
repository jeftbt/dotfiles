-- Environment Variables & NVIDIA Setup
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
-- hl.env("GBM_BACKEND", "nvidia-drm") -- Hyprland Wiki recommendation: remove to prevent crashes on modern NVIDIA
hl.env("NVD_BACKEND", "direct")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto") -- Wayland hint for Electron apps (Obsidian, VS Code, etc.)
hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine") -- Hyprland Qt6 theme engine integration

-- Default Applications
hl.env("EDITOR", "helix")
hl.env("VISUAL", "helix")
hl.env("BROWSER", "zen-browser")
hl.env("TERMINAL", "alacritty")
