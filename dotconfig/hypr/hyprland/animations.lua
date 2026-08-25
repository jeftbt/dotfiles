-- ============================================================================
-- Hyprland Animations Configuration
-- ============================================================================
-- Ana Aç/Kapa Anahtarı: İstediğiniz zaman 'false' / 'true' yapabilirsiniz.
hl.config({
	animations = {
		enabled = false,
	},
})

-- Bezier İvme Eğrileri
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })

-- Pencereler
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "default", style = "popin 80%" })

-- Kenarlıklar ve Opaklık
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "default" })

-- Çalışma Alanı Geçişleri
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.5, bezier = "easeOutCirc", style = "slidefade 20%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3.5, bezier = "easeOutCirc", style = "slidefadevert 20%" })
