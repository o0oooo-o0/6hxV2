-- VISUALS.LUA - Kill effects, sounds

local Config = _G.SixHX_Config

local function createKillEffect(position)
    if Config.State.panicMode or not Config.Toggles.KillEffects or not Config.Toggles.KillEffects.Value then return end
    local duration = Config.Options.LightningDuration.Value
    local color = Config.Options.LightningColor.Value
    for i = 1, 5 do
        local beam = Instance.new("Part")
        beam.Anchored = true
        beam.CanCollide = false
        beam.Material = Enum.Material.Neon
        beam.Color = color
        beam.Size = Vector3.new(0.2, 20, 0.2)
        beam.CFrame = CFrame.new(position + Vector3.new(math.random(-3, 3), 10, math.random(-3, 3)))
        beam.Parent = workspace
        table.insert(Config.State.killEffectParts, beam)
        Config.Services.TweenService:Create(beam, TweenInfo.new(duration), {Transparency = 1}):Play()
        Config.Services.Debris:AddItem(beam, duration)
    end
end

local function checkForKills()
    if Config.State.panicMode then return end
    
    for _, player in ipairs(Config.Services.Players:GetPlayers()) do
        if player ~= Config.LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local currentHealth = humanoid.Health
                local lastHealth = Config.State.lastKnownHealths[player]
                
                if lastHealth and currentHealth <= 0 and lastHealth > 0 then
                    if Config.Toggles.KillSound and Config.Toggles.KillSound.Value then
                        Config.playSound(Config.Options.KillSoundID.Value, Config.Options.KillSoundVolume.Value, 1)
                    end
                    
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        createKillEffect(hrp.Position)
                    end
                end
                
                Config.State.lastKnownHealths[player] = currentHealth
            end
        end
    end
end

return {
    createKillEffect = createKillEffect,
    checkForKills = checkForKills,
}