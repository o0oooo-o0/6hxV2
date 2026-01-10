-- 6HX V2 MODULAR LOADER
-- https://github.com/o0oooo-o0/6hxV2

local REPO = "https://raw.githubusercontent.com/o0oooo-o0/6hxV2/"

print("[6HX V2] Loading modules...")

-- Load config first and store globally
_G.SixHX_Config = loadstring(game:HttpGet(REPO .. "modules/config.lua"))()
print("[6HX] ✓ Config")

-- Load UI
local UI = loadstring(game:HttpGet(REPO .. "modules/ui.lua"))()
print("[6HX] ✓ UI")

-- Load Combat
_G.SixHX_Combat = loadstring(game:HttpGet(REPO .. "modules/combat.lua"))()
print("[6HX] ✓ Combat")

-- Load Player
_G.SixHX_Player = loadstring(game:HttpGet(REPO .. "modules/player.lua"))()
print("[6HX] ✓ Player")

-- Load Features
_G.SixHX_Features = loadstring(game:HttpGet(REPO .. "modules/features.lua"))()
print("[6HX] ✓ Features")

-- Load ESP
_G.SixHX_ESP = loadstring(game:HttpGet(REPO .. "modules/esp.lua"))()
print("[6HX] ✓ ESP")

-- Load Visuals
_G.SixHX_Visuals = loadstring(game:HttpGet(REPO .. "modules/visuals.lua"))()
print("[6HX] ✓ Visuals")

-- Load AntiAim
_G.SixHX_AntiAim = loadstring(game:HttpGet(REPO .. "modules/antiaim.lua"))()
print("[6HX] ✓ AntiAim")

-- Initialize everything (connects all modules)
loadstring(game:HttpGet(REPO .. "modules/init.lua"))()
print("[6HX V2] All modules loaded!")