-- Animations Setup (Curves & Leaf animations)
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })

-- Pencereler
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = false })

-- Kenarlıklar
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })

-- Kararma / Fade Efektleri (Kapanış ve kararma animasyonları kapatıldı)
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fadeOut", enabled = false })
hl.animation({ leaf = "fadeDim", enabled = false })

-- Çalışma Alanı Geçişleri (Kararma olmadan doğrudan net kayma: slide)
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.5, bezier = "easeOutCirc", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3.5, bezier = "easeOutCirc", style = "slidevert" })
