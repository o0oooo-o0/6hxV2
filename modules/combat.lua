-- COMBAT.LUA - Silent Aim + Bullet Tracers

local Config = _G.SixHX_Config

local partMap = {
    ["Torso"] = {"Torso", "UpperTorso", "LowerTorso"},
    ["LeftArm"] = {"Left Arm", "LeftUpperArm", "LeftLowerArm", "LeftHand"},
    ["RightArm"] = {"Right Arm", "RightUpperArm", "RightLowerArm", "RightHand"},
    ["LeftLeg"] = {"Left Leg", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot"},
    ["RightLeg"] = {"Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot"}
}

local ShootEvent = Config.Services.ReplicatedStorage:WaitForChild("GunRemotes"):WaitForChild("ShootEvent")

local function getPart(char, name)
    if not char then return nil end
    local p = char:FindFirstChild(name)
    if p then return p end
    
    local maps = partMap[name]
    if maps then
        for _, n in ipairs(maps) do
            local part = char:FindFirstChild(n)
            if part then return part end
        end
    end
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
end

local function getTargetPart(char)
    if not char then return nil end
    
    if Config.Toggles.ShieldBreaker.Value then
        local shield = char:FindFirstChild("RiotShieldPart")
        if shield and shield:IsA("BasePart") then
            local hp = shield:GetAttribute("Health")
            if hp and hp > 0 then
                local myChar = Config.LocalPlayer.Character
                local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local theirHrp = char:FindFirstChild("HumanoidRootPart")
                
                if myHrp and theirHrp then
                    local toMe = (myHrp.Position - theirHrp.Position).Unit
                    local theirLook = theirHrp.CFrame.LookVector
                    local dot = toMe:Dot(theirLook)
                    
                    if dot > 0.3 then
                        if Config.Toggles.ShieldRandomHead.Value and Config.State.rng:NextInteger(1, 100) <= Config.Options.ShieldHeadChance.Value then
                            return getPart(char, "Head")
                        end
                        return shield
                    end
                end
            end
        end
    end
    
    local partName
    if Config.Toggles.RandomParts.Value then
        local list = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "HumanoidRootPart"}
        partName = list[Config.State.rng:NextInteger(1, #list)]
    else
        partName = Config.Options.AimPart.Value
    end
    return getPart(char, partName)
end

local function isDead(player)
    if not player or not player.Character then return true end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    return not humanoid or humanoid.Health <= 0
end

local function isStanding(player)
    if not player or not player.Character then return false end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local vel = hrp.AssemblyLinearVelocity
    return Vector2.new(vel.X, vel.Z).Magnitude <= Config.Options.StillThreshold.Value
end

local function hasForceField(player)
    if not player or not player.Character then return false end
    return player.Character:FindFirstChildOfClass("ForceField") ~= nil
end

local function isInVehicle(player)
    if not player or not player.Character then return false end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    return humanoid.SeatPart ~= nil
end

local function wallBetween(startPos, endPos, targetChar)
    local myChar = Config.LocalPlayer.Character
    if not myChar then return true end
    
    local filter = {myChar}
    if targetChar then table.insert(filter, targetChar) end
    Config.wallParams.FilterDescendantsInstances = filter
    
    local direction = endPos - startPos
    local distance = direction.Magnitude
    local unit = direction.Unit
    
    local currentStart = startPos
    local remaining = distance
    
    for _ = 1, 10 do
        local result = workspace:Raycast(currentStart, unit * remaining, Config.wallParams)
        if not result then return false end
        
        local hit = result.Instance
        if hit.Transparency < 0.8 and hit.CanCollide then return true end
        
        local hitDist = (result.Position - currentStart).Magnitude
        remaining = remaining - hitDist - 0.01
        if remaining <= 0 then return false end
        
        currentStart = result.Position + unit * 0.01
    end
    return false
end

local function isTargetableTeam(player)
    local targetTeams = Config.Options.TargetTeams.Value
    local theirTeam = player.Team
    
    if theirTeam == Config.Teams.Guards and targetTeams.Guards then return true end
    if theirTeam == Config.Teams.Inmates and targetTeams.Inmates then return true end
    if theirTeam == Config.Teams.Criminals and targetTeams.Criminals then return true end
    
    return false
end

local function quickCheck(player)
    if not player or player == Config.LocalPlayer or not player.Character then return false end
    if not getTargetPart(player.Character) then return false end
    if Config.Toggles.DeathCheck.Value and isDead(player) then return false end
    if Config.Toggles.FFCheck.Value and hasForceField(player) then return false end
    if Config.Toggles.VehicleCheck.Value and isInVehicle(player) then return false end
    if Config.Toggles.TeamCheck.Value and player.Team == Config.LocalPlayer.Team then return false end
    
    if not isTargetableTeam(player) then return false end
    
    if Config.Toggles.CriminalsNoInmates.Value then
        if Config.LocalPlayer.Team == Config.Teams.Criminals and player.Team == Config.Teams.Inmates then return false end
    end
    if Config.Toggles.InmatesNoCriminals.Value then
        if Config.LocalPlayer.Team == Config.Teams.Inmates and player.Team == Config.Teams.Criminals then return false end
    end
    
    if Config.Toggles.HostileCheck.Value or Config.Toggles.TrespassCheck.Value then
        local isTaser = Config.State.currentGun and Config.State.currentGun:GetAttribute("Projectile") == "Taser"
        local bypassHostile = Config.Toggles.TaserBypassHostile.Value and isTaser
        local bypassTrespass = Config.Toggles.TaserBypassTrespass.Value and isTaser
        local targetChar = player.Character
        
        if Config.LocalPlayer.Team == Config.Teams.Guards and player.Team == Config.Teams.Inmates then
            local hostile = targetChar:GetAttribute("Hostile")
            local trespass = targetChar:GetAttribute("Trespassing")
            
            if Config.Toggles.HostileCheck.Value and Config.Toggles.TrespassCheck.Value then
                if not bypassHostile and not bypassTrespass then
                    if not hostile and not trespass then return false end
                end
            elseif Config.Toggles.HostileCheck.Value and not bypassHostile then
                if not hostile then return false end
            elseif Config.Toggles.TrespassCheck.Value and not bypassTrespass then
                if not trespass then return false end
            end
        end
    end
    return true
end

local function fullCheck(player)
    if not quickCheck(player) then return false end
    
    if Config.Toggles.WallCheck.Value then
        local myChar = Config.LocalPlayer.Character
        local myHead = myChar and myChar:FindFirstChild("Head")
        local targetPart = getTargetPart(player.Character)
        if myHead and targetPart then
            if wallBetween(myHead.Position, targetPart.Position, player.Character) then
                return false
            end
        end
    end
    return true
end

local function rollHit()
    local now = os.clock()
    if now - Config.State.lastShotTime > Config.State.shotCooldown then
        Config.State.lastShotTime = now
        local chance = Config.Options.HitChance.Value
        if chance >= 100 then
            Config.State.lastShotResult = true
        elseif chance <= 0 then
            Config.State.lastShotResult = false
        else
            Config.State.lastShotResult = Config.State.rng:NextInteger(1, 100) <= chance
        end
    end
    return Config.State.lastShotResult
end

local function getMissPos(targetPos)
    local spread = Config.Options.MissSpread.Value
    local angle = Config.State.rng:NextNumber() * math.pi * 2
    local d = Config.State.rng:NextNumber() * spread
    local yOffset = (Config.State.rng:NextNumber() - 0.5) * spread
    return targetPos + Vector3.new(math.cos(angle) * d, yOffset, math.sin(angle) * d)
end

local function getClosest(fovRadius)
    if Config.State.panicMode then return nil, nil end
    
    fovRadius = fovRadius or Config.Options.FOV.Value
    local camera = workspace.CurrentCamera
    if not camera then return nil, nil end
    
    local lastInput = Config.Services.UserInputService:GetLastInputType()
    local locked = (lastInput == Enum.UserInputType.Touch) or (Config.Services.UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter)
    
    local aimPos
    if locked then
        local viewportSize = camera.ViewportSize
        aimPos = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    else
        aimPos = Config.Services.UserInputService:GetMouseLocation()
    end
    
    local now = os.clock()
    
    if Config.Toggles.TargetStickiness.Value and Config.State.currentTarget and (now - Config.State.targetSwitchTime) < Config.State.currentStickiness then
        if fullCheck(Config.State.currentTarget) then
            local part = getTargetPart(Config.State.currentTarget.Character)
            if part then
                local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                if onScreen and screenPos.Z > 0 then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - aimPos).Magnitude
                    if dist < fovRadius then
                        return Config.State.currentTarget, part.Position
                    end
                end
            end
        end
    end
    
    local candidates = {}
    
    for _, player in ipairs(Config.Services.Players:GetPlayers()) do
        if quickCheck(player) then
            local part = getTargetPart(player.Character)
            if part then
                local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                if onScreen and screenPos.Z > 0 then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - aimPos).Magnitude
                    if dist < fovRadius then
                        candidates[#candidates + 1] = {player = player, dist = dist, part = part}
                    end
                end
            end
        end
    end
    
    if Config.Toggles.PrioritizeClosest.Value then
        table.sort(candidates, function(a, b) return a.dist < b.dist end)
    else
        for i = #candidates, 2, -1 do
            local j = Config.State.rng:NextInteger(1, i)
            candidates[i], candidates[j] = candidates[j], candidates[i]
        end
    end
    
    for _, candidate in ipairs(candidates) do
        if fullCheck(candidate.player) then
            if candidate.player ~= Config.State.currentTarget then
                Config.State.currentTarget = candidate.player
                Config.State.targetSwitchTime = now
                if Config.Toggles.StickinessRandom.Value then
                    Config.State.currentStickiness = Config.State.rng:NextNumber(Config.Options.StickinessMin.Value, Config.Options.StickinessMax.Value)
                else
                    Config.State.currentStickiness = Config.Options.StickinessDuration.Value
                end
            end
            return candidate.player, candidate.part.Position
        end
    end
    
    Config.State.currentTarget = nil
    return nil, nil
end

local function getMultipleTargets()
    if Config.State.panicMode or not Config.Toggles.MultiTarget.Value then return {} end
    
    local fovRadius = Config.Options.FOV.Value
    local camera = workspace.CurrentCamera
    if not camera then return {} end
    
    local aimPos = Config.Services.UserInputService:GetMouseLocation()
    local candidates = {}
    
    for _, player in ipairs(Config.Services.Players:GetPlayers()) do
        if quickCheck(player) and fullCheck(player) then
            local part = getTargetPart(player.Character)
            if part then
                local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                if onScreen and screenPos.Z > 0 then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - aimPos).Magnitude
                    if dist < fovRadius then
                        candidates[#candidates + 1] = {player = player, dist = dist, pos = part.Position, part = part}
                    end
                end
            end
        end
    end
    
    table.sort(candidates, function(a, b) return a.dist < b.dist end)
    
    local targets = {}
    local maxTargets = Config.Options.MultiTargetCount.Value
    for i = 1, math.min(#candidates, maxTargets) do
        targets[#targets + 1] = candidates[i]
    end
    
    return targets
end

local function createBulletTrail(startPos, endPos)
    if Config.State.panicMode or not Config.Toggles.BulletTracers.Value then return end
    
    local distance = (endPos - startPos).Magnitude
    local trail = Instance.new("Part")
    trail.Name = "BulletTrail"
    trail.Anchored = true
    trail.CanCollide = false
    trail.CanQuery = false
    trail.CanTouch = false
    trail.Material = Enum.Material.Neon
    trail.Size = Vector3.new(0.05, 0.05, distance)
    trail.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -distance / 2)
    trail.Transparency = 0.3
    
    if Config.Toggles.TracerRainbow.Value then
        trail.Color = Color3.fromHSV(Config.State.rainbowHue, 1, 1)
    else
        trail.Color = Config.Options.TracerColor.Value
    end
    
    trail.Parent = workspace
    table.insert(Config.State.tracerParts, trail)
    
    local fadeSpeed = Config.Options.TracerFadeSpeed.Value
    Config.Services.TweenService:Create(trail, TweenInfo.new(fadeSpeed), {Transparency = 1}):Play()
    
    Config.Services.Debris:AddItem(trail, fadeSpeed)
end

local function showHitmarker()
    if Config.State.panicMode or not Config.Toggles.Hitmarker or not Config.Toggles.Hitmarker.Value then return end
    Config.State.hitmarkerLastShow = tick()
    local center = Config.Services.UserInputService:GetMouseLocation()
    local size, gap = 10, 5
    Config.Drawings.hitmarkerLines[1].From = Vector2.new(center.X - gap - size, center.Y - gap - size)
    Config.Drawings.hitmarkerLines[1].To = Vector2.new(center.X - gap, center.Y - gap)
    Config.Drawings.hitmarkerLines[2].From = Vector2.new(center.X + gap + size, center.Y - gap - size)
    Config.Drawings.hitmarkerLines[2].To = Vector2.new(center.X + gap, center.Y - gap)
    Config.Drawings.hitmarkerLines[3].From = Vector2.new(center.X - gap - size, center.Y + gap + size)
    Config.Drawings.hitmarkerLines[3].To = Vector2.new(center.X - gap, center.Y + gap)
    Config.Drawings.hitmarkerLines[4].From = Vector2.new(center.X + gap + size, center.Y + gap + size)
    Config.Drawings.hitmarkerLines[4].To = Vector2.new(center.X + gap, center.Y + gap)
    for i = 1, 4 do Config.Drawings.hitmarkerLines[i].Visible = true end
end

local function autoShoot()
    if Config.State.panicMode or not Config.Toggles.AutoShoot.Value or not Config.Toggles.Enabled.Value or not Config.State.currentGun then return end
    
    local now = os.clock()
    local fireRate = Config.State.currentGun:GetAttribute("FireRate") or Config.Options.AutoShootDelay.Value
    if now - Config.State.lastAutoShoot < fireRate then return end
    
    local myChar = Config.LocalPlayer.Character
    if not myChar then return end
    local myHead = myChar:FindFirstChild("Head")
    if not myHead then return end
    
    local muzzle = Config.State.currentGun:FindFirstChild("Muzzle")
    local startPos = muzzle and muzzle.Position or myHead.Position
    
    local targets = Config.Toggles.MultiTarget.Value and getMultipleTargets() or {}
    
    if #targets == 0 then
        local target, targetPos = getClosest(Config.Options.FOV.Value)
        if target and targetPos then
            local part = getTargetPart(target.Character)
            if part then
                targets = {{player = target, pos = targetPos, part = part}}
            end
        end
    end
    
    if #targets == 0 then
        Config.State.lastAutoTarget = nil
        return
    end
    
    if targets[1].player ~= Config.State.lastAutoTarget then
        Config.State.targetAcquiredTime = now
        Config.State.lastAutoTarget = targets[1].player
    end
    
    if now - Config.State.targetAcquiredTime < Config.Options.AutoShootStartDelay.Value then return end
    
    local ammo = Config.State.currentGun:GetAttribute("Local_CurrentAmmo") or Config.State.currentGun:GetAttribute("CurrentAmmo") or 0
    if ammo <= 0 then return end
    
    Config.State.lastAutoShoot = now
    
    local isTaser = Config.State.currentGun:GetAttribute("Projectile") == "Taser"
    local isShotgun = Config.State.currentGun:GetAttribute("IsShotgun")
    
    local shots = {}
    for _, targetData in ipairs(targets) do
        local shouldHit = false
        
        if Config.Toggles.TaserAlwaysHit.Value and isTaser then
            shouldHit = true
        elseif Config.Toggles.IfPlayerStill.Value and isStanding(targetData.player) then
            shouldHit = true
        elseif Config.Toggles.HitChanceAutoOnly.Value and isShotgun then
            shouldHit = true
        else
            shouldHit = rollHit()
        end
        
        if shouldHit then
            shots[#shots + 1] = {myHead.Position, targetData.pos, targetData.part}
            createBulletTrail(startPos, targetData.pos)
            showHitmarker()
            
            if Config.Toggles.HitSound.Value then
                Config.playSound(Config.Options.HitSoundID.Value, Config.Options.HitSoundVolume.Value, 1)
            end
        else
            if Config.Options.MissSpread.Value > 0 then
                local missPos = getMissPos(targetData.pos)
                shots[#shots + 1] = {myHead.Position, missPos, nil}
                createBulletTrail(startPos, missPos)
            end
        end
    end
    
    if #shots > 0 then
        ShootEvent:FireServer(shots)
        
        local newAmmo = ammo - 1
        Config.State.currentGun:SetAttribute("Local_CurrentAmmo", newAmmo)
        
        if not Config.State.cachedBulletsLabel then
            local playerGui = Config.LocalPlayer:FindFirstChild("PlayerGui")
            if playerGui then
                local home = playerGui:FindFirstChild("Home")
                if home then
                    local hud = home:FindFirstChild("hud")
                    if hud then
                        local br = hud:FindFirstChild("BottomRightFrame")
                        if br then
                            local gf = br:FindFirstChild("GunFrame")
                            if gf then
                                Config.State.cachedBulletsLabel = gf:FindFirstChild("BulletsLabel")
                            end
                        end
                    end
                end
            end
        end
        
        if Config.State.cachedBulletsLabel then
            Config.State.cachedBulletsLabel.Text = newAmmo .. "/" .. (Config.State.currentGun:GetAttribute("MaxAmmo") or 30)
        end
    end
end

local function getGun()
    local char = Config.LocalPlayer.Character
    if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and tool:GetAttribute("ToolType") == "Gun" then
            return tool
        end
    end
    return nil
end

return {
    getClosest = getClosest,
    getMultipleTargets = getMultipleTargets,
    autoShoot = autoShoot,
    getGun = getGun,
    rollHit = rollHit,
    createBulletTrail = createBulletTrail,
    showHitmarker = showHitmarker,
    getTargetPart = getTargetPart,
}