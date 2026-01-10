-- ANTIAIM.LUA - Animations and Jitter

local Config = _G.SixHX_Config

local function ClearTracks()
    if Config.State.track1 then Config.State.track1:Stop() Config.State.track1:Destroy() Config.State.track1 = nil end
    if Config.State.track2 then Config.State.track2:Stop() Config.State.track2:Destroy() Config.State.track2 = nil end
end

local function LoadAnims(character)
    ClearTracks()
    if not character then return end
    
    local humanoid = character:WaitForChild("Humanoid", 5)
    local animator = humanoid and (humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid))
    
    if animator then
        local a1, a2 = Instance.new("Animation"), Instance.new("Animation")
        a1.AnimationId, a2.AnimationId = Config.State.ANIM_1, Config.State.ANIM_2
        
        Config.State.track1 = animator:LoadAnimation(a1)
        Config.State.track2 = animator:LoadAnimation(a2)
        
        Config.State.track1.Looped = true
        Config.State.track2.Looped = true
    end
end

local function updateAnims()
    if Config.State.panicMode then return end
    
    local char = Config.LocalPlayer.Character
    if char then
        if Config.Toggles.AnimToggle and Config.Toggles.AnimToggle.Value and Config.State.track1 and Config.State.track2 then
            if Config.Toggles.AnimSpam.Value then
                Config.State.animSpamCounter = Config.State.animSpamCounter + 1
                if Config.State.animSpamCounter >= Config.Options.AnimSpamSpeed.Value then
                    if Config.State.track1.IsPlaying then
                        Config.State.track1:Stop()
                        Config.State.track2:Stop()
                    else
                        Config.State.track1:Play(0, 9999, 1)
                        Config.State.track2:Play(0, 9999, 1)
                    end
                    Config.State.animSpamCounter = 0
                end
            else
                if not Config.State.track1.IsPlaying then Config.State.track1:Play(0, 9999, 1) end
                if not Config.State.track2.IsPlaying then Config.State.track2:Play(0, 9999, 1) end
            end
            
            Config.State.track1.Priority = Enum.AnimationPriority.Action3
            Config.State.track1:AdjustWeight(9999, 0)
            Config.State.track2.Priority = Enum.AnimationPriority.Action4
            Config.State.track2:AdjustWeight(9999, 0)
        end
    end
end

local function updateJitter()
    if Config.State.panicMode then return end
    
    local char = Config.LocalPlayer.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if Config.Toggles.JitterToggle and Config.Toggles.JitterToggle.Value and root then
            local vel = root.Velocity.Magnitude
            local freq = (vel > 2) and 1 or 8
            Config.State.frameCounter = Config.State.frameCounter + 1
            
            if Config.State.frameCounter >= freq then
                local rad = math.rad(math.random(-Config.Options.JitterAngle.Value, Config.Options.JitterAngle.Value))
                root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, rad, 0)
                Config.State.frameCounter = 0
            end
        end
    end
end

local function updateRainbow()
    if Config.Toggles.TracerRainbow.Value then
        Config.State.rainbowHue = (Config.State.rainbowHue + 0.01) % 1
    end
end

return {
    ClearTracks = ClearTracks,
    LoadAnims = LoadAnims,
    updateAnims = updateAnims,
    updateJitter = updateJitter,
    updateRainbow = updateRainbow,
}