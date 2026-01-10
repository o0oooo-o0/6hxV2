-- FEATURES.LUA - Gun mods, hitbox, chams

local Config = _G.SixHX_Config

local function modifyGun(tool)
    if not tool or not tool:IsA("Tool") then return end
    tool:SetAttribute("FireRate", 0.000001)
    tool:SetAttribute("AutoFire", true)
    tool:SetAttribute("SpreadRadius", 0.000001)
    tool:SetAttribute("Range", 22222)
end

local function isTargetGun(name)
    local selectedGuns = Config.Options.GunModsList.Value
    return selectedGuns[name] == true
end

local function scanBackpack()
    local backpack = Config.LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end
    
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and isTargetGun(tool.Name) then
            Config.State.modifiedTools[tool] = true
            modifyGun(tool)
        end
    end
end

local function updateHitboxes(enable)
    for _, player in ipairs(Config.Services.Players:GetPlayers()) do
        if player ~= Config.LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if enable then
                    hrp.Size = Vector3.new(Config.Options.HitboxSize.Value, Config.Options.HitboxSize.Value, Config.Options.HitboxSize.Value)
                    hrp.Transparency = 0.5
                    hrp.CanCollide = false
                else
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                    hrp.CanCollide = false
                end
            end
        end
    end
end

local function applyGunChams(tool)
    if not Config.Toggles.GunChams or not Config.Toggles.GunChams.Value then return end
    if not tool or not tool:IsA("Tool") then return end
    
    task.wait(0.05)
    for _, part in pairs(tool:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.Material = Enum.Material.ForceField
            part.Color = Config.Options.ChamsColor.Value
            part.Transparency = Config.Options.ChamsTransparency.Value
        end
    end
end

local function setupBackpackListener()
    local backpack = Config.LocalPlayer:WaitForChild("Backpack")
    
    backpack.ChildAdded:Connect(function(child)
        if Config.Toggles.GunMods and Config.Toggles.GunMods.Value and child:IsA("Tool") and isTargetGun(child.Name) then
            Config.State.modifiedTools[child] = true
            modifyGun(child)
        end
        
        if child:IsA("Tool") then
            applyGunChams(child)
        end
    end)
end

local function updateGunMods(deltaTime)
    if not Config.Toggles.GunMods or not Config.Toggles.GunMods.Value then return end
    
    Config.State.lastGunModUpdate = Config.State.lastGunModUpdate + deltaTime
    if Config.State.lastGunModUpdate >= 0.1 then
        Config.State.lastGunModUpdate = 0
        local backpack = Config.LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            for tool, _ in pairs(Config.State.modifiedTools) do
                if tool and tool.Parent == backpack then
                    modifyGun(tool)
                else
                    Config.State.modifiedTools[tool] = nil
                end
            end
        end
    end
end

return {
    modifyGun = modifyGun,
    scanBackpack = scanBackpack,
    updateHitboxes = updateHitboxes,
    applyGunChams = applyGunChams,
    setupBackpackListener = setupBackpackListener,
    updateGunMods = updateGunMods,
}