
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local guardsTeam, inmatesTeam, criminalsTeam

for _, team in ipairs(game:GetService("Teams"):GetTeams()) do
    if team.Name == "Guards" then
        guardsTeam = team
    elseif team.Name == "Inmates" then
        inmatesTeam = team
    elseif team.Name == "Criminals" then
        criminalsTeam = team
    end
end

local cfg = {
    hitbox = {
        enabled = false,
        headEnabled = false,
        bodyEnabled = false,
        headSize = 20,
        bodySize = 20,
        transparency = 0.7,
        color = Color3.fromRGB(0, 200, 255),
        shape = "Sphere",
    },
    aimbot = {
        enabled = false,
        fov = 100,
        smoothness = 0.1,
        aimPart = "Head",
        prediction = 0,
        teamCheck = true,
        visibleCheck = false,
        hostileCheck = false,
        trespassCheck = false,
        taserBypassHostile = true,
        taserBypassTrespass = true,
        showFOV = true,
        fovColor = Color3.fromRGB(255, 255, 255),
        fovTransparency = 0.5,
        lockKey = Enum.KeyCode.E,
    },
    gunMods = {
        enabled = false,
        fireRate = 0.05,
        damage = 50,
        range = 9999,
        autoFire = true,
        reloadTime = 0.1,
        equipTime = 0.1,
        spread = 0,
        recoil = 0,
        automatic = true,
        magSize = 30,
        reserveAmmo = 999,
        bulletSpeed = 3000,
        bulletAcceleration = 0,
        bulletDrop = 0,
    },
    triggerbot = {
        enabled = false,
        delay = 0.05,
        teamCheck = true,
    },
    esp = {
        enabled = false,
        box = true,
        name = true,
        distance = true,
        health = true,
        teamCheck = true,
        useTeamColors = true,
        guardColor = Color3.fromRGB(0, 100, 255),
        criminalColor = Color3.fromRGB(255, 50, 50),
        inmateColor = Color3.fromRGB(255, 165, 0),
        textSize = 16,
    },
    sounds = {
        hitSound = true,
        hitSoundID = "rbxassetid://8679627751",
        hitSoundVolume = 0.3,
        killSound = true,
        killSoundID = "rbxassetid://5043559709",
        killSoundVolume = 0.5,
        hitMarkers = true,
        killNotifs = true,
    },
    sessionStats = {
        kills = 0,
        deaths = 0,
        headshots = 0,
        shotsHit = 0,
        shotsFired = 0,
        currentStreak = 0,
        bestStreak = 0,
    },
    movement = {
        walkSpeed = 16,
        jumpPower = 50,
        speedEnabled = false,
        jumpEnabled = false,
        infiniteJump = false,
        noclip = false,
        fly = false,
        flySpeed = 50,
    },
    fpsBoost = {
        enabled = false,
        level = 1,
    },
}

local originals = {}
local espObjects = {}
local playerConnections = {}
local lastTriggerShot = 0
local currentGun = nil
local fovCircle = nil
local lockedTarget = nil

local function getGun()
    if not LocalPlayer.Character then return nil end
    for _, tool in ipairs(LocalPlayer.Character:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Muzzle") then
            return tool
        end
    end
    return nil
end

local function isTaser(gun)
    if not gun then return false end
    return gun:GetAttribute("Projectile") == "Taser"
end

local function canTarget(player)
    if not player or not player.Character then return false end
    
    if cfg.aimbot.teamCheck or cfg.triggerbot.teamCheck then
        if LocalPlayer.Team == guardsTeam then
            if player.Team ~= criminalsTeam and player.Team ~= inmatesTeam then
                return false
            end
            
            if player.Team == inmatesTeam then
                local gun = getGun()
                local isTaserWeapon = isTaser(gun)
                local bypassHostile = cfg.aimbot.taserBypassHostile and isTaserWeapon
                local bypassTrespass = cfg.aimbot.taserBypassTrespass and isTaserWeapon
                
                if cfg.aimbot.hostileCheck or cfg.aimbot.trespassCheck then
                    local char = player.Character
                    local hostile = char:GetAttribute("Hostile")
                    local trespass = char:GetAttribute("Trespassing")
                    
                    if cfg.aimbot.hostileCheck and cfg.aimbot.trespassCheck then
                        if not bypassHostile and not bypassTrespass then
                            if not hostile and not trespass then return false end
                        end
                    elseif cfg.aimbot.hostileCheck and not bypassHostile then
                        if not hostile then return false end
                    elseif cfg.aimbot.trespassCheck and not bypassTrespass then
                        if not trespass then return false end
                    end
                end
            end
        elseif LocalPlayer.Team == criminalsTeam then
            if player.Team ~= guardsTeam and player.Team ~= inmatesTeam then
                return false
            end
        elseif LocalPlayer.Team == inmatesTeam then
            if player.Team ~= guardsTeam then
                return false
            end
        else
            if player.Team == LocalPlayer.Team then
                return false
            end
        end
    end
    
    return true
end

local function getTeamColor(player)
    if not player or not player.Team then return Color3.fromRGB(255, 255, 255) end
    
    if player.Team == guardsTeam then
        return cfg.esp.guardColor
    elseif player.Team == criminalsTeam then
        return cfg.esp.criminalColor
    elseif player.Team == inmatesTeam then
        return cfg.esp.inmateColor
    end
    return Color3.fromRGB(255, 255, 255)
end

local function createNotification(title, text, duration)
    pcall(function()
        if Library then
            Library:Notify({
                Title = title,
                Description = text,
                Time = duration or 3,
            })
        end
    end)
end

local function playHitSound()
    if not cfg.sounds.hitSound then return end
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = cfg.sounds.hitSoundID
        sound.Volume = cfg.sounds.hitSoundVolume
        sound.Parent = SoundService
        sound:Play()
        task.delay(1, function() sound:Destroy() end)
    end)
end

local function playKillSound()
    if not cfg.sounds.killSound then return end
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = cfg.sounds.killSoundID
        sound.Volume = cfg.sounds.killSoundVolume
        sound.Parent = SoundService
        sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end)
end

local function showHitMarker(position)
    if not cfg.sounds.hitMarkers then return end
    pcall(function()
        local hitmarker = Instance.new("Part")
        hitmarker.Size = Vector3.new(0.5, 0.5, 0.5)
        hitmarker.Position = position
        hitmarker.Anchored = true
        hitmarker.CanCollide = false
        hitmarker.Material = Enum.Material.Neon
        hitmarker.Color = Color3.fromRGB(255, 255, 0)
        hitmarker.Shape = Enum.PartType.Ball
        hitmarker.Parent = Workspace
        
        task.spawn(function()
            for i = 1, 10 do
                hitmarker.Transparency = i / 10
                task.wait(0.05)
            end
            hitmarker:Destroy()
        end)
    end)
end

local function onKill(player)
    cfg.sessionStats.kills = cfg.sessionStats.kills + 1
    cfg.sessionStats.currentStreak = cfg.sessionStats.currentStreak + 1
    
    if cfg.sessionStats.currentStreak > cfg.sessionStats.bestStreak then
        cfg.sessionStats.bestStreak = cfg.sessionStats.currentStreak
    end
    
    playKillSound()
    
    if cfg.sounds.killNotifs then
        local kd = cfg.sessionStats.deaths > 0 
            and string.format("%.2f", cfg.sessionStats.kills / cfg.sessionStats.deaths) 
            or tostring(cfg.sessionStats.kills)
        
        local streakText = cfg.sessionStats.currentStreak > 1 
            and " | Streak: " .. cfg.sessionStats.currentStreak 
            or ""
        
        Library:Notify({
            Title = "💀 KILL",
            Description = "Eliminated " .. player.Name .. " | K/D: " .. kd .. streakText,
            Time = 2,
        })
    end
    
    lockedTarget = nil
    Library:Notify({
        Title = "🎯 Aimbot",
        Description = "Target died - unlocked",
        Time = 1,
    })
end

local function onDeath()
    cfg.sessionStats.deaths = cfg.sessionStats.deaths + 1
    cfg.sessionStats.currentStreak = 0
end

local function onHit(position)
    cfg.sessionStats.shotsHit = cfg.sessionStats.shotsHit + 1
    playHitSound()
    showHitMarker(position)
end

local function onShot()
    cfg.sessionStats.shotsFired = cfg.sessionStats.shotsFired + 1
end

local function createSphereHitbox(part, size)
    local oldSphere = part:FindFirstChild("HitboxSphere")
    if oldSphere then oldSphere:Destroy() end
    
    local sphere = Instance.new("Part")
    sphere.Name = "HitboxSphere"
    sphere.Shape = Enum.PartType.Ball
    sphere.Size = Vector3.new(size, size, size)
    sphere.Transparency = cfg.hitbox.transparency
    sphere.Color = cfg.hitbox.color
    sphere.Material = Enum.Material.ForceField
    sphere.CanCollide = false
    sphere.Anchored = false
    sphere.Massless = true
    sphere.CFrame = part.CFrame
    
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = sphere
    weld.Part1 = part
    weld.Parent = sphere
    
    sphere.Parent = part
    return sphere
end

local function setupHitboxExpander()
    RunService.Heartbeat:Connect(function()
        if not cfg.hitbox.enabled then return end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                pcall(function()
                    local char = player.Character
                    
                    if not canTarget(player) then
                        local head = char:FindFirstChild("Head")
                        if head then
                            local sphere = head:FindFirstChild("HitboxSphere")
                            if sphere then sphere:Destroy() end
                        end
                        
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root then
                            local sphere = root:FindFirstChild("HitboxSphere")
                            if sphere then sphere:Destroy() end
                        end
                        return
                    end
                    
                    if cfg.hitbox.headEnabled then
                        local head = char:FindFirstChild("Head")
                        if head then
                            if not originals[head] then
                                originals[head] = {
                                    Size = head.Size,
                                    Transparency = head.Transparency,
                                    Color = head.Color,
                                }
                            end
                            
                            if cfg.hitbox.shape == "Sphere" then
                                local sphere = head:FindFirstChild("HitboxSphere")
                                if not sphere then
                                    createSphereHitbox(head, cfg.hitbox.headSize)
                                else
                                    sphere.Size = Vector3.new(cfg.hitbox.headSize, cfg.hitbox.headSize, cfg.hitbox.headSize)
                                    sphere.Transparency = cfg.hitbox.transparency
                                    sphere.Color = cfg.hitbox.color
                                end
                            else
                                head.Size = Vector3.new(cfg.hitbox.headSize, cfg.hitbox.headSize, cfg.hitbox.headSize)
                                head.Transparency = cfg.hitbox.transparency
                                head.Color = cfg.hitbox.color
                            end
                        end
                    else
                        local head = char:FindFirstChild("Head")
                        if head then
                            local sphere = head:FindFirstChild("HitboxSphere")
                            if sphere then sphere:Destroy() end
                            
                            if originals[head] then
                                local orig = originals[head]
                                head.Size = orig.Size
                                head.Transparency = orig.Transparency
                                head.Color = orig.Color
                            end
                        end
                    end
                    
                    if cfg.hitbox.bodyEnabled then
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root then
                            if not originals[root] then
                                originals[root] = {
                                    Size = root.Size,
                                    Transparency = root.Transparency,
                                    Color = root.Color,
                                }
                            end
                            
                            if cfg.hitbox.shape == "Sphere" then
                                local sphere = root:FindFirstChild("HitboxSphere")
                                if not sphere then
                                    createSphereHitbox(root, cfg.hitbox.bodySize)
                                else
                                    sphere.Size = Vector3.new(cfg.hitbox.bodySize, cfg.hitbox.bodySize, cfg.hitbox.bodySize)
                                    sphere.Transparency = cfg.hitbox.transparency
                                    sphere.Color = cfg.hitbox.color
                                end
                            else
                                root.Size = Vector3.new(cfg.hitbox.bodySize, cfg.hitbox.bodySize, cfg.hitbox.bodySize)
                                root.Transparency = cfg.hitbox.transparency
                                root.Color = cfg.hitbox.color
                            end
                        end
                    else
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root then
                            local sphere = root:FindFirstChild("HitboxSphere")
                            if sphere then sphere:Destroy() end
                            
                            if originals[root] then
                                local orig = originals[root]
                                root.Size = orig.Size
                                root.Transparency = orig.Transparency
                                root.Color = orig.Color
                            end
                        end
                    end
                end)
            end
        end
    end)
end

local function getClosestPlayerInFOV()
    local closestPlayer = nil
    local shortestDistance = cfg.aimbot.fov
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            pcall(function()
                if not canTarget(player) then return end
                
                local char = player.Character
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if not humanoid or humanoid.Health <= 0 then return end
                
                local targetPart = char:FindFirstChild(cfg.aimbot.aimPart) or char:FindFirstChild("HumanoidRootPart")
                if not targetPart then return end
                
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                if not onScreen then return end
                
                local viewportSize = Camera.ViewportSize
                local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
                local distanceFromCenter = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                
                if distanceFromCenter < shortestDistance then
                    if cfg.aimbot.visibleCheck then
                        local ray = Ray.new(Camera.CFrame.Position, (targetPart.Position - Camera.CFrame.Position).Unit * 500)
                        local hit = Workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
                        
                        if hit and hit:IsDescendantOf(char) then
                            closestPlayer = player
                            shortestDistance = distanceFromCenter
                        end
                    else
                        closestPlayer = player
                        shortestDistance = distanceFromCenter
                    end
                end
            end)
        end
    end
    
    return closestPlayer
end

local function aimAt(player)
    if not player or not player.Character then 
        lockedTarget = nil
        return 
    end
    
    pcall(function()
        local char = player.Character
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then
            lockedTarget = nil
            Library:Notify({
                Title = "🎯 Aimbot",
                Description = "Target died - unlocked",
                Time = 1,
            })
            return
        end
        
        local targetPart = char:FindFirstChild(cfg.aimbot.aimPart) or char:FindFirstChild("HumanoidRootPart")
        if not targetPart then return end
        
        local targetPos = targetPart.Position
        if cfg.aimbot.prediction > 0 and targetPart.Parent then
            local velocity = targetPart.AssemblyLinearVelocity or targetPart.Velocity
            targetPos = targetPos + (velocity * cfg.aimbot.prediction)
        end
        
        local currentCFrame = Camera.CFrame
        local targetCFrame = CFrame.new(currentCFrame.Position, targetPos)
        
        if cfg.aimbot.smoothness > 0 then
            Camera.CFrame = currentCFrame:Lerp(targetCFrame, cfg.aimbot.smoothness)
        else
            Camera.CFrame = targetCFrame
        end
    end)
end

local function setupAimbot()
    RunService.RenderStepped:Connect(function()
        if cfg.aimbot.enabled and lockedTarget then
            aimAt(lockedTarget)
        end
    end)
end

local function createFOVCircle()
    local success, fov = pcall(function()
        local circle = Drawing.new("Circle")
        circle.Thickness = 2
        circle.NumSides = 50
        circle.Radius = cfg.aimbot.fov
        circle.Filled = false
        circle.Color = cfg.aimbot.fovColor
        circle.Transparency = cfg.aimbot.fovTransparency
        circle.Visible = cfg.aimbot.showFOV
        
        RunService.RenderStepped:Connect(function()
            local viewportSize = Camera.ViewportSize
            circle.Position = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
            circle.Radius = cfg.aimbot.fov
            circle.Color = cfg.aimbot.fovColor
            circle.Transparency = cfg.aimbot.fovTransparency
            circle.Visible = cfg.aimbot.showFOV and cfg.aimbot.enabled
        end)
        
        return circle
    end)
    
    return success and fov or nil
end

local moddedGuns = {}

local function applyGunMods(gun)
    if not gun or moddedGuns[gun] then return end
    
    pcall(function()
        gun:SetAttribute("FireRate", cfg.gunMods.fireRate)
        gun:SetAttribute("Damage", cfg.gunMods.damage)
        gun:SetAttribute("Range", cfg.gunMods.range)
        gun:SetAttribute("AutoFire", cfg.gunMods.autoFire)
        gun:SetAttribute("Automatic", cfg.gunMods.automatic)
        
        
        gun:SetAttribute("SpreadRadius", cfg.gunMods.spread)
        
        
    end)
    
    moddedGuns[gun] = true
end

local function setupGunMods()
    task.spawn(function()
        while true do
            if cfg.gunMods.enabled then
                local gun = getGun()
                if gun then
                    applyGunMods(gun)
                    currentGun = gun
                else
                    currentGun = nil
                end
            end
            task.wait(0.1)
        end
    end)
end

local function getPlayerUnderCrosshair()
    local viewportSize = Camera.ViewportSize
    local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    local ray = Camera:ViewportPointToRay(screenCenter.X, screenCenter.Y)
    
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    params.FilterType = Enum.RaycastFilterType.Blacklist
    
    local result = Workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
    
    if result and result.Instance then
        local part = result.Instance
        local model = part:FindFirstAncestorOfClass("Model")
        
        if model then
            local player = Players:GetPlayerFromCharacter(model)
            if player and canTarget(player) then
                return player, result.Position
            end
        end
    end
    
    return nil, nil
end

local function setupTriggerbot()
    RunService.Heartbeat:Connect(function()
        if not cfg.triggerbot.enabled then return end
        if not currentGun then return end
        
        pcall(function()
            local target, hitPos = getPlayerUnderCrosshair()
            
            if target then
                local now = tick()
                if now - lastTriggerShot >= cfg.triggerbot.delay then
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait(0.01)
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    
                    lastTriggerShot = now
                    onShot()
                    
                    if hitPos then
                        onHit(hitPos)
                    end
                end
            end
        end)
    end)
end

local function removeESP(player)
    if espObjects[player] then
        pcall(function() espObjects[player]:Destroy() end)
        espObjects[player] = nil
    end
    
    if player.Character then
        pcall(function()
            local highlight = player.Character:FindFirstChild("BoxESP")
            if highlight then highlight:Destroy() end
        end)
    end
    
    if playerConnections[player] then
        for _, connection in pairs(playerConnections[player]) do
            pcall(function() connection:Disconnect() end)
        end
        playerConnections[player] = nil
    end
end

local function createESP(player)
    
    if not player.Character then return end
    
    pcall(function()
        local char = player.Character
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local teamColor = cfg.esp.useTeamColors and getTeamColor(player) or Color3.fromRGB(255, 255, 255)
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP"
        billboard.Adornee = root
        billboard.Size = UDim2.new(0, 200, 0, 100)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = root
        
        if cfg.esp.name then
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 0, 20)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = teamColor
            nameLabel.TextStrokeTransparency = 0.5
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextSize = cfg.esp.textSize
            nameLabel.Parent = billboard
        end
        
        if cfg.esp.distance then
            local distLabel = Instance.new("TextLabel")
            distLabel.Size = UDim2.new(1, 0, 0, 15)
            distLabel.Position = UDim2.new(0, 0, 0, 20)
            distLabel.BackgroundTransparency = 1
            distLabel.TextColor3 = teamColor
            distLabel.TextStrokeTransparency = 0.5
            distLabel.Font = Enum.Font.Gotham
            distLabel.TextSize = cfg.esp.textSize - 4
            distLabel.Parent = billboard
            
            task.spawn(function()
                while billboard and billboard.Parent do
                    pcall(function()
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude
                            distLabel.Text = math.floor(dist) .. " studs"
                        end
                    end)
                    task.wait(0.1)
                end
            end)
        end
        
        if cfg.esp.health then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local healthLabel = Instance.new("TextLabel")
                healthLabel.Size = UDim2.new(1, 0, 0, 15)
                healthLabel.Position = UDim2.new(0, 0, 0, 35)
                healthLabel.BackgroundTransparency = 1
                healthLabel.TextStrokeTransparency = 0.5
                healthLabel.Font = Enum.Font.Gotham
                healthLabel.TextSize = cfg.esp.textSize - 4
                healthLabel.Parent = billboard
                
                task.spawn(function()
                    while billboard and billboard.Parent do
                        pcall(function()
                            local health = math.floor(humanoid.Health)
                            healthLabel.Text = health .. " HP"
                            
                            if health > 75 then
                                healthLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                            elseif health > 50 then
                                healthLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                            elseif health > 25 then
                                healthLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
                            else
                                healthLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end
        
        if cfg.esp.box then
            local highlight = Instance.new("Highlight")
            highlight.Name = "BoxESP"
            highlight.Adornee = char
            highlight.FillTransparency = 0.7
            highlight.OutlineTransparency = 0
            highlight.OutlineColor = teamColor
            highlight.FillColor = teamColor
            highlight.Parent = char
        end
        
        espObjects[player] = billboard
        
        if not playerConnections[player] then
            playerConnections[player] = {}
        end
        
        local deathConn = char:WaitForChild("Humanoid").Died:Connect(function()
            removeESP(player)
        end)
        table.insert(playerConnections[player], deathConn)
    end)
end

local function setupPlayerESP(player)
    if player == LocalPlayer then return end
    
    if player.Character and cfg.esp.enabled and canTarget(player) then
        createESP(player)
    end
    
    if not playerConnections[player] then
        playerConnections[player] = {}
    end
    
    local respawnConn = player.CharacterAdded:Connect(function(char)
        task.wait(1)
        if cfg.esp.enabled and canTarget(player) then
            createESP(player)
        end
        
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                if lockedTarget == player then
                    onKill(player)
                end
            end)
        end
    end)
    table.insert(playerConnections[player], respawnConn)
end

local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        pcall(function()
            if player ~= LocalPlayer and cfg.esp.enabled then
                if not canTarget(player) then
                    removeESP(player)
                    return
                end
                
                if player.Character and not espObjects[player] then
                    createESP(player)
                end
            elseif not cfg.esp.enabled then
                removeESP(player)
            end
        end)
    end
end

for _, player in pairs(Players:GetPlayers()) do
    setupPlayerESP(player)
end

Players.PlayerAdded:Connect(setupPlayerESP)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

task.spawn(function()
    while true do
        updateESP()
        task.wait(1)
    end
end)

local function setupMovement()
    task.spawn(function()
        while true do
            pcall(function()
                if LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        if cfg.movement.speedEnabled then
                        else
                        end
                        
                        if cfg.movement.jumpEnabled then
                            humanoid.JumpPower = cfg.movement.jumpPower
                        else
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
    
    UserInputService.JumpRequest:Connect(function()
        if cfg.movement.infiniteJump and LocalPlayer.Character then
            pcall(function()
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end)
    
    RunService.Stepped:Connect(function()
        if cfg.movement.noclip and LocalPlayer.Character then
            pcall(function()
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        end
    end)
    
    RunService.Heartbeat:Connect(function()
        if cfg.movement.fly and LocalPlayer.Character then
            pcall(function()
                local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local velocity = Vector3.new(0, 0, 0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        velocity = velocity + (Camera.CFrame.LookVector * cfg.movement.flySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        velocity = velocity - (Camera.CFrame.LookVector * cfg.movement.flySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        velocity = velocity - (Camera.CFrame.RightVector * cfg.movement.flySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        velocity = velocity + (Camera.CFrame.RightVector * cfg.movement.flySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        velocity = velocity + Vector3.new(0, cfg.movement.flySpeed, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        velocity = velocity - Vector3.new(0, cfg.movement.flySpeed, 0)
                    end
                    
                    root.Velocity = velocity
                end
            end)
        end
    end)
end

if LocalPlayer.Character then
    pcall(function()
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                onDeath()
            end)
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    pcall(function()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                onDeath()
            end)
        end
    end)
end)

local function applyFPSBoost(level)
    pcall(function()
        if level >= 1 then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end
        
        if level >= 2 then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v.Parent:FindFirstChildOfClass("Humanoid") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Enabled = false
                end
            end
        end
        
        if level >= 3 then
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false
                end
            end
        end
    end)
end

local function setupFPSBoost()
    task.spawn(function()
        while true do
            if cfg.fpsBoost.enabled then
                applyFPSBoost(cfg.fpsBoost.level)
            end
            task.wait(5)
        end
    end)
end

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

local Window = Library:CreateWindow({
    Title = "PrisonLifeTaliban",
    Footer = "XENO, by f3kel666, owned by cizo & jaylen",
    Icon = 95816097006870,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Aimbot = Window:AddTab("Aimbot", "crosshair"),
    Hitbox = Window:AddTab("Hitbox", "circle"),
    Combat = Window:AddTab("Combat", "sword"),
    ESP = Window:AddTab("ESP", "eye"),
    Settings = Window:AddTab("Settings", "settings"),
}

local AimbotMain = Tabs.Aimbot:AddLeftGroupbox("Lock-On Aimbot", "target")

AimbotMain:AddToggle("AimbotEnabled", {
    Text = "Enable Aimbot",
    Default = false,
    Callback = function(Value)
        cfg.aimbot.enabled = Value
        if not Value then lockedTarget = nil end
    end,
})

AimbotMain:AddLabel("Lock Key"):AddKeyPicker("LockKey", {
    Default = "E",
    Text = "Lock Target",
    NoUI = false,
    Callback = function(Value)
        cfg.aimbot.lockKey = Value
    end,
})

Options.LockKey:OnClick(function()
    if not cfg.aimbot.enabled then return end
    
    if lockedTarget then
        lockedTarget = nil
        Library:Notify({
            Title = "aimbot",
            Description = "target unlocked",
            Time = 1,
        })
    else
        local target = getClosestPlayerInFOV()
        if target then
            lockedTarget = target
            Library:Notify({
                Title = "aimbot",
                Description = "locked onto " .. target.Name,
                Time = 2,
            })
        else
            Library:Notify({
                Title = "aimbot",
                Description = "no target in fov",
                Time = 1,
            })
        end
    end
end)

AimbotMain:AddSlider("AimbotFOV", {
    Text = "FOV",
    Default = 100,
    Min = 10,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        cfg.aimbot.fov = Value
    end,
})

AimbotMain:AddSlider("AimbotSmooth", {
    Text = "Smoothness",
    Default = 0.1,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        cfg.aimbot.smoothness = Value
    end,
})

AimbotMain:AddDropdown("AimPart", {
    Values = {"Head", "Torso", "HumanoidRootPart"},
    Default = 1,
    Text = "Aim Part",
    Callback = function(Value)
        cfg.aimbot.aimPart = Value
    end,
})

AimbotMain:AddSlider("Prediction", {
    Text = "Prediction",
    Default = 0,
    Min = 0,
    Max = 0.5,
    Rounding = 2,
    Callback = function(Value)
        cfg.aimbot.prediction = Value
    end,
})

AimbotMain:AddToggle("TeamCheck", {
    Text = "Team Check",
    Default = true,
    Callback = function(Value)
        cfg.aimbot.teamCheck = Value
    end,
})

AimbotMain:AddToggle("VisibleCheck", {
    Text = "Visible Check",
    Default = false,
    Callback = function(Value)
        cfg.aimbot.visibleCheck = Value
    end,
})

local ChecksGroup = Tabs.Aimbot:AddRightGroupbox("Hostile/Trespass", "shield")

ChecksGroup:AddToggle("HostileCheck", {
    Text = "Hostile Check",
    Default = false,
    Callback = function(Value)
        cfg.aimbot.hostileCheck = Value
    end,
})

ChecksGroup:AddToggle("TrespassCheck", {
    Text = "Trespassing Check",
    Default = false,
    Callback = function(Value)
        cfg.aimbot.trespassCheck = Value
    end,
})

ChecksGroup:AddToggle("TaserBypassHostile", {
    Text = "Taser Bypass Hostile",
    Default = true,
    Callback = function(Value)
        cfg.aimbot.taserBypassHostile = Value
    end,
})

ChecksGroup:AddToggle("TaserBypassTrespass", {
    Text = "Taser Bypass Trespass",
    Default = true,
    Callback = function(Value)
        cfg.aimbot.taserBypassTrespass = Value
    end,
})

local FOVGroup = Tabs.Aimbot:AddLeftGroupbox("FOV Circle", "circle")

FOVGroup:AddToggle("ShowFOV", {
    Text = "Show FOV Circle",
    Default = true,
    Callback = function(Value)
        cfg.aimbot.showFOV = Value
    end,
})

FOVGroup:AddLabel("FOV Color"):AddColorPicker("FOVColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "FOV Color",
    Transparency = 0.5,
    Callback = function(Value)
        cfg.aimbot.fovColor = Value
    end,
})

local HitboxGroup = Tabs.Hitbox:AddLeftGroupbox("Hitbox Expander", "maximize")

HitboxGroup:AddToggle("HitboxEnabled", {
    Text = "Enable Hitbox",
    Default = false,
    Callback = function(Value)
        cfg.hitbox.enabled = Value
    end,
})

HitboxGroup:AddDropdown("HitboxShape", {
    Values = {"Sphere", "Box"},
    Default = 1,
    Text = "Shape",
    Callback = function(Value)
        cfg.hitbox.shape = Value
    end,
})

HitboxGroup:AddToggle("HeadHitbox", {
    Text = "Head Hitbox",
    Default = false,
    Callback = function(Value)
        cfg.hitbox.headEnabled = Value
    end,
})

HitboxGroup:AddSlider("HeadSize", {
    Text = "Head Size",
    Default = 20,
    Min = 5,
    Max = 50,
    Rounding = 0,
    Callback = function(Value)
        cfg.hitbox.headSize = Value
    end,
})

HitboxGroup:AddToggle("BodyHitbox", {
    Text = "Body Hitbox",
    Default = false,
    Callback = function(Value)
        cfg.hitbox.bodyEnabled = Value
    end,
})

HitboxGroup:AddSlider("BodySize", {
    Text = "Body Size",
    Default = 20,
    Min = 5,
    Max = 50,
    Rounding = 0,
    Callback = function(Value)
        cfg.hitbox.bodySize = Value
    end,
})

local HitboxCustom = Tabs.Hitbox:AddRightGroupbox("Customization", "palette")

HitboxCustom:AddSlider("HitboxTrans", {
    Text = "Transparency",
    Default = 0.7,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        cfg.hitbox.transparency = Value
    end,
})

HitboxCustom:AddLabel("Hitbox Color"):AddColorPicker("HitboxColor", {
    Default = Color3.fromRGB(0, 200, 255),
    Title = "Hitbox Color",
    Callback = function(Value)
        cfg.hitbox.color = Value
    end,
})

local GunGroup = Tabs.Combat:AddLeftGroupbox("Gun Mods", "gun")

GunGroup:AddToggle("GunModsEnabled", {
    Text = "Enable Gun Mods",
    Default = false,
    Callback = function(Value)
        cfg.gunMods.enabled = Value
    end,
})

GunGroup:AddDivider()
GunGroup:AddLabel("Fire Settings")

GunGroup:AddSlider("FireRate", {
    Text = "Fire Rate",
    Default = 0.05,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        cfg.gunMods.fireRate = Value
    end,
})


GunGroup:AddSlider("Range", {
    Text = "Range",
    Default = 9999,
    Min = 100,
    Max = 9999,
    Rounding = 0,
    Callback = function(Value)
        cfg.gunMods.range = Value
    end,
})

GunGroup:AddToggle("AutoFire", {
    Text = "Auto Fire",
    Default = true,
    Callback = function(Value)
        cfg.gunMods.autoFire = Value
    end,
})


local GunGroup2 = Tabs.Combat:AddRightGroupbox("Advanced Gun Mods", "settings")


GunGroup2:AddDivider()
GunGroup2:AddLabel("Accuracy")

GunGroup2:AddSlider("Spread", {
    Text = "Spread",
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        cfg.gunMods.spread = Value
    end,
})

GunGroup2:AddSlider("Recoil", {
    Text = "Recoil",
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        cfg.gunMods.recoil = Value
    end,
})



local TriggerGroup = Tabs.Combat:AddRightGroupbox("Triggerbot", "crosshair")

TriggerGroup:AddToggle("TriggerbotEnabled", {
    Text = "Enable Triggerbot",
    Default = false,
    Callback = function(Value)
        cfg.triggerbot.enabled = Value
    end,
})

TriggerGroup:AddSlider("TriggerDelay", {
    Text = "Delay",
    Default = 0.05,
    Min = 0,
    Max = 0.5,
    Rounding = 2,
    Callback = function(Value)
        cfg.triggerbot.delay = Value
    end,
})

local SoundGroup = Tabs.Combat:AddLeftGroupbox("Sounds & Notifications", "volume-2")

SoundGroup:AddToggle("HitSound", {
    Text = "Hit Sound",
    Default = true,
    Callback = function(Value)
        cfg.sounds.hitSound = Value
    end,
})

SoundGroup:AddInput("HitSoundID", {
    Default = "rbxassetid://8679627751",
    Text = "Hit Sound ID",
    Placeholder = "rbxassetid://",
    Callback = function(Value)
        cfg.sounds.hitSoundID = Value
    end,
})

SoundGroup:AddSlider("HitSoundVolume", {
    Text = "Hit Sound Volume",
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        cfg.sounds.hitSoundVolume = Value
    end,
})

SoundGroup:AddToggle("KillSound", {
    Text = "Kill Sound",
    Default = true,
    Callback = function(Value)
        cfg.sounds.killSound = Value
    end,
})

SoundGroup:AddInput("KillSoundID", {
    Default = "rbxassetid://5043559709",
    Text = "Kill Sound ID",
    Placeholder = "rbxassetid://",
    Callback = function(Value)
        cfg.sounds.killSoundID = Value
    end,
})

SoundGroup:AddSlider("KillSoundVolume", {
    Text = "Kill Sound Volume",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(Value)
        cfg.sounds.killSoundVolume = Value
    end,
})

SoundGroup:AddToggle("HitMarkers", {
    Text = "Hit Markers",
    Default = true,
    Callback = function(Value)
        cfg.sounds.hitMarkers = Value
    end,
})

SoundGroup:AddToggle("KillNotifs", {
    Text = "Kill Notifications",
    Default = true,
    Callback = function(Value)
        cfg.sounds.killNotifs = Value
    end,
})

local ESPGroup = Tabs.ESP:AddLeftGroupbox("ESP Settings", "eye")

ESPGroup:AddToggle("ESPEnabled", {
    Text = "Enable ESP",
    Default = false,
    Callback = function(Value)
        cfg.esp.enabled = Value
    end,
})

ESPGroup:AddToggle("ESPBox", {
    Text = "Box",
    Default = true,
    Callback = function(Value)
        cfg.esp.box = Value
    end,
})

ESPGroup:AddToggle("ESPName", {
    Text = "Name",
    Default = true,
    Callback = function(Value)
        cfg.esp.name = Value
    end,
})

ESPGroup:AddToggle("ESPDistance", {
    Text = "Distance",
    Default = true,
    Callback = function(Value)
        cfg.esp.distance = Value
    end,
})

ESPGroup:AddToggle("ESPHealth", {
    Text = "Health",
    Default = true,
    Callback = function(Value)
        cfg.esp.health = Value
    end,
})

ESPGroup:AddToggle("ESPTeamCheck", {
    Text = "Team Check",
    Default = true,
    Callback = function(Value)
        cfg.esp.teamCheck = Value
    end,
})

local ColorGroup = Tabs.ESP:AddRightGroupbox("Team Colors", "palette")

ColorGroup:AddToggle("UseTeamColors", {
    Text = "Use Team Colors",
    Default = true,
    Callback = function(Value)
        cfg.esp.useTeamColors = Value
    end,
})

ColorGroup:AddLabel("Guard Color"):AddColorPicker("GuardColor", {
    Default = Color3.fromRGB(0, 100, 255),
    Title = "Guards",
    Callback = function(Value)
        cfg.esp.guardColor = Value
    end,
})

ColorGroup:AddLabel("Criminal Color"):AddColorPicker("CriminalColor", {
    Default = Color3.fromRGB(255, 50, 50),
    Title = "Criminals",
    Callback = function(Value)
        cfg.esp.criminalColor = Value
    end,
})

ColorGroup:AddLabel("Inmate Color"):AddColorPicker("InmateColor", {
    Default = Color3.fromRGB(255, 165, 0),
    Title = "Inmates",
    Callback = function(Value)
        cfg.esp.inmateColor = Value
    end,
})

local FPSGroup = Tabs.Settings:AddLeftGroupbox("FPS Boost", "zap")

FPSGroup:AddToggle("FPSBoostEnabled", {
    Text = "Enable FPS Boost",
    Default = false,
    Callback = function(Value)
        cfg.fpsBoost.enabled = Value
    end,
})

FPSGroup:AddSlider("FPSLevel", {
    Text = "Boost Level",
    Default = 1,
    Min = 1,
    Max = 3,
    Rounding = 0,
    Callback = function(Value)
        cfg.fpsBoost.level = Value
    end,
})

local MenuGroup = Tabs.Settings:AddLeftGroupbox("Menu", "settings")

MenuGroup:AddLabel("Menu Keybind"):AddKeyPicker("MenuKeybind", {
    Default = "RightShift",
    NoUI = true,
    Text = "Menu keybind",
})

MenuGroup:AddButton({
    Text = "Unload",
    Func = function()
        Library:Unload()
    end,
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})
ThemeManager:SetFolder("pltxeno")
SaveManager:SetFolder("pltxeno/plttttttt")
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

pcall(function()
    fovCircle = createFOVCircle()
end)

setupHitboxExpander()
setupAimbot()
setupGunMods()
setupTriggerbot()
setupMovement()
setupFPSBoost()

Library:Notify({
    Title = "plt but for xeno",
    Description = "loaded",
    Time = 5,
})
