-- ============================================================================
-- 1. Sistem ve XWayland Düzeltmeleri
-- ============================================================================
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
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
	no_initial_focus = true,
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

-- ============================================================================
-- 2. Medya & Özel Çalışma Alanları
-- ============================================================================
hl.window_rule({
	name = "spotify-on-special-workspace",
	match = { class = "^[Ss]potify$" },
	workspace = "special:spotify",
})

hl.window_rule({
	name = "satty-floating",
	match = { class = ".*[Ss]atty.*" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "picture-in-picture",
	match = {
		title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$",
	},
	float = true,
	pin = true,
	keep_aspect_ratio = true,
	size = { "28%", "28%" },
	move = { "100%-w-20", "100%-h-20" },
})

-- ============================================================================
-- 3. Smart Gaps (Tek Pencere Varken Boşlukları & Kenarlıkları Kaldır)
-- ============================================================================
hl.workspace_rule({
	workspace = "w[tv1]",
	gaps_in = 0,
	gaps_out = 0,
	no_border = true,
	no_rounding = true,
})

hl.workspace_rule({
	workspace = "f[1]",
	gaps_in = 0,
	gaps_out = 0,
	no_border = true,
	no_rounding = true,
})

-- ============================================================================
-- 4. Oyun & Steam Kuralları
-- ============================================================================
local gamingApps = "^(steam_app.*|gamescope)$"
local gamingWorkspace = "name:gaming"

hl.window_rule({ match = { content = "game" }, workspace = gamingWorkspace })
hl.window_rule({ match = { xdg_tag = "^(.*game.*)$" }, workspace = gamingWorkspace, fullscreen_state = 2, content = "game", sync_fullscreen = true })
hl.window_rule({ match = { class = gamingApps }, workspace = gamingWorkspace })

-- Steam Arayüz Pencereleri
hl.window_rule({ match = { class = "^(steam)$", title = "^(Friends List|Steam Guard - Computer Authorization)$" }, float = true })
hl.window_rule({ match = { class = "^(steam)$", title = "^(Launching\\.{3})$" }, float = true, center = true, workspace = gamingWorkspace })

-- Oyun Pencere Optimizasyonları (Düzeltilen /home/ regex'i ile)
hl.window_rule({
	match = {
		class = gamingApps,
		title = "^(.+)$",
		initial_title = "negative:^(.*[\\/]home[\\/].*)$",
	},
	content = "game",
	decorate = false,
	fullscreen_state = 2,
	size = { "monitor_w", "monitor_h" },
	sync_fullscreen = true,
})

hl.window_rule({
	match = {
		class = "^(steam_app.*)$",
		initial_title = "^$",
	},
	center = true,
	float = true,
	fullscreen = false,
	fullscreen_state = 0,
	workspace = gamingWorkspace,
})

-- ============================================================================
-- 5. Float Sistem Araçları ve Yardımcı Uygulamalar
-- ============================================================================
local floatApps = {
	-- Görünüm & Sistem Ayarları
	{ class = "^(kvantummanager|qt[56]ct|nwg-look|hyprpolkitagent)$" },
	-- Ses & Ağ Yöneticileri
	{ class = "^(org.pulseaudio.pavucontrol|pavucontrol|blueman-manager|nm-applet|nm-connection-editor)$" },
	-- WINE / Uyumluluk Araçları
	{ title = "^(Winetricks.*|Protontricks.*)$" },
	-- Arşiv Yöneticileri & Resim Görüntüleyiciler
	{ class = "^(org.gnome.FileRoller|file-roller|ark|xarchiver|imv|viewnior|feh|swayimg)$" },
	-- Hesap Makinesi & Hızlı Araçlar
	{ class = "^(org.gnome.Calculator|kcalc|galculator)$" },
}
for _, m in ipairs(floatApps) do hl.window_rule({ match = m, float = true }) end

-- ============================================================================
-- 6. Diyaloglar ve Modal Pencereler
-- ============================================================================
local modalMatches = {
	{ title = "^(Open|Authentication Required|Add Folder to Workspace|Choose Files|Save As|Confirm to replace files|File Operation Progress)$" },
	{ initial_title = "^(Open File|Save File)$" },
	{ class = "^([Xx]dg-desktop-portal-gtk|[Xx]dg-desktop-portal-hyprland)$" },
	{ title = "^(File Upload|Choose wallpaper|Library)(.*)$" },
	{ class = "^(.*dialog.*)$" },
	{ title = "^(.*dialog.*)$" },
	{ class = "^(hyprland-share-picker)$" },
}
for _, m in ipairs(modalMatches) do hl.window_rule({ match = m, float = true }) end
