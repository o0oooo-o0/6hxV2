-- INIT.LUA - Initialize and connect all modules

-- Get modules
local Config = _G.SixHX_Config
local Combat = _G.SixHX_Combat
local Player = _G.SixHX_Player
local Features = _G.SixHX_Features
local ESP = _G.SixHX_ESP
local Visuals = _G.SixHX_Visuals
local AntiAim = _G.SixHX_AntiAim

-- Initialize visuals
ESP.makeVisuals()
ESP.setupC4Tracking()

-- Setup backpack listener
Features.setupBackpackListener()

-- Toggle callbacks
Config.Toggles.Fly:OnChanged(function(Value)
    Player.setupFly()
end)

Config.Toggles.Noclip:OnChanged(function(Value)
    Player.setupNoclip(Value)
end)

Config.Toggles.BunnyHop:OnChanged(function(Value)
    Player.setupBunnyHop(Value)
end)

Config.Toggles.InfiniteJump:OnChanged(function(Value)
    Player.setupInfiniteJump(Value)
end)

Config.Toggles.GunMods:OnChanged(function(Value)
    if Value then
        Features.scanBackpack()
        Config.Library:Notify({
            Title = "Gun Mods",
            Description = "Enabled!",
            Time = 3,
        })
    end
end)

Config.Toggles.HitboxExpander:OnChanged(function(Value)
    Features.updateHitboxes(Value)
end)

Config.Options.HitboxSize:OnChanged(function()
    if Config.Toggles.HitboxExpander.Value then
        Features.updateHitboxes(true)
    end
end)

Config.Toggles.AnimToggle:OnChanged(function(Value)
    if not Value then
        AntiAim.ClearTracks()
    else
        AntiAim.LoadAnims(Config.LocalPlayer.Character)
    end
end)

Config.Toggles.PanicMode:OnChanged(function(Value)
    Config.State.panicMode = Value
    Config.Library:Toggle()
    
    if Value then
        Config.Drawings.fovCircle.Visible = false
        Config.Drawings.targetLine.Visible = false
        for i = 1, 4 do
            Config.Drawings.hitmarkerLines[i].Visible = false
        end
    else
        Config.Drawings.fovCircle.Visible = Config.Toggles.ShowFOV.Value and Config.Toggles.Enabled.Value
    end
end)

-- Player events
Config.Services.Players.PlayerAdded:Connect(function(player)
    if Config.Toggles.HitboxExpander and Config.Toggles.HitboxExpander.Value then
        player.CharacterAdded:Connect(function()
            task.wait(0.1)
            Features.updateHitboxes(true)
        end)
    end
    
    player.CharacterAdded:Connect(function()
        task.wait(0.1)
        ESP.makeEsp(player)
    end)
end)

Config.Services.Players.PlayerRemoving:Connect(function(player)
    ESP.removeEsp(player)
    Config.State.lastKnownHealths[player] = nil
end)

-- Character added
Config.LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    
    -- Re-apply FOV
    Config.Drawings.fovCircle.Radius = Config.Options.FOV.Value
    if not Config.State.panicMode then
        Config.Drawings.fovCircle.Visible = Config.Toggles.ShowFOV.Value and Config.Toggles.Enabled.Value
    end
    
    if Config.Toggles.AnimToggle and Config.Toggles.AnimToggle.Value then
        AntiAim.LoadAnims(char)
    end
    
    if Config.Toggles.GunMods and Config.Toggles.GunMods.Value then
        task.wait(1)
        Features.scanBackpack()
    end
    
    char.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            Features.applyGunChams(child)
        end
    end)
    
    -- Make ESP for all players
    for _, player in ipairs(Config.Services.Players:GetPlayers()) do
        if player ~= Config.LocalPlayer then
            ESP.makeEsp(player)
        end
    end
end)

-- Initial ESP
for _, player in ipairs(Config.Services.Players:GetPlayers()) do
    if player ~= Config.LocalPlayer and player.Character then
        ESP.makeEsp(player)
    end
end

-- Main Heartbeat loop
Config.Services.RunService.Heartbeat:Connect(function(deltaTime)
    if Config.State.panicMode then return end
    
    -- Update gun
    Config.State.currentGun = Combat.getGun()
    if Config.State.currentGun ~= Config.State.lastGun then
        Config.State.lastAutoShoot = 0
        Config.State.lastGun = Config.State.currentGun
    end
    
    -- Auto shoot
    Combat.autoShoot()
    
    -- Check for kills
    Visuals.checkForKills()
    
    -- Update walkspeed
    Player.updateWalkSpeed()
    
    -- Update gun mods
    Features.updateGunMods(deltaTime)
end)

-- RenderStepped loop
Config.Services.RunService.RenderStepped:Connect(function()
    if Config.State.panicMode then return end
    
    -- Update animations
    AntiAim.updateAnims()
    
    -- Update jitter
    AntiAim.updateJitter()
    
    -- Update rainbow
    AntiAim.updateRainbow()
end)

-- PreRender loop
Config.Services.RunService.PreRender:Connect(function()
    if Config.State.panicMode then return end
    
    local aimPos = Config.Services.UserInputService:GetMouseLocation()
    local camera = workspace.CurrentCamera
    
    if camera then
        local lastInput = Config.Services.UserInputService:GetLastInputType()
        local locked = (lastInput == Enum.UserInputType.Touch) or (Config.Services.UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter)
        if locked then
            local viewportSize = camera.ViewportSize
            aimPos = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
        end
    end
    
    -- Update FOV circle
    Config.Drawings.fovCircle.Position = aimPos
    Config.Drawings.fovCircle.Radius = Config.Options.FOV.Value
    Config.Drawings.fovCircle.Visible = Config.Toggles.ShowFOV.Value and Config.Toggles.Enabled.Value
    
    -- Update target line
    if Config.Toggles.ShowTargetLine.Value and Config.Toggles.Enabled.Value then
        local target, targetPos = Combat.getClosest()
        if target and targetPos and camera then
            local screenPos, onScreen = camera:WorldToViewportPoint(targetPos)
            if onScreen then
                Config.Drawings.targetLine.From = aimPos
                Config.Drawings.targetLine.To = Vector2.new(screenPos.X, screenPos.Y)
                Config.Drawings.targetLine.Visible = true
            else
                Config.Drawings.targetLine.Visible = false
            end
        else
            Config.Drawings.targetLine.Visible = false
        end
    else
        Config.Drawings.targetLine.Visible = false
    end
    
    -- Update hitmarker fade
    if tick() - Config.State.hitmarkerLastShow > 0.3 then
        for i = 1, 4 do
            Config.Drawings.hitmarkerLines[i].Visible = false
        end
    end
    
    -- Update ESP
    ESP.updateEsp()
    ESP.updateC4Esp()
end)

-- Unload handler
Config.Library:OnUnload(function()
    Config.Drawings.fovCircle:Remove()
    Config.Drawings.targetLine:Remove()
    for i = 1, 4 do
        Config.Drawings.hitmarkerLines[i]:Remove()
    end
    
    AntiAim.ClearTracks()
    
    if Config.State.noclipConnection then Config.State.noclipConnection:Disconnect() end
    if Config.State.infJumpConnection then Config.State.infJumpConnection:Disconnect() end
    if Config.State.bunnyHopConnection then Config.State.bunnyHopConnection:Disconnect() end
    if Config.State.flyConnection then Config.State.flyConnection:Disconnect() end
    if Config.State.flyBodyVelocity then Config.State.flyBodyVelocity:Destroy() end
    if Config.State.flyBodyGyro then Config.State.flyBodyGyro:Destroy() end
    
    for _, part in ipairs(Config.State.tracerParts) do
        if part then part:Destroy() end
    end
    
    for player, esp in pairs(Config.State.espCache) do
        ESP.removeEsp(player)
    end
    
    if Config.State.visuals.container then
        Config.State.visuals.container:Destroy()
    end
end)

-- Notify success
Config.Library:Notify({
    Title = "6hx v2 Modular",
    Description = "Loaded successfully!",
    Time = 4,
})

Config.playNotificationSound()