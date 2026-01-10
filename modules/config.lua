-- CONFIG.LUA - Global configuration and services

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

Library.ShowToggleFrameInKeybinds = true

-- Services
local Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    UserInputService = game:GetService("UserInputService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    TweenService = game:GetService("TweenService"),
    CoreGui = game:GetService("CoreGui"),
    Teams = game:GetService("Teams"),
    Debris = game:GetService("Debris"),
    SoundService = game:GetService("SoundService"),
}

local LocalPlayer = Services.Players.LocalPlayer

-- Teams
local Teams = {
    Guards = Services.Teams:FindFirstChild("Guards"),
    Inmates = Services.Teams:FindFirstChild("Inmates"),
    Criminals = Services.Teams:FindFirstChild("Criminals"),
}

-- Raycast params
local wallParams = RaycastParams.new()
wallParams.FilterType = Enum.RaycastFilterType.Exclude
wallParams.IgnoreWater = true
wallParams.RespectCanCollide = false
wallParams.CollisionGroup = "ClientBullet"

-- State
local State = {
    -- Silent Aim
    currentGun = nil,
    rng = Random.new(),
    lastShotTime = 0,
    lastShotResult = false,
    shotCooldown = 0.15,
    currentTarget = nil,
    targetSwitchTime = 0,
    currentStickiness = 0,
    lastAutoShoot = 0,
    cachedBulletsLabel = nil,
    targetAcquiredTime = 0,
    lastAutoTarget = nil,
    lastGun = nil,
    hooked = false,
    origCastRay = nil,
    
    -- General
    panicMode = false,
    
    -- Animations
    ANIM_1 = "rbxassetid://481089053",
    ANIM_2 = "rbxassetid://176036458",
    track1 = nil,
    track2 = nil,
    frameCounter = 0,
    animSpamCounter = 0,
    
    -- Connections
    noclipConnection = nil,
    infJumpConnection = nil,
    bunnyHopConnection = nil,
    flyConnection = nil,
    flyBodyVelocity = nil,
    flyBodyGyro = nil,
    arrestAuraConnection = nil,
    killAuraConnection = nil,
    arrestTarget = nil,
    killTarget = nil,
    
    -- Visuals
    tracerParts = {},
    rainbowHue = 0,
    modifiedTools = {},
    lastGunModUpdate = 0,
    
    -- ESP
    visuals = {container = nil},
    espCache = {},
    c4espCache = {},
    trackedC4s = {},
    playerCache = {},
    lastPlayerCacheUpdate = 0,
    lastEspUpdate = 0,
    ESP_UPDATE_INTERVAL = 0.033,
    
    -- Kill tracking
    lastKnownHealths = {},
    killEffectParts = {},
}

-- Drawing objects
local Drawings = {
    fovCircle = Drawing.new("Circle"),
    targetLine = Drawing.new("Line"),
    hitmarkerLines = {},
}

-- FOV Circle
Drawings.fovCircle.Color = Color3.fromRGB(255, 0, 0)
Drawings.fovCircle.Transparency = 0.8
Drawings.fovCircle.Filled = false
Drawings.fovCircle.NumSides = 64
Drawings.fovCircle.Thickness = 1
Drawings.fovCircle.Visible = false

-- Target Line
Drawings.targetLine.Color = Color3.fromRGB(0, 255, 0)
Drawings.targetLine.Thickness = 1
Drawings.targetLine.Transparency = 0.5
Drawings.targetLine.Visible = false

-- Hitmarker
for i = 1, 4 do
    Drawings.hitmarkerLines[i] = Drawing.new("Line")
    Drawings.hitmarkerLines[i].Color = Color3.fromRGB(255, 255, 255)
    Drawings.hitmarkerLines[i].Thickness = 2
    Drawings.hitmarkerLines[i].Visible = false
end

State.hitmarkerLastShow = 0

-- Helper functions
local function playNotificationSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://3398620867"
    sound.Volume = 0.5
    sound.Parent = Services.SoundService
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

local function playSound(soundId, volume, pitch)
    if soundId and soundId ~= "0" and soundId ~= "" then
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. soundId
        sound.Volume = volume or 0.5
        sound.PlaybackSpeed = pitch or 1
        sound.Parent = Services.SoundService
        sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end
end

-- Export
return {
    Library = Library,
    ThemeManager = ThemeManager,
    SaveManager = SaveManager,
    Options = Library.Options,
    Toggles = Library.Toggles,
    Services = Services,
    LocalPlayer = LocalPlayer,
    Teams = Teams,
    wallParams = wallParams,
    State = State,
    Drawings = Drawings,
    playNotificationSound = playNotificationSound,
    playSound = playSound,
}
