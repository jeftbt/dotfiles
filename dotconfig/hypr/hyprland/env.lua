-- Environment Variables & NVIDIA Setup
hl.env("XCURSOR_THEME", "catppuccin-mocha-teal-cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-teal-cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("NVD_BACKEND", "direct")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("__GL_VRR_ALLOWED", "1")

-- Default Applications
hl.env("EDITOR", "nvim")
hl.env("VISUAL", "nvim")
hl.env("BROWSER", "zen-browser")
hl.env("TERMINAL", "ghostty")
