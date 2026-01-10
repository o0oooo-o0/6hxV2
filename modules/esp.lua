-- ESP.LUA - Box, Skeleton, C4 ESP

local Config = _G.SixHX_Config

local function makeVisuals()
    local container
    if gethui then
        local screen = Instance.new("ScreenGui")
        screen.Name = "SilentAimESP"
        screen.ResetOnSpawn = false
        screen.Parent = gethui()
        container = screen
    elseif syn and syn.protect_gui then
        local screen = Instance.new("ScreenGui")
        screen.Name = "SilentAimESP"
        screen.ResetOnSpawn = false
        syn.protect_gui(screen)
        screen.Parent = Config.Services.CoreGui
        container = screen
    else
        local screen = Instance.new("ScreenGui")
        screen.Name = "SilentAimESP"
        screen.ResetOnSpawn = false
        screen.Parent = Config.Services.CoreGui
        container = screen
    end
    Config.State.visuals.container = container
end

local function makeEsp(player)
    if Config.State.espCache[player] then return Config.State.espCache[player] end
    
    local esp = {
        drawings = {},
        skeleton = {},
        player = player
    }
    
    esp.drawings.box = Drawing.new("Square")
    esp.drawings.box.Visible = false
    esp.drawings.box.Color = Config.Options.ESPBoxColor.Value
    esp.drawings.box.Thickness = 2
    esp.drawings.box.Transparency = 1
    esp.drawings.box.Filled = false
    
    esp.drawings.boxOutline = Drawing.new("Square")
    esp.drawings.boxOutline.Visible = false
    esp.drawings.boxOutline.Color = Color3.new(0, 0, 0)
    esp.drawings.boxOutline.Thickness = 3
    esp.drawings.boxOutline.Transparency = 1
    esp.drawings.boxOutline.Filled = false
    
    esp.drawings.tracer = Drawing.new("Line")
    esp.drawings.tracer.Visible = false
    esp.drawings.tracer.Color = Config.Options.ESPTracerColor.Value
    esp.drawings.tracer.Thickness = 1
    esp.drawings.tracer.Transparency = 1
    
    esp.drawings.name = Drawing.new("Text")
    esp.drawings.name.Visible = false
    esp.drawings.name.Center = true
    esp.drawings.name.Outline = true
    esp.drawings.name.Color = Color3.new(1, 1, 1)
    esp.drawings.name.Size = 13
    esp.drawings.name.Text = player.Name
    
    esp.drawings.distance = Drawing.new("Text")
    esp.drawings.distance.Visible = false
    esp.drawings.distance.Center = true
    esp.drawings.distance.Outline = true
    esp.drawings.distance.Color = Color3.new(1, 1, 1)
    esp.drawings.distance.Size = 13
    
    esp.drawings.healthBar = Drawing.new("Square")
    esp.drawings.healthBar.Visible = false
    esp.drawings.healthBar.Filled = true
    esp.drawings.healthBar.Color = Color3.new(0, 1, 0)
    esp.drawings.healthBar.Thickness = 1
    esp.drawings.healthBar.Transparency = 1
    
    esp.drawings.healthBarOutline = Drawing.new("Square")
    esp.drawings.healthBarOutline.Visible = false
    esp.drawings.healthBarOutline.Filled = false
    esp.drawings.healthBarOutline.Color = Color3.new(0, 0, 0)
    esp.drawings.healthBarOutline.Thickness = 3
    esp.drawings.healthBarOutline.Transparency = 1
    
    local connections = {
        {"Head", "UpperTorso"},
        {"UpperTorso", "LowerTorso"},
        {"UpperTorso", "LeftUpperArm"},
        {"LeftUpperArm", "LeftLowerArm"},
        {"LeftLowerArm", "LeftHand"},
        {"UpperTorso", "RightUpperArm"},
        {"RightUpperArm", "RightLowerArm"},
        {"RightLowerArm", "RightHand"},
        {"LowerTorso", "LeftUpperLeg"},
        {"LeftUpperLeg", "LeftLowerLeg"},
        {"LeftLowerLeg", "LeftFoot"},
        {"LowerTorso", "RightUpperLeg"},
        {"RightUpperLeg", "RightLowerLeg"},
        {"RightLowerLeg", "RightFoot"},
    }
    
    for _, conn in ipairs(connections) do
        local line = Drawing.new("Line")
        line.Visible = false
        line.Color = Config.Options.ESPSkeletonColor.Value
        line.Thickness = 1
        line.Transparency = 1
        
        esp.skeleton[#esp.skeleton + 1] = {
            line = line,
            from = conn[1],
            to = conn[2]
        }
    end
    
    Config.State.espCache[player] = esp
    return esp
end

local function removeEsp(player)
    local esp = Config.State.espCache[player]
    if esp then
        for _, drawing in pairs(esp.drawings) do
            drawing:Remove()
        end
        if esp.skeleton then
            for _, bone in ipairs(esp.skeleton) do
                bone.line:Remove()
            end
        end
        Config.State.espCache[player] = nil
    end
end

local function shouldShowEsp(player)
    if Config.State.panicMode or not player or player == Config.LocalPlayer or not player.Character then return false end
    
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local myChar = Config.LocalPlayer.Character
    if not myChar then return false end
    local myHrp = myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return false end
    
    local distance = (hrp.Position - myHrp.Position).Magnitude
    if distance > Config.Options.ESPMaxDist.Value then return false end
    
    local myTeam = Config.LocalPlayer.Team
    local theirTeam = player.Team
    
    if theirTeam == myTeam then
        if not Config.Toggles.ESPShowTeam.Value then return false end
        return true
    end
    
    if Config.Toggles.ESPTeamCheck.Value then
        local imCrimOrInmate = (myTeam == Config.Teams.Criminals or myTeam == Config.Teams.Inmates)
        local theyCrimOrInmate = (theirTeam == Config.Teams.Criminals or theirTeam == Config.Teams.Inmates)
        if imCrimOrInmate and theyCrimOrInmate then return false end
    end
    
    if theirTeam == Config.Teams.Guards then return Config.Toggles.ESPGuards.Value
    elseif theirTeam == Config.Teams.Inmates then return Config.Toggles.ESPInmates.Value
    elseif theirTeam == Config.Teams.Criminals then return Config.Toggles.ESPCriminals.Value end
    
    return false
end

local function getTeamColor(player)
    if not Config.Toggles.ESPTeamColor.Value then
        return Config.Options.ESPBoxColor.Value
    end
    
    local team = player.Team
    if team == Config.LocalPlayer.Team then
        return Config.Options.ESPTeamColor.Value
    elseif team == Config.Teams.Guards then
        return Config.Options.ESPGuardsColor.Value
    elseif team == Config.Teams.Inmates then
        return Config.Options.ESPInmatesColor.Value
    elseif team == Config.Teams.Criminals then
        return Config.Options.ESPCriminalsColor.Value
    end
    
    return Config.Options.ESPBoxColor.Value
end

local function updateEsp()
    if Config.State.panicMode then return end
    
    local now = tick()
    if now - Config.State.lastEspUpdate < Config.State.ESP_UPDATE_INTERVAL then return end
    Config.State.lastEspUpdate = now
    
    if not Config.Toggles.ESP.Value or not Config.State.visuals.container then
        for _, esp in pairs(Config.State.espCache) do
            for _, drawing in pairs(esp.drawings) do
                drawing.Visible = false
            end
            if esp.skeleton then
                for _, bone in ipairs(esp.skeleton) do
                    bone.line.Visible = false
                end
            end
        end
        return
    end
    
    local camera = workspace.CurrentCamera
    local myChar = Config.LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    if now - Config.State.lastPlayerCacheUpdate > 0.5 then
        Config.State.playerCache = {}
        for _, player in ipairs(Config.Services.Players:GetPlayers()) do
            if player ~= Config.LocalPlayer then
                table.insert(Config.State.playerCache, player)
            end
        end
        Config.State.lastPlayerCacheUpdate = now
    end
    
    for _, player in ipairs(Config.State.playerCache) do
        local show = shouldShowEsp(player)
        
        if show then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            
            if hrp and head and camera then
                local esp = makeEsp(player)
                local teamColor = getTeamColor(player)
                
                local hrpPos, hrpOnScreen = camera:WorldToViewportPoint(hrp.Position)
                local headPos = camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                local legPos = camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                
                if hrpOnScreen and hrpPos.Z > 0 then
                    local height = math.abs(headPos.Y - legPos.Y)
                    local width = height / 2
                    
                    if Config.Toggles.ESPBox.Value then
                        esp.drawings.boxOutline.Size = Vector2.new(width, height)
                        esp.drawings.boxOutline.Position = Vector2.new(hrpPos.X - width / 2, hrpPos.Y - height / 2)
                        esp.drawings.boxOutline.Visible = true
                        
                        esp.drawings.box.Size = Vector2.new(width, height)
                        esp.drawings.box.Position = Vector2.new(hrpPos.X - width / 2, hrpPos.Y - height / 2)
                        esp.drawings.box.Color = teamColor
                        esp.drawings.box.Visible = true
                    else
                        esp.drawings.box.Visible = false
                        esp.drawings.boxOutline.Visible = false
                    end
                    
                    if Config.Toggles.ESPTracers.Value then
                        local screenSize = camera.ViewportSize
                        esp.drawings.tracer.From = Vector2.new(screenSize.X / 2, screenSize.Y)
                        esp.drawings.tracer.To = Vector2.new(hrpPos.X, hrpPos.Y)
                        esp.drawings.tracer.Color = teamColor
                        esp.drawings.tracer.Visible = true
                    else
                        esp.drawings.tracer.Visible = false
                    end
                    
                    if Config.Toggles.ESPName.Value then
                        esp.drawings.name.Position = Vector2.new(hrpPos.X, headPos.Y - 20)
                        esp.drawings.name.Text = player.Name
                        esp.drawings.name.Color = teamColor
                        esp.drawings.name.Visible = true
                    else
                        esp.drawings.name.Visible = false
                    end
                    
                    if Config.Toggles.ESPDistance.Value and myHrp then
                        local dist = math.floor((hrp.Position - myHrp.Position).Magnitude)
                        esp.drawings.distance.Position = Vector2.new(hrpPos.X, legPos.Y + 5)
                        esp.drawings.distance.Text = dist .. "m"
                        esp.drawings.distance.Color = teamColor
                        esp.drawings.distance.Visible = true
                    else
                        esp.drawings.distance.Visible = false
                    end
                    
                    if Config.Toggles.ESPHealthBar.Value and humanoid then
                        local healthPercent = humanoid.Health / humanoid.MaxHealth
                        local barHeight = height
                        local barWidth = 4
                        local barX = hrpPos.X - width / 2 - 8
                        local barY = hrpPos.Y - height / 2
                        
                        esp.drawings.healthBarOutline.Size = Vector2.new(barWidth, barHeight)
                        esp.drawings.healthBarOutline.Position = Vector2.new(barX, barY)
                        esp.drawings.healthBarOutline.Visible = true
                        
                        esp.drawings.healthBar.Size = Vector2.new(barWidth - 2, (barHeight - 2) * healthPercent)
                        esp.drawings.healthBar.Position = Vector2.new(barX + 1, barY + 1 + (barHeight - 2) * (1 - healthPercent))
                        
                        if healthPercent > 0.5 then
                            esp.drawings.healthBar.Color = Color3.new(0, 1, 0)
                        elseif healthPercent > 0.25 then
                            esp.drawings.healthBar.Color = Color3.new(1, 1, 0)
                        else
                            esp.drawings.healthBar.Color = Color3.new(1, 0, 0)
                        end
                        
                        esp.drawings.healthBar.Visible = true
                    else
                        esp.drawings.healthBar.Visible = false
                        esp.drawings.healthBarOutline.Visible = false
                    end
                    
                    if Config.Toggles.ESPSkeleton and Config.Toggles.ESPSkeleton.Value and esp.skeleton then
                        for _, bone in ipairs(esp.skeleton) do
                            local fromPart = char:FindFirstChild(bone.from)
                            local toPart = char:FindFirstChild(bone.to)
                            
                            if fromPart and toPart then
                                local fromPos, fromVis = camera:WorldToViewportPoint(fromPart.Position)
                                local toPos, toVis = camera:WorldToViewportPoint(toPart.Position)
                                
                                if fromVis and toVis and fromPos.Z > 0 and toPos.Z > 0 then
                                    bone.line.From = Vector2.new(fromPos.X, fromPos.Y)
                                    bone.line.To = Vector2.new(toPos.X, toPos.Y)
                                    bone.line.Color = Config.Options.ESPSkeletonColor.Value
                                    bone.line.Visible = true
                                else
                                    bone.line.Visible = false
                                end
                            else
                                bone.line.Visible = false
                            end
                        end
                    else
                        if esp.skeleton then
                            for _, bone in ipairs(esp.skeleton) do
                                bone.line.Visible = false
                            end
                        end
                    end
                else
                    for _, drawing in pairs(esp.drawings) do
                        drawing.Visible = false
                    end
                    if esp.skeleton then
                        for _, bone in ipairs(esp.skeleton) do
                            bone.line.Visible = false
                        end
                    end
                end
            end
        else
            local esp = Config.State.espCache[player]
            if esp then
                for _, drawing in pairs(esp.drawings) do
                    drawing.Visible = false
                end
                if esp.skeleton then
                    for _, bone in ipairs(esp.skeleton) do
                        bone.line.Visible = false
                    end
                end
            end
        end
    end
end

local function makeC4Esp(c4Part)
    if Config.State.c4espCache[c4Part] then return Config.State.c4espCache[c4Part] end
    
    local esp = Instance.new("BillboardGui")
    esp.Name = "C4ESP_" .. tostring(c4Part)
    esp.AlwaysOnTop = true
    esp.Size = UDim2.new(0, 24, 0, 24)
    esp.StudsOffset = Vector3.new(0, 1, 0)
    esp.LightInfluence = 0
    
    local icon = Instance.new("Frame")
    icon.Name = "Icon"
    icon.BackgroundColor3 = Config.Options.C4ESPColor.Value
    icon.BorderSizePixel = 0
    icon.Size = UDim2.new(0, 14, 0, 14)
    icon.Position = UDim2.new(0.5, -7, 0.5, -7)
    icon.Rotation = 45
    icon.Parent = esp
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(0, 0, 0)
    stroke.Thickness = 2
    stroke.Transparency = 0.2
    stroke.Parent = icon
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0, 60, 0, 14)
    label.Position = UDim2.new(0.5, -30, 1, 2)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0.5
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Text = "C4"
    label.Parent = esp
    
    local distLabel = Instance.new("TextLabel")
    distLabel.Name = "DistLabel"
    distLabel.BackgroundTransparency = 1
    distLabel.Size = UDim2.new(0, 60, 0, 12)
    distLabel.Position = UDim2.new(0.5, -30, 1, 16)
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextSize = 10
    distLabel.TextColor3 = Config.Options.C4ESPColor.Value
    distLabel.TextStrokeTransparency = 0.5
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.Text = ""
    distLabel.Parent = esp
    
    Config.State.c4espCache[c4Part] = esp
    return esp
end

local function isC4Part(part)
    if not part or not part:IsA("BasePart") then return false end
    local name = part.Name:lower()
    local parentName = part.Parent and part.Parent.Name:lower() or ""
    return name == "explosive" or name == "c4" or name == "clientc4" or 
        parentName:find("c4") or name:find("c4")
end

local function onDescendantAdded(desc)
    if isC4Part(desc) then
        Config.State.trackedC4s[desc] = true
    end
end

local function onDescendantRemoving(desc)
    Config.State.trackedC4s[desc] = nil
    if Config.State.c4espCache[desc] then
        Config.State.c4espCache[desc]:Destroy()
        Config.State.c4espCache[desc] = nil
    end
end

local function updateC4Esp()
    if Config.State.panicMode or not Config.Toggles.C4ESP.Value or not Config.State.visuals.container then
        for _, e in pairs(Config.State.c4espCache) do e.Parent = nil end
        return
    end
    
    local myChar = Config.LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    for part in pairs(Config.State.trackedC4s) do
        if part and part:IsDescendantOf(workspace) then
            local dist = 0
            if myHrp then
                dist = (part.Position - myHrp.Position).Magnitude
            end
            
            if dist <= Config.Options.C4ESPMaxDist.Value then
                local esp = makeC4Esp(part)
                esp.Adornee = part
                esp.Parent = Config.State.visuals.container
                
                if Config.Toggles.C4ESPShowDist.Value and myHrp then
                    local distLabel = esp:FindFirstChild("DistLabel")
                    if distLabel then
                        distLabel.Text = math.floor(dist) .. "m"
                    end
                end
            else
                local e = Config.State.c4espCache[part]
                if e then e.Parent = nil end
            end
        else
            Config.State.trackedC4s[part] = nil
            if Config.State.c4espCache[part] then
                Config.State.c4espCache[part]:Destroy()
                Config.State.c4espCache[part] = nil
            end
        end
    end
end

local function setupC4Tracking()
    for _, desc in ipairs(workspace:GetDescendants()) do
        if isC4Part(desc) then Config.State.trackedC4s[desc] = true end
    end
    workspace.DescendantAdded:Connect(onDescendantAdded)
    workspace.DescendantRemoving:Connect(onDescendantRemoving)
end

return {
    makeVisuals = makeVisuals,
    makeEsp = makeEsp,
    removeEsp = removeEsp,
    updateEsp = updateEsp,
    updateC4Esp = updateC4Esp,
    setupC4Tracking = setupC4Tracking,
}