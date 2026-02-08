
local repo = 'https://raw.githubusercontent.com/deividcomsono/Obsidian/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Options = Library.Options
local Toggles = Library.Toggles

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local Teams = game:GetService("Teams")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local wl = {
	["maxxxxxxxxeeee"] = true,
	["Xqvrenolathyxirav"] = true,
	["pipikiwibrainrots12"] = true,
	["ConfessOrPerish"] = true,
	["Zynqoravelit"] = true,
	["HieloConCocaCola77"] = true,
	["ConfessOrPerish0"] = true,
}

local function WLCHECK()
	local name = LocalPlayer.Name
	if not wl[name] then
		task.wait(0.1)
		LocalPlayer:Kick("no authorization to use this, sorry -f3kel666")
	end
end

WLCHECK()

LocalPlayer:GetPropertyChangedSignal("Name"):Connect(WLCHECK)
local guardsTeam = Teams:FindFirstChild("Guards")
local inmatesTeam = Teams:FindFirstChild("Inmates")
local criminalsTeam = Teams:FindFirstChild("Criminals")

local cfg = {
    enabled = true,
    teamcheck = true,
    wallcheck = true,
    deathcheck = true,
    ffcheck = true,
    hostilecheck = false,
    trespasscheck = false,
    vehiclecheck = true,
    criminalsnoinnmates = true,
    inmatesnocriminals = true,
    shieldbreaker = true,
    shieldfrontangle = 0.3,
    shieldrandomhead = true,
    shieldheadchance = 30,
    taserbypasshostile = true,
    taserbypasstrespass = true,
    taseralwayshit = true,
    ifplayerstill = false,
    stillthreshold = 0.5,
    hitchance = 40,
    hitchanceAutoOnly = false,
    autoshoot = true,
    autoshootdelay = 0,
    autoshootstartdelay = 0,
    rapidfireburst = 50,
    missspread = 5,
    shotgunnaturalspread = true,
    shotgungamehandled = false,
    gunmods = {},
    gunmodsselected = {
        ["Revolver"] = false,
        ["M100"] = false,
        ["MP5"] = false,
        ["AK-47"] = false,
        ["Remington 870"] = false,
        ["FAL"] = false,
        ["M4A1"] = false,
        ["M9"] = false,
    },
    arrestaura = false,
    arrestaurarange = 50,
    arrestauradelay = 0.1,
    autofirerate = false,
    prioritizeclosest = true,
    targetstickiness = false,
    targetstickinessduration = 0.6,
    targetstickinessrandom = false,
    targetstickinessmin = 0.3,
    targetstickinessmax = 0.7,
    fov = 150,
    showfov = true,
    fovcolor = Color3.fromRGB(255, 0, 0),
    fovthickness = 2,
    fovtransparency = 0.8,
    fovfilled = false,
    fovfilledcolor = Color3.fromRGB(255, 0, 0),
    fovfilledtransparency = 0.9,
    fovnumsides = 64,
    showtargetline = false,
    targetlinecolor = Color3.fromRGB(255, 255, 0),
    targetlinethickness = 2,
    targetlinetransparency = 1,
    espboxcolor = Color3.fromRGB(255, 255, 255),
    espboxthickness = 1,
    espskeletoncolor = Color3.fromRGB(255, 255, 255),
    espskeletonthickness = 1,
    esptracercolor = Color3.fromRGB(255, 255, 255),
    esptracerthickness = 1,
    esphealthbaroutline = true,
    esphealthbaroutlinecolor = Color3.fromRGB(0, 0, 0),
    esptextsize = 13,
    esptextoutline = true,
    aimbotmode = "Mouse", 
    aimpart = "Head",
    randomparts = true,
    partslist = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "HumanoidRootPart"},
    esp = true,
    espteamcheck = true,
    espshowteam = false,
    esptargets = {guards = true, inmates = true, criminals = true},
    espmaxdist = 500,
    espshowdist = true,
    espcolor = Color3.fromRGB(0, 170, 255),
    espguards = Color3.fromRGB(0, 170, 255),
    espinmates = Color3.fromRGB(255, 150, 50),
    espcriminals = Color3.fromRGB(255, 60, 60),
    espteam = Color3.fromRGB(60, 255, 60),
    espuseteamcolors = true,
    c4esp = true,
    c4espcolor = Color3.fromRGB(80, 255, 80),
    c4espmaxdist = 200,
    c4espshowdist = true,
    killsound = true,
    killsoundid = "rbxassetid://5043636498",
    killsoundvolume = 0.5,
    killeffect = true,
    killeffectimage = "rbxassetid://112691580111061",
    killeffectsize = 5,
    killeffecttilt = true,
    killeffecttiltspeed = 0.5,
    hitnotifications = true,
    playertrail = false,
    trailcolor = Color3.fromRGB(255, 0, 255),
    traillifetime = 2,
    trailtransparency = 0.5,
    bullettracers = true,
    tracercolor = Color3.fromRGB(255, 255, 0),
    tracerduration = 0.5,
    tracertransparency = 0.5,
    tracerthickness = 0.1,
    tracerfade = true,
    noclip = false,
    infinitejump = false,
    noaccel = false,
    bunnyhop = false,
    walkspeed = 16,
    walkspeedenabled = false,
    jumppower = 50,
    jumppowerenabled = false,
    jumpcircle = false,
    jumpcircledecal = "rbxassetid://112096280571499",
    jumpcirclesize = 5,
    jumpcirclegrowtime = 1.2,
    jumpcirclefadetime = 1.8,
    espboxes = true,
    espskeleton = false,
    esptracers = false,
    esphealthbar = true,
    esphealthtext = true,
    jitter = false,
    jitterangle = 40,
    backtrack = false,
    backtrackping = 1,
    backtrackcolor = Color3.fromRGB(255, 100, 255),
    backtrackrainbow = false,
    backtracktransparency = 0.5,
    backtrackskeleton = true,
    fpsboost = {
        notextures = false,
        nodecals = false,
        noparticles = false,
        nosky = false,
        lowquality = false,
        noshadows = false,
        nightmode = false,
    },
    chams = false,
    chamsmaterial = "ForceField",
    chamscolor = Color3.fromRGB(255, 100, 255),
    chamstransparency = 0.3,
    glowesp = false,
    glowcolor = Color3.fromRGB(255, 100, 255),
    glowtransparency = 0,
    glowfill = Color3.fromRGB(0, 0, 0),
    glowfilltransparency = 0.5,
    headdot = false,
    headdotcolor = Color3.fromRGB(255, 0, 0),
    headdotsize = 0.5,
    
    killsay = false,
    killsayphrases = {
        "sit {DISPLAYNAME}",
        "ez {DISPLAYNAME}",
        "get good {DISPLAYNAME}",
        "owned {DISPLAYNAME}",
        "gg {DISPLAYNAME}",
    },
    showstats = false,
    statsx = 10,
    statsy = 200,
    fly = false,
    flyspeed = 50,
    highjump = false,
    highjumppower = 100,
    jumpboost = false,
    jumpboostpower = 50,
    statsdraggable = true,
    statsbackgroundcolor = Color3.fromRGB(20, 20, 20),
    statstextcolor = Color3.fromRGB(255, 255, 255),
    statstitlecolor = Color3.fromRGB(255, 100, 255),
    watermarkcolor = Color3.fromRGB(255, 255, 255),
    speedboost = false,
    speedboostkey = Enum.KeyCode.V,
    speedboostamount = 100,
}

local wallParams = RaycastParams.new()
wallParams.FilterType = Enum.RaycastFilterType.Exclude
wallParams.IgnoreWater = true
wallParams.RespectCanCollide = false
wallParams.CollisionGroup = "ClientBullet"

local currentGun = nil
local rng = Random.new()
local lastShotTime = 0
local lastShotResult = false
local shotCooldown = 0.15
local currentTarget = nil
local targetSwitchTime = 0
local currentStickiness = 0
local lastAutoShoot = 0
local targetAcquiredTime = 0
local lastAutoTarget = nil
local cachedBulletsLabel = nil
local lastGun = nil

local trackedTargets = {}
local killEffects = {}

local sessionStats = {
    kills = 0,
    deaths = 0,
    currentStreak = 0,
    bestStreak = 0,
    shotsHit = 0,
    shotsFired = 0,
}

local fovCircle = Drawing.new("Circle")
fovCircle.Color = cfg.fovcolor
fovCircle.Radius = cfg.fov
fovCircle.Transparency = cfg.fovtransparency
fovCircle.Filled = cfg.fovfilled
fovCircle.NumSides = cfg.fovnumsides
fovCircle.Thickness = cfg.fovthickness
fovCircle.Visible = cfg.showfov and cfg.enabled

local targetLine = Drawing.new("Line")
targetLine.Color = cfg.targetlinecolor
targetLine.Thickness = cfg.targetlinethickness
targetLine.Transparency = cfg.targetlinetransparency
targetLine.Visible = false

local visuals = {container = nil}
local espCache = {}
local c4espCache = {}
local trackedC4s = {}

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
        screen.Parent = CoreGui
        container = screen
    else
        local screen = Instance.new("ScreenGui")
        screen.Name = "SilentAimESP"
        screen.ResetOnSpawn = false
        screen.Parent = CoreGui
        container = screen
    end
    visuals.container = container
end

local function makeEsp(player)
    if espCache[player] then return espCache[player] end
    
    local esp = Instance.new("BillboardGui")
    esp.Name = "ESP_" .. player.Name
    esp.AlwaysOnTop = true
    esp.Size = UDim2.new(0, 200, 0, 50)
    esp.StudsOffset = Vector3.new(0, 3, 0)
    esp.LightInfluence = 0
    
    local diamond = Instance.new("Frame")
    diamond.Name = "Diamond"
    diamond.BackgroundColor3 = cfg.espcolor
    diamond.BorderSizePixel = 0
    diamond.Size = UDim2.new(0, 10, 0, 10)
    diamond.Position = UDim2.new(0.5, -5, 0.5, -5)
    diamond.Rotation = 45
    diamond.Parent = esp
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(0, 0, 0)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.3
    stroke.Parent = diamond
    
    local distLabel = Instance.new("TextLabel")
    distLabel.Name = "DistanceLabel"
    distLabel.BackgroundTransparency = 1
    distLabel.Size = UDim2.new(0, 60, 0, 16)
    distLabel.Position = UDim2.new(0.5, -30, 1, 2)
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextSize = cfg.esptextsize
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextStrokeTransparency = cfg.esptextoutline and 0.5 or 1
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.Text = ""
    distLabel.Parent = esp
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(0, 100, 0, 14)
    nameLabel.Position = UDim2.new(0.5, -50, 0, -16)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = cfg.esptextsize
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextStrokeTransparency = cfg.esptextoutline and 0.5 or 1
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.Text = player.Name
    nameLabel.Parent = esp
    
    local healthBarBg = Instance.new("Frame")
    healthBarBg.Name = "HealthBarBg"
    healthBarBg.BackgroundColor3 = cfg.esphealthbaroutline and cfg.esphealthbaroutlinecolor or Color3.new(0, 0, 0)
    healthBarBg.BorderSizePixel = 0
    healthBarBg.Size = UDim2.new(0, 100, 0, 4)
    healthBarBg.Position = UDim2.new(0.5, -50, 0, -28)
    healthBarBg.Visible = cfg.esphealthbar
    healthBarBg.Parent = esp
    
    local healthBar = Instance.new("Frame")
    healthBar.Name = "HealthBar"
    healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthBar.BorderSizePixel = 0
    healthBar.Size = UDim2.new(1, 0, 1, 0)
    healthBar.Parent = healthBarBg
    
    local healthText = Instance.new("TextLabel")
    healthText.Name = "HealthText"
    healthText.BackgroundTransparency = 1
    healthText.Size = UDim2.new(0, 50, 0, 14)
    healthText.Position = UDim2.new(0.5, -25, 0, -40)
    healthText.Font = Enum.Font.GothamBold
    healthText.TextSize = cfg.esptextsize - 2
    healthText.TextColor3 = Color3.new(1, 1, 1)
    healthText.TextStrokeTransparency = cfg.esptextoutline and 0.5 or 1
    healthText.TextStrokeColor3 = Color3.new(0, 0, 0)
    healthText.Text = "100"
    healthText.Visible = cfg.esphealthtext
    healthText.Parent = esp
    
    espCache[player] = {
        billboard = esp,
        diamond = diamond,
        distLabel = distLabel,
        nameLabel = nameLabel,
        healthBarBg = healthBarBg,
        healthBar = healthBar,
        healthText = healthText,
        box = nil,
        skeleton = {},
        tracer = nil
    }
    
    return espCache[player]
end

local function removeEsp(player)
    local e = espCache[player]
    if e then 
        if e.billboard then e.billboard:Destroy() end
        if e.box then e.box:Destroy() end
        if e.tracer then e.tracer:Destroy() end
        for _, part in ipairs(e.skeleton) do
            if part then part:Destroy() end
        end
        espCache[player] = nil 
    end
end

local function shouldShowEsp(player)
    if not player or player == LocalPlayer or not player.Character then return false end
    
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local myChar = LocalPlayer.Character
    if not myChar then return false end
    local myHrp = myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return false end
    
    local distance = (hrp.Position - myHrp.Position).Magnitude
    if distance > cfg.espmaxdist then return false end
    
    local myTeam = LocalPlayer.Team
    local theirTeam = player.Team
    
    if theirTeam == myTeam then
        if not cfg.espshowteam then return false end
        return true
    end
    
    if cfg.espteamcheck then
        local imCrimOrInmate = (myTeam == criminalsTeam or myTeam == inmatesTeam)
        local theyCrimOrInmate = (theirTeam == criminalsTeam or theirTeam == inmatesTeam)
        if imCrimOrInmate and theyCrimOrInmate then return false end
    end
    
    if theirTeam == guardsTeam then return cfg.esptargets.guards
    elseif theirTeam == inmatesTeam then return cfg.esptargets.inmates
    elseif theirTeam == criminalsTeam then return cfg.esptargets.criminals end
    
    return false
end

local function createESPBox(character, color)
    if not cfg.espboxes then return nil end
    
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = cfg.espboxcolor
    box.Thickness = cfg.espboxthickness
    box.Transparency = 1
    box.Filled = false
    
    return box
end

local function createESPSkeleton(character, color)
    if not cfg.espskeleton then return {} end
    
    local skeleton = {}
    
    for i = 1, 6 do
        local line = Drawing.new("Line")
        line.Visible = false
        line.Color = cfg.espskeletoncolor
        line.Thickness = cfg.espskeletonthickness
        line.Transparency = 1
        table.insert(skeleton, line)
    end
    
    return skeleton
end

local function createESPTracer(color)
    if not cfg.esptracers then return nil end
    
    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = cfg.esptracercolor
    tracer.Thickness = cfg.esptracerthickness
    tracer.Transparency = 1
    
    return tracer
end

local function updateESPBox(box, character)
    if not box or not cfg.espboxes then return end
    
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then 
        box.Visible = false
        return 
    end
    
    local size = character:GetExtentsSize()
    local corners = {
        hrp.CFrame * CFrame.new(-size.X/2, size.Y/2, 0),
        hrp.CFrame * CFrame.new(size.X/2, size.Y/2, 0),
        hrp.CFrame * CFrame.new(-size.X/2, -size.Y/2, 0),
        hrp.CFrame * CFrame.new(size.X/2, -size.Y/2, 0)
    }
    
    local screenCorners = {}
    for _, corner in ipairs(corners) do
        local screenPos, onScreen = camera:WorldToViewportPoint(corner.Position)
        if not onScreen then
            box.Visible = false
            return
        end
        table.insert(screenCorners, Vector2.new(screenPos.X, screenPos.Y))
    end
    
    local minX = math.min(screenCorners[1].X, screenCorners[2].X, screenCorners[3].X, screenCorners[4].X)
    local maxX = math.max(screenCorners[1].X, screenCorners[2].X, screenCorners[3].X, screenCorners[4].X)
    local minY = math.min(screenCorners[1].Y, screenCorners[2].Y, screenCorners[3].Y, screenCorners[4].Y)
    local maxY = math.max(screenCorners[1].Y, screenCorners[2].Y, screenCorners[3].Y, screenCorners[4].Y)
    
    box.Size = Vector2.new(maxX - minX, maxY - minY)
    box.Position = Vector2.new(minX, minY)
    box.Color = cfg.espboxcolor
    box.Thickness = cfg.espboxthickness
    box.Visible = true
end

local function updateESPSkeleton(skeleton, character, color)
    if not skeleton or #skeleton == 0 or not cfg.espskeleton then return end
    
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    local head = character:FindFirstChild("Head")
    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
    local leftArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftUpperArm")
    local rightArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightUpperArm")
    local leftLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftUpperLeg")
    local rightLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightUpperLeg")
    
    if not (head and torso and leftArm and rightArm and leftLeg and rightLeg) then
        for _, line in ipairs(skeleton) do
            line.Visible = false
        end
        return
    end
    
    local connections = {
        {head, torso},
        {torso, leftArm},
        {torso, rightArm},
        {torso, leftLeg},
        {torso, rightLeg},
        {leftArm, rightArm}
    }
    
    for i, connection in ipairs(connections) do
        if skeleton[i] then
            local pos1, onScreen1 = camera:WorldToViewportPoint(connection[1].Position)
            local pos2, onScreen2 = camera:WorldToViewportPoint(connection[2].Position)
            
            if onScreen1 and onScreen2 then
                skeleton[i].From = Vector2.new(pos1.X, pos1.Y)
                skeleton[i].To = Vector2.new(pos2.X, pos2.Y)
                skeleton[i].Color = cfg.espskeletoncolor
                skeleton[i].Thickness = cfg.espskeletonthickness
                skeleton[i].Visible = true
            else
                skeleton[i].Visible = false
            end
        end
    end
end

local function updateESPTracer(tracer, character, color)
    if not tracer or not cfg.esptracers then return end
    
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        tracer.Visible = false
        return
    end
    
    local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
    if not onScreen then
        tracer.Visible = false
        return
    end
    
    local viewportSize = camera.ViewportSize
    tracer.From = Vector2.new(viewportSize.X / 2, viewportSize.Y)
    tracer.To = Vector2.new(screenPos.X, screenPos.Y)
    tracer.Color = cfg.esptracercolor
    tracer.Thickness = cfg.esptracerthickness
    tracer.Visible = true
end

local function updateEsp()
    if not cfg.esp or not visuals.container then
        for _, e in pairs(espCache) do 
            if e.billboard then e.billboard.Parent = nil end
            if e.box then e.box.Visible = false end
            if e.tracer then e.tracer.Visible = false end
            for _, line in ipairs(e.skeleton) do
                if line then line.Visible = false end
            end
        end
        return
    end
    
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    for _, player in ipairs(Players:GetPlayers()) do
        local show = shouldShowEsp(player)
        
        if show then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            
            if hrp and head then
                local espData = makeEsp(player)
                espData.billboard.Adornee = head
                espData.billboard.Parent = visuals.container
                
   
                local espColor = cfg.espcolor
                if cfg.espuseteamcolors then
                    local t = player.Team
                    if t == LocalPlayer.Team then espColor = cfg.espteam
                    elseif t == guardsTeam then espColor = cfg.espguards
                    elseif t == inmatesTeam then espColor = cfg.espinmates
                    elseif t == criminalsTeam then espColor = cfg.espcriminals
                    end
                end
                
                espData.diamond.BackgroundColor3 = espColor
                
           
                if cfg.espshowdist and myHrp then
                    espData.distLabel.Text = math.floor((hrp.Position - myHrp.Position).Magnitude) .. "m"
                    espData.distLabel.Visible = true
                else
                    espData.distLabel.Visible = false
                end
                
                if humanoid and cfg.esphealthbar then
                    local healthPercent = humanoid.Health / humanoid.MaxHealth
                    espData.healthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
                    espData.healthBar.BackgroundColor3 = Color3.fromRGB(
                        255 * (1 - healthPercent),
                        255 * healthPercent,
                        0
                    )
                    espData.healthBarBg.Visible = true
                else
                    espData.healthBarBg.Visible = false
                end
                
                if humanoid and cfg.esphealthtext then
                    espData.healthText.Text = math.floor(humanoid.Health)
                    espData.healthText.Visible = true
                else
                    espData.healthText.Visible = false
                end
                
                if cfg.espboxes then
                    if not espData.box then
                        espData.box = createESPBox(char, espColor)
                    end
                    updateESPBox(espData.box, char)
                    if espData.box then
                        espData.box.Color = espColor
                    end
                elseif espData.box then
                    espData.box.Visible = false
                end
                
                if cfg.espskeleton then
                    if #espData.skeleton == 0 then
                        espData.skeleton = createESPSkeleton(char, espColor)
                    end
                    updateESPSkeleton(espData.skeleton, char, espColor)
                else
                    for _, line in ipairs(espData.skeleton) do
                        if line then line.Visible = false end
                    end
                end
                
                if cfg.esptracers then
                    if not espData.tracer then
                        espData.tracer = createESPTracer(espColor)
                    end
                    updateESPTracer(espData.tracer, char, espColor)
                else
                    if espData.tracer then
                        espData.tracer.Visible = false
                    end
                end
            end
        else
            local e = espCache[player]
            if e then 
                if e.billboard then e.billboard.Parent = nil end
                if e.box then e.box.Visible = false end
                if e.tracer then e.tracer.Visible = false end
                for _, line in ipairs(e.skeleton) do
                    if line then line.Visible = false end
                end
            end
        end
    end
end

local function makeC4Esp(c4Part)
    if c4espCache[c4Part] then return c4espCache[c4Part] end
    
    local esp = Instance.new("BillboardGui")
    esp.Name = "C4ESP_" .. tostring(c4Part)
    esp.AlwaysOnTop = true
    esp.Size = UDim2.new(0, 24, 0, 24)
    esp.StudsOffset = Vector3.new(0, 1, 0)
    esp.LightInfluence = 0
    
    local icon = Instance.new("Frame")
    icon.Name = "Icon"
    icon.BackgroundColor3 = cfg.c4espcolor
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
    distLabel.TextColor3 = cfg.c4espcolor
    distLabel.TextStrokeTransparency = 0.5
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.Text = ""
    distLabel.Parent = esp
    
    c4espCache[c4Part] = esp
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
    if isC4Part(desc) then trackedC4s[desc] = true end
end

local function onDescendantRemoving(desc)
    trackedC4s[desc] = nil
    if c4espCache[desc] then
        c4espCache[desc]:Destroy()
        c4espCache[desc] = nil
    end
end

for _, desc in ipairs(workspace:GetDescendants()) do
    if isC4Part(desc) then trackedC4s[desc] = true end
end
workspace.DescendantAdded:Connect(onDescendantAdded)
workspace.DescendantRemoving:Connect(onDescendantRemoving)

local function updateC4Esp()
    if not cfg.c4esp or not visuals.container then
        for _, e in pairs(c4espCache) do e.Parent = nil end
        return
    end
    
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    for part in pairs(trackedC4s) do
        if part and part:IsDescendantOf(workspace) then
            local dist = 0
            if myHrp then dist = (part.Position - myHrp.Position).Magnitude end
            
            if dist <= cfg.c4espmaxdist then
                local esp = makeC4Esp(part)
                esp.Adornee = part
                esp.Parent = visuals.container
                
                if cfg.c4espshowdist and myHrp then
                    local distLabel = esp:FindFirstChild("DistLabel")
                    if distLabel then distLabel.Text = math.floor(dist) .. "m" end
                end
            else
                local e = c4espCache[part]
                if e then e.Parent = nil end
            end
        else
            trackedC4s[part] = nil
            if c4espCache[part] then
                c4espCache[part]:Destroy()
                c4espCache[part] = nil
            end
        end
    end
end

makeVisuals()

local chamsCache = {}
local glowCache = {}
local headdotCache = {}

local function createChams(character)
    if not cfg.chams then return end
    if chamsCache[character] then return end
    
    local chams = {}
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            local clone = part:Clone()
            clone.CanCollide = false
            clone.Anchored = false
            clone.Material = Enum.Material[cfg.chamsmaterial]
            clone.Color = cfg.chamscolor
            clone.Transparency = cfg.chamstransparency
            clone.CastShadow = false
            clone:ClearAllChildren()
            
            local weld = Instance.new("Weld")
            weld.Part0 = part
            weld.Part1 = clone
            weld.Parent = clone
            
            clone.Parent = character
            table.insert(chams, clone)
        end
    end
    
    chamsCache[character] = chams
end

local function removeChams(character)
    if chamsCache[character] then
        for _, cham in ipairs(chamsCache[character]) do
            cham:Destroy()
        end
        chamsCache[character] = nil
    end
end

local function createGlowESP(character)
    if not cfg.glowesp then return end
    if glowCache[character] then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "GlowESP"
    highlight.Adornee = character
    highlight.FillColor = cfg.glowfill
    highlight.FillTransparency = cfg.glowfilltransparency
    highlight.OutlineColor = cfg.glowcolor
    highlight.OutlineTransparency = cfg.glowtransparency
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    
    glowCache[character] = highlight
end

local function removeGlowESP(character)
    if glowCache[character] then
        glowCache[character]:Destroy()
        glowCache[character] = nil
    end
end

local function createHeadDot(character)
    if not cfg.headdot then return end
    if headdotCache[character] then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    local dot = Instance.new("Part")
    dot.Name = "HeadDot"
    dot.Size = Vector3.new(cfg.headdotsize, cfg.headdotsize, cfg.headdotsize)
    dot.Shape = Enum.PartType.Ball
    dot.Color = cfg.headdotcolor
    dot.Material = Enum.Material.Neon
    dot.CanCollide = false
    dot.Anchored = false
    dot.CastShadow = false
    
    local weld = Instance.new("Weld")
    weld.Part0 = head
    weld.Part1 = dot
    weld.C0 = CFrame.new(0, 0, 0)
    weld.Parent = dot
    
    dot.Parent = character
    
    headdotCache[character] = dot
end

local function removeHeadDot(character)
    if headdotCache[character] then
        headdotCache[character]:Destroy()
        headdotCache[character] = nil
    end
end

local function setupAdvancedESP(player)
    if player == LocalPlayer then return end
    
    local function onCharacterAdded(character)
        task.wait(0.5)
        createChams(character)
        createGlowESP(character)
        createHeadDot(character)
        
        character.AncestryChanged:Connect(function()
            if not character:IsDescendantOf(workspace) then
                removeChams(character)
                removeGlowESP(character)
                removeHeadDot(character)
            end
        end)
    end
    
    if player.Character then
        onCharacterAdded(player.Character)
    end
    player.CharacterAdded:Connect(onCharacterAdded)
end

for _, player in ipairs(Players:GetPlayers()) do
    setupAdvancedESP(player)
end

Players.PlayerAdded:Connect(setupAdvancedESP)

local function updateAllAdvancedESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player ~= LocalPlayer then
            removeChams(player.Character)
            removeGlowESP(player.Character)
            removeHeadDot(player.Character)
            
            if cfg.chams then createChams(player.Character) end
            if cfg.glowesp then createGlowESP(player.Character) end
            if cfg.headdot then createHeadDot(player.Character) end
        end
    end
end

local playerTrail = nil

local function createPlayerTrail()
    if not cfg.playertrail then 
        if playerTrail then
            playerTrail:Destroy()
            playerTrail = nil
        end
        return 
    end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if playerTrail then playerTrail:Destroy() end
    
    local trail = Instance.new("Trail")
    trail.Name = "PlayerTrail"
    trail.Lifetime = cfg.traillifetime
    trail.Color = ColorSequence.new(cfg.trailcolor)
    trail.Transparency = NumberSequence.new(cfg.trailtransparency, 1)
    trail.LightEmission = 0.5
    trail.FaceCamera = true
    trail.WidthScale = NumberSequence.new(1)
    trail.MinLength = 0
    
    local attach0 = Instance.new("Attachment")
    attach0.Name = "TrailAttach0"
    attach0.Position = Vector3.new(-0.5, 0, 0)
    attach0.Parent = hrp
    
    local attach1 = Instance.new("Attachment")
    attach1.Name = "TrailAttach1"
    attach1.Position = Vector3.new(0.5, 0, 0)
    attach1.Parent = hrp
    
    trail.Attachment0 = attach0
    trail.Attachment1 = attach1
    trail.Parent = hrp
    
    playerTrail = trail
end

local statsGui = nil

local function createStatsGUI()
    if statsGui then statsGui:Destroy() end
    if not cfg.showstats then return end
    
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    statsGui = Instance.new("ScreenGui")
    statsGui.Name = "SessionStatsGUI"
    statsGui.ResetOnSpawn = false
    statsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    statsGui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Name = "StatsFrame"
    frame.Size = UDim2.new(0, 220, 0, 140)
    frame.Position = UDim2.new(0, cfg.statsx, 0, cfg.statsy)
    frame.BackgroundColor3 = cfg.statsbackgroundcolor
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.3
    frame.Parent = statsGui
    
    if cfg.statsdraggable then
        local dragging = false
        local dragInput, mousePos, framePos
        
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                mousePos = input.Position
                framePos = frame.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - mousePos
                frame.Position = UDim2.new(
                    framePos.X.Scale,
                    framePos.X.Offset + delta.X,
                    framePos.Y.Scale,
                    framePos.Y.Offset + delta.Y
                )
            end
        end)
    end
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 25)
    title.BackgroundTransparency = 1
    title.Text = "SESSION STATS"
    title.TextColor3 = cfg.statstitlecolor
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = frame
    
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Name = "StatsLabel"
    statsLabel.Size = UDim2.new(1, -20, 1, -35)
    statsLabel.Position = UDim2.new(0, 10, 0, 30)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Text = ""
    statsLabel.TextColor3 = cfg.statstextcolor
    statsLabel.Font = Enum.Font.Code
    statsLabel.TextSize = 12
    statsLabel.TextXAlignment = Enum.TextXAlignment.Left
    statsLabel.TextYAlignment = Enum.TextYAlignment.Top
    statsLabel.Parent = frame
    
    RunService.RenderStepped:Connect(function()
        if not cfg.showstats then return end
        if not statsLabel or not statsLabel.Parent then return end
        
        local kd = sessionStats.deaths > 0 
            and string.format("%.2f", sessionStats.kills / sessionStats.deaths) 
            or tostring(sessionStats.kills)
        
        local accuracy = sessionStats.shotsFired > 0 
            and string.format("%.1f%%", (sessionStats.shotsHit / sessionStats.shotsFired) * 100)
            or "0%"
        
        statsLabel.Text = string.format(
            "Kills: %d\nDeaths: %d\nK/D: %s\nStreak: %d\nBest: %d\nAccuracy: %s",
            sessionStats.kills,
            sessionStats.deaths,
            kd,
            sessionStats.currentStreak,
            sessionStats.bestStreak,
            accuracy
        )
        
        frame.BackgroundColor3 = cfg.statsbackgroundcolor
        title.TextColor3 = cfg.statstitlecolor
        statsLabel.TextColor3 = cfg.statstextcolor
    end)
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    createPlayerTrail()
end)

if LocalPlayer.Character then
    createPlayerTrail()
end
createStatsGUI()

local noclipConnection = nil
local jumpConnection = nil
local noAccelConnection = nil
local bhopConnection = nil

local function setupNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    
    if not cfg.noclip then return end
    
    noclipConnection = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function setupInfiniteJump()
    if jumpConnection then
        jumpConnection:Disconnect()
        jumpConnection = nil
    end
    
    if not cfg.infinitejump then return end
    
    jumpConnection = UserInputService.JumpRequest:Connect(function()
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end

local function setupNoAccel()
    if noAccelConnection then
        noAccelConnection:Disconnect()
        noAccelConnection = nil
    end
    
    if not cfg.noaccel then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end
    
    noAccelConnection = RunService.RenderStepped:Connect(function()
        if humanoid.Health <= 0 then return end
        if humanoid.SeatPart then return end
        
        local moveDir = humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            local speed = humanoid.WalkSpeed
            root.AssemblyLinearVelocity = Vector3.new(
                moveDir.X * speed,
                root.AssemblyLinearVelocity.Y,
                moveDir.Z * speed
            )
        end
    end)
end

local function setupBunnyHop()
    if bhopConnection then
        bhopConnection:Disconnect()
        bhopConnection = nil
    end
    
    if not cfg.bunnyhop then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    bhopConnection = RunService.Heartbeat:Connect(function()
        if humanoid.FloorMaterial ~= Enum.Material.Air and humanoid.MoveDirection.Magnitude > 0 then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local function setupWalkSpeed()
    RunService.Heartbeat:Connect(function()
        if not cfg.walkspeedenabled then return end
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = cfg.walkspeed
            end
        end
    end)
end

local function setupJumpPower()
    RunService.Heartbeat:Connect(function()
        if not cfg.jumppowerenabled then return end
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = cfg.jumppower
            end
        end
    end)
end

local flyConnection = nil
local flyBV = nil
local flyBG = nil

local function setupFly()
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
    
    if not cfg.fly then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    flyBV = Instance.new("BodyVelocity")
    flyBV.Velocity = Vector3.new(0, 0, 0)
    flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyBV.Parent = hrp
    
    flyBG = Instance.new("BodyGyro")
    flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    flyBG.CFrame = hrp.CFrame
    flyBG.Parent = hrp
    
    flyConnection = RunService.Heartbeat:Connect(function()
        if not cfg.fly then
            if flyBV then flyBV:Destroy() flyBV = nil end
            if flyBG then flyBG:Destroy() flyBG = nil end
            if flyConnection then flyConnection:Disconnect() flyConnection = nil end
            return
        end
        
        local cam = workspace.CurrentCamera
        local move = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            move = move + (cam.CFrame.LookVector * cfg.flyspeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            move = move - (cam.CFrame.LookVector * cfg.flyspeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            move = move - (cam.CFrame.RightVector * cfg.flyspeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            move = move + (cam.CFrame.RightVector * cfg.flyspeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            move = move + Vector3.new(0, cfg.flyspeed, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            move = move - Vector3.new(0, cfg.flyspeed, 0)
        end
        
        if flyBV then
            flyBV.Velocity = move
        end
        if flyBG then
            flyBG.CFrame = cam.CFrame
        end
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.G then
        cfg.fly = not cfg.fly
        if Toggles.Fly then
            Toggles.Fly:SetValue(cfg.fly)
        end
        setupFly()
        Library:Notify(cfg.fly and 'Fly: ON' or 'Fly: OFF', 2)
    end
end)

local function setupHighJump()
    RunService.Heartbeat:Connect(function()
        if not cfg.highjump then return end
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = cfg.highjumppower
            end
        end
    end)
end

local jumpBoostConnection = nil

local function setupJumpBoost()
    if jumpBoostConnection then
        jumpBoostConnection:Disconnect()
        jumpBoostConnection = nil
    end
    
    if not cfg.jumpboost then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    jumpBoostConnection = humanoid.StateChanged:Connect(function(old, new)
        if new == Enum.HumanoidStateType.Jumping and cfg.jumpboost then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local cam = workspace.CurrentCamera
                local boost = cam.CFrame.LookVector * cfg.jumpboostpower
                hrp.Velocity = hrp.Velocity + Vector3.new(boost.X, 0, boost.Z)
            end
        end
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == cfg.speedboostkey then
        if not cfg.speedboost then return end
        
        local char = LocalPlayer.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local cam = workspace.CurrentCamera
        local boost = cam.CFrame.LookVector * cfg.speedboostamount
        
        hrp.Velocity = hrp.Velocity + Vector3.new(boost.X, 0, boost.Z)
        
        Library:Notify('Speed Boost!', 1)
    end
end)

setupWalkSpeed()
setupJumpPower()
setupHighJump()

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    setupNoclip()
    setupInfiniteJump()
    setupNoAccel()
    setupBunnyHop()
    setupFly()
    setupJumpBoost()
end)

if LocalPlayer.Character then
    setupNoclip()
    setupInfiniteJump()
    setupNoAccel()
    setupBunnyHop()
    setupFly()
    setupJumpBoost()
end

local jumpCircleConnections = {}

local function setupJumpCircle(char)
    if jumpCircleConnections[char] then
        for _, conn in ipairs(jumpCircleConnections[char]) do
            conn:Disconnect()
        end
        jumpCircleConnections[char] = nil
    end
    
    if not cfg.jumpcircle then return end
    
    local humanoid = char:FindFirstChild("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end
    
    local lastGroundPos = nil
    local connections = {}
    
    local heartbeatConn = RunService.Heartbeat:Connect(function()
        if humanoid.FloorMaterial ~= Enum.Material.Air then
            lastGroundPos = root.Position - Vector3.new(0, humanoid.HipHeight + 1, 0)
        end
    end)
    table.insert(connections, heartbeatConn)
    
    local stateConn = humanoid.StateChanged:Connect(function(_, new)
        if new ~= Enum.HumanoidStateType.Jumping then return end
        if not lastGroundPos or not cfg.jumpcircle then return end
        
        local circle = Instance.new("Part")
        circle.Anchored = true
        circle.CanCollide = false
        circle.Transparency = 1
        circle.Material = Enum.Material.SmoothPlastic
        circle.Size = Vector3.new(0.05, 0.05, 0.05)
        circle.CFrame = CFrame.new(lastGroundPos + Vector3.new(0, 0.05, 0))
        circle.Parent = workspace
        
        local decal = Instance.new("Decal")
        decal.Texture = cfg.jumpcircledecal
        decal.Face = Enum.NormalId.Top
        decal.Transparency = 0
        decal.Parent = circle
        
        TweenService:Create(
            circle,
            TweenInfo.new(cfg.jumpcirclegrowtime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = Vector3.new(cfg.jumpcirclesize, 0.05, cfg.jumpcirclesize)}
        ):Play()
        
        TweenService:Create(
            decal,
            TweenInfo.new(cfg.jumpcirclefadetime, Enum.EasingStyle.Linear),
            {Transparency = 1}
        ):Play()
        
        task.delay(cfg.jumpcirclefadetime, function()
            circle:Destroy()
        end)
    end)
    table.insert(connections, stateConn)
    
    local ancestryConn = char.AncestryChanged:Connect(function()
        if not char:IsDescendantOf(workspace) then
            if jumpCircleConnections[char] then
                for _, conn in ipairs(jumpCircleConnections[char]) do
                    conn:Disconnect()
                end
                jumpCircleConnections[char] = nil
            end
        end
    end)
    table.insert(connections, ancestryConn)
    
    jumpCircleConnections[char] = connections
end

if LocalPlayer.Character then
    setupJumpCircle(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(setupJumpCircle)

local jitterFrameCounter = 0

local PositionHistory = {}
local BacktrackClone = nil

local function getPing()
    local ping = LocalPlayer:GetNetworkPing() * 1000
    return math.max(ping, 20)
end

local function getRainbowColor()
    local hue = (tick() * 0.5) % 1
    return Color3.fromHSV(hue, 1, 1)
end

local function getBacktrackColor()
    return cfg.backtrackrainbow and getRainbowColor() or cfg.backtrackcolor
end

local function createBacktrackClone(character, cframe)
    local clone = Instance.new("Model")
    clone.Name = "BacktrackClone"
    
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            local chamsPart = Instance.new("Part")
            chamsPart.Size = part.Size
            chamsPart.CFrame = cframe * character.HumanoidRootPart.CFrame:Inverse() * part.CFrame
            chamsPart.Anchored = true
            chamsPart.CanCollide = false
            chamsPart.Material = Enum.Material.Plastic
            chamsPart.Color = getBacktrackColor()
            chamsPart.Transparency = cfg.backtracktransparency
            chamsPart.Name = part.Name
            chamsPart.CastShadow = false
            chamsPart.Parent = clone
            
            local mesh = part:FindFirstChildOfClass("SpecialMesh")
            if mesh then
                mesh:Clone().Parent = chamsPart
            end
        end
    end
    
    if cfg.backtrackskeleton then
        local connections = {
            {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
            {"UpperTorso", "LeftUpperArm"}, {"UpperTorso", "RightUpperArm"},
            {"LeftUpperArm", "LeftLowerArm"}, {"RightUpperArm", "RightLowerArm"},
            {"LeftLowerArm", "LeftHand"}, {"RightLowerArm", "RightHand"},
            {"LowerTorso", "LeftUpperLeg"}, {"LowerTorso", "RightUpperLeg"},
            {"LeftUpperLeg", "LeftLowerLeg"}, {"RightUpperLeg", "RightLowerLeg"},
            {"LeftLowerLeg", "LeftFoot"}, {"RightLowerLeg", "RightFoot"},
        }
        
        for _, conn in ipairs(connections) do
            local part1 = clone:FindFirstChild(conn[1])
            local part2 = clone:FindFirstChild(conn[2])
            
            if part1 and part2 then
                local distance = (part1.Position - part2.Position).Magnitude
                local bone = Instance.new("Part")
                bone.Size = Vector3.new(0.1, distance, 0.1)
                bone.CFrame = CFrame.new(part1.Position, part2.Position) * CFrame.new(0, -distance/2, 0)
                bone.Anchored = true
                bone.CanCollide = false
                bone.Material = Enum.Material.Plastic
                bone.Color = getBacktrackColor()
                bone.Transparency = cfg.backtracktransparency + 0.2
                bone.CastShadow = false
                bone.Parent = clone
            end
        end
    end
    
    return clone
end

local function updateBacktrackClone()
    if not cfg.backtrack then
        if BacktrackClone then
            BacktrackClone:Destroy()
            BacktrackClone = nil
        end
        return
    end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local ping = getPing()
    local delay = (ping * cfg.backtrackping) / 1000
    local targetTime = tick() - delay
    
    local closestRecord = nil
    local closestDiff = math.huge
    
    for _, record in ipairs(PositionHistory) do
        local diff = math.abs(record.Time - targetTime)
        if diff < closestDiff then
            closestDiff = diff
            closestRecord = record
        end
    end
    
    if closestRecord then
        if BacktrackClone then
            BacktrackClone:Destroy()
        end
        
        BacktrackClone = createBacktrackClone(character, closestRecord.CFrame)
        BacktrackClone.Parent = workspace
        
        if cfg.backtrackrainbow then
            for _, part in ipairs(BacktrackClone:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = getRainbowColor()
                end
            end
        end
    end
end

local function recordPosition()
    local character = LocalPlayer.Character
    if not character then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    table.insert(PositionHistory, {
        Time = tick(),
        CFrame = hrp.CFrame
    })
    
    local maxHistoryTime = 1
    while #PositionHistory > 0 and (tick() - PositionHistory[1].Time) > maxHistoryTime do
        table.remove(PositionHistory, 1)
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    if BacktrackClone then
        BacktrackClone:Destroy()
        BacktrackClone = nil
    end
    PositionHistory = {}
    
    if sessionStats.currentStreak > 0 then
        sessionStats.deaths = sessionStats.deaths + 1
        sessionStats.currentStreak = 0
    end
    
    task.wait(1)
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                sessionStats.deaths = sessionStats.deaths + 1
                sessionStats.currentStreak = 0
            end)
        end
    end
end)

local Lighting = game:GetService("Lighting")
local originalSettings = {
    Brightness = Lighting.Brightness,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    ClockTime = Lighting.ClockTime,
    GlobalShadows = Lighting.GlobalShadows,
}

local function removeTextures()
    if not cfg.fpsboost.notextures then return end
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then
            obj.Transparency = 1
        elseif obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
        end
    end
end

local function removeDecals()
    if not cfg.fpsboost.nodecals then return end
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceGui") then
            obj:Destroy()
        end
    end
end

local function removeParticles()
    if not cfg.fpsboost.noparticles then return end
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Sparkles") or 
           obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Beam") then
            obj.Enabled = false
        end
    end
end

local function removeSky()
    if not cfg.fpsboost.nosky then
        return
    end
    
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") or obj:IsA("Atmosphere") or obj:IsA("Clouds") then
            obj:Destroy()
        end
    end
end

local function applyLowQuality()
    if not cfg.fpsboost.lowquality then return end
    
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.CastShadow = false
            obj.Material = Enum.Material.SmoothPlastic
        elseif obj:IsA("Explosion") then
            obj.BlastPressure = 1
            obj.BlastRadius = 1
        end
    end
end

local function removeShadows()
    if not cfg.fpsboost.noshadows then
        Lighting.GlobalShadows = originalSettings.GlobalShadows
        return
    end
    
    Lighting.GlobalShadows = false
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.CastShadow = false
        end
    end
end

local function applyNightMode()
    if not cfg.fpsboost.nightmode then
        Lighting.Brightness = originalSettings.Brightness
        Lighting.Ambient = originalSettings.Ambient
        Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
        Lighting.ClockTime = originalSettings.ClockTime
        return
    end
    
    Lighting.Brightness = 0
    Lighting.Ambient = Color3.fromRGB(0, 0, 0)
    Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    Lighting.ClockTime = 0
end

local function applyAllOptimizations()
    removeTextures()
    removeDecals()
    removeParticles()
    removeSky()
    applyLowQuality()
    removeShadows()
    applyNightMode()
    
    Library:Notify('FPS Boost applied!', 3)
end

local function resetOptimizations()
    cfg.fpsboost.notextures = false
    cfg.fpsboost.nodecals = false
    cfg.fpsboost.noparticles = false
    cfg.fpsboost.nosky = false
    cfg.fpsboost.lowquality = false
    cfg.fpsboost.noshadows = false
    cfg.fpsboost.nightmode = false
    
    Lighting.Brightness = originalSettings.Brightness
    Lighting.Ambient = originalSettings.Ambient
    Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
    Lighting.ClockTime = originalSettings.ClockTime
    Lighting.GlobalShadows = originalSettings.GlobalShadows
    
    settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
    
    Library:Notify('Optimizations reset! Rejoin for full reset.', 4)
end

local TextChatService = game:GetService("TextChatService")

local function SendChatMessage(message)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local textChannel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
        if textChannel then
            textChannel:SendAsync(message)
        end
    else
        local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
            chatEvent.SayMessageRequest:FireServer(message, "All")
        end
    end
end

local function sendKillSay(victimPlayer)
    if not cfg.killsay then return end
    if not victimPlayer then return end
    
    local phrases = cfg.killsayphrases
    if not phrases or #phrases == 0 then return end
    
    local randomPhrase = phrases[math.random(1, #phrases)]
    local displayName = victimPlayer.DisplayName or victimPlayer.Name
    
    local message = randomPhrase:gsub("{DISPLAYNAME}", displayName)
    
    SendChatMessage(message)
end

local function playKillSound()
    if not cfg.killsound then return end
    
    local sound = Instance.new("Sound")
    sound.SoundId = cfg.killsoundid
    sound.Volume = cfg.killsoundvolume
    sound.Parent = workspace
    sound:Play()
    
    Debris:AddItem(sound, 5)
end

local function createKillEffect(character)
    if not cfg.killeffect then return end
    
    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
    if not torso then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "KillEffect"
    billboard.Adornee = torso
    billboard.Size = UDim2.new(cfg.killeffectsize, 0, cfg.killeffectsize, 0)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    
    local image = Instance.new("ImageLabel")
    image.Name = "KillImage"
    image.BackgroundTransparency = 1
    image.Size = UDim2.new(1, 0, 1, 0)
    image.Image = cfg.killeffectimage
    image.ImageTransparency = 0
    image.Parent = billboard
    
    if visuals.container then
        billboard.Parent = visuals.container
    else
        billboard.Parent = CoreGui
    end
    
    killEffects[character] = billboard
    
    if cfg.killeffecttilt then
        task.spawn(function()
            while billboard and billboard.Parent do
                image.ImageTransparency = 0
                task.wait(cfg.killeffecttiltspeed)
                image.ImageTransparency = 1
                task.wait(cfg.killeffecttiltspeed)
            end
        end)
    end
    
    return billboard
end

local function removeKillEffect(character)
    local effect = killEffects[character]
    if effect then
        effect:Destroy()
        killEffects[character] = nil
    end
end

local function trackKill(player)
    if not player or not player.Character then return end
    
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    if trackedTargets[player] then return end
    
    local shotTime = os.clock()
    local initialHealth = humanoid.Health
    
    local connection
    local healthChangedConnection = nil
    
    if cfg.hitnotifications then
        healthChangedConnection = humanoid.HealthChanged:Connect(function(newHealth)
            if newHealth < initialHealth and (os.clock() - shotTime) <= 0.5 then
                local damage = math.floor(initialHealth - newHealth)
                local displayName = player.DisplayName
                local username = player.Name
                
                sessionStats.shotsHit = sessionStats.shotsHit + 1
                
                Library:Notify('[PLT] Hit ' .. username .. ' (' .. displayName .. ') - Damage: ' .. damage, 3)
                
            end
        end)
    end
    
    connection = humanoid.Died:Connect(function()
        local timeSinceShot = os.clock() - shotTime
        if timeSinceShot <= 3 then
            sessionStats.kills = sessionStats.kills + 1
            sessionStats.currentStreak = sessionStats.currentStreak + 1
            if sessionStats.currentStreak > sessionStats.bestStreak then
                sessionStats.bestStreak = sessionStats.currentStreak
            end
            
            playKillSound()
            createKillEffect(player.Character)
            
            sendKillSay(player)
            
            local streak = sessionStats.currentStreak
            if streak == 5 then
                Library:Notify('5 kill streak. cool', 3)
            elseif streak == 10 then
                Library:Notify('10 killstreak. cool too', 3)
            elseif streak == 15 then
                Library:Notify('15 killstreak, cool', 4)
            elseif streak == 20 then
                Library:Notify('20, interesting', 5)
            elseif streak >= 25 and streak % 5 == 0 then
                Library:Notify('' .. streak .. ' killstreak, tuff', 5)
            end
            
            if cfg.hitnotifications then
                local displayName = player.DisplayName
                local username = player.Name
                Library:Notify('[PLT] Killed ' .. username .. ' (' .. displayName .. ')', 3)
            end
        end
        
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if healthChangedConnection then
            healthChangedConnection:Disconnect()
            healthChangedConnection = nil
        end
        trackedTargets[player] = nil
        
        local respawnConnection
        respawnConnection = player.CharacterAdded:Connect(function(newChar)
            removeKillEffect(player.Character)
            if respawnConnection then
                respawnConnection:Disconnect()
                respawnConnection = nil
            end
        end)
    end)
    
    trackedTargets[player] = {
        connection = connection, 
        healthConnection = healthChangedConnection,
        shotTime = shotTime
    }
    
    task.delay(5, function()
        if trackedTargets[player] and trackedTargets[player].connection == connection then
            connection:Disconnect()
            if healthChangedConnection then
                healthChangedConnection:Disconnect()
            end
            trackedTargets[player] = nil
        end
    end)
end

Players.PlayerRemoving:Connect(function(player)
    if trackedTargets[player] then
        if trackedTargets[player].connection then
            trackedTargets[player].connection:Disconnect()
        end
        if trackedTargets[player].healthConnection then
            trackedTargets[player].healthConnection:Disconnect()
        end
        trackedTargets[player] = nil
    end
    removeKillEffect(player.Character)
end)

local partMap = {
    ["Torso"] = {"Torso", "UpperTorso", "LowerTorso"},
    ["LeftArm"] = {"Left Arm", "LeftUpperArm", "LeftLowerArm", "LeftHand"},
    ["RightArm"] = {"Right Arm", "RightUpperArm", "RightLowerArm", "RightHand"},
    ["LeftLeg"] = {"Left Leg", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot"},
    ["RightLeg"] = {"Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot"}
}

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
    
    if cfg.shieldbreaker then
        local shield = char:FindFirstChild("RiotShieldPart")
        if shield and shield:IsA("BasePart") then
            local hp = shield:GetAttribute("Health")
            if hp and hp > 0 then
                local myChar = LocalPlayer.Character
                local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local theirHrp = char:FindFirstChild("HumanoidRootPart")
                
                if myHrp and theirHrp then
                    local toMe = (myHrp.Position - theirHrp.Position).Unit
                    local theirLook = theirHrp.CFrame.LookVector
                    local dot = toMe:Dot(theirLook)
                    
                    if dot > cfg.shieldfrontangle then
                        if cfg.shieldrandomhead and rng:NextInteger(1, 100) <= cfg.shieldheadchance then
                            return getPart(char, "Head")
                        end
                        return shield
                    end
                end
            end
        end
    end
    
    local partName
    if cfg.randomparts then
        local list = cfg.partslist
        partName = (list and #list > 0) and list[rng:NextInteger(1, #list)] or "Head"
    else
        partName = cfg.aimpart
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
    return Vector2.new(vel.X, vel.Z).Magnitude <= cfg.stillthreshold
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
    local myChar = LocalPlayer.Character
    if not myChar then return true end
    
    local filter = {myChar}
    if targetChar then table.insert(filter, targetChar) end
    wallParams.FilterDescendantsInstances = filter
    
    local direction = endPos - startPos
    local distance = direction.Magnitude
    local unit = direction.Unit
    
    local currentStart = startPos
    local remaining = distance
    
    for _ = 1, 10 do
        local result = workspace:Raycast(currentStart, unit * remaining, wallParams)
        if not result then return false end
        
        if result.Instance then return true end
        
        local hitDist = (result.Position - currentStart).Magnitude
        remaining = remaining - hitDist - 0.01
        if remaining <= 0 then return false end
        
        currentStart = result.Position + unit * 0.01
    end
    return false
end

local function quickCheck(player)
    if not player or player == LocalPlayer or not player.Character then return false end
    if not getTargetPart(player.Character) then return false end
    if cfg.deathcheck and isDead(player) then return false end
    if cfg.ffcheck and hasForceField(player) then return false end
    if cfg.vehiclecheck and isInVehicle(player) then return false end
    if cfg.teamcheck and player.Team == LocalPlayer.Team then return false end
    if cfg.criminalsnoinnmates then
        if LocalPlayer.Team == criminalsTeam and player.Team == inmatesTeam then return false end
    end
    if cfg.inmatesnocriminals then
        if LocalPlayer.Team == inmatesTeam and player.Team == criminalsTeam then return false end
    end
    
    if cfg.hostilecheck or cfg.trespasscheck then
        local isTaser = currentGun and currentGun:GetAttribute("Projectile") == "Taser"
        local bypassHostile = cfg.taserbypasshostile and isTaser
        local bypassTrespass = cfg.taserbypasstrespass and isTaser
        local targetChar = player.Character
        
        if LocalPlayer.Team == guardsTeam and player.Team == inmatesTeam then
            local hostile = targetChar:GetAttribute("Hostile")
            local trespass = targetChar:GetAttribute("Trespassing")
            
            if cfg.hostilecheck and cfg.trespasscheck then
                if not bypassHostile and not bypassTrespass then
                    if not hostile and not trespass then return false end
                end
            elseif cfg.hostilecheck and not bypassHostile then
                if not hostile then return false end
            elseif cfg.trespasscheck and not bypassTrespass then
                if not trespass then return false end
            end
        end
    end
    return true
end

local function fullCheck(player)
    if not quickCheck(player) then return false end
    
    if cfg.wallcheck then
        local myChar = LocalPlayer.Character
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
    if now - lastShotTime > shotCooldown then
        lastShotTime = now
        local chance = cfg.hitchance
        if chance >= 100 then
            lastShotResult = true
        elseif chance <= 0 then
            lastShotResult = false
        else
            lastShotResult = rng:NextInteger(1, 100) <= chance
        end
    end
    return lastShotResult
end

local function getMissPos(targetPos)
    local spread = cfg.missspread
    local angle = rng:NextNumber() * math.pi * 2
    local d = rng:NextNumber() * spread
    local yOffset = (rng:NextNumber() - 0.5) * spread
    return targetPos + Vector3.new(math.cos(angle) * d, yOffset, math.sin(angle) * d)
end

local function getClosest(fovRadius)
    fovRadius = fovRadius or cfg.fov
    local camera = workspace.CurrentCamera
    if not camera then return nil, nil end
    
    local now = os.clock()
    
    if cfg.aimbotmode == "RageBot" then
        local myChar = LocalPlayer.Character
        if not myChar then return nil, nil end
        local myHrp = myChar:FindFirstChild("HumanoidRootPart")
        if not myHrp then return nil, nil end
        
        if cfg.targetstickiness and currentTarget and (now - targetSwitchTime) < currentStickiness then
            if fullCheck(currentTarget) then
                local part = getTargetPart(currentTarget.Character)
                if part then
                    return currentTarget, part.Position
                end
            end
        end
        
        local candidates = {}
        
        for _, player in ipairs(Players:GetPlayers()) do
            if quickCheck(player) then
                local part = getTargetPart(player.Character)
                if part then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local distance = (hrp.Position - myHrp.Position).Magnitude
                        candidates[#candidates + 1] = {player = player, dist = distance, part = part}
                    end
                end
            end
        end
        
        table.sort(candidates, function(a, b) return a.dist < b.dist end)
        
        for _, candidate in ipairs(candidates) do
            if fullCheck(candidate.player) then
                if candidate.player ~= currentTarget then
                    currentTarget = candidate.player
                    targetSwitchTime = now
                    if cfg.targetstickinessrandom then
                        currentStickiness = rng:NextNumber(cfg.targetstickinessmin, cfg.targetstickinessmax)
                    else
                        currentStickiness = cfg.targetstickinessduration
                    end
                end
                return candidate.player, candidate.part.Position
            end
        end
        
        currentTarget = nil
        return nil, nil
    end
    
    local lastInput = UserInputService:GetLastInputType()
    local locked = (lastInput == Enum.UserInputType.Touch) or (UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter)
    
    local aimPos
    if locked then
        local viewportSize = camera.ViewportSize
        aimPos = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    else
        aimPos = UserInputService:GetMouseLocation()
    end
    
    if cfg.targetstickiness and currentTarget and (now - targetSwitchTime) < currentStickiness then
        if fullCheck(currentTarget) then
            local part = getTargetPart(currentTarget.Character)
            if part then
                local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                if onScreen and screenPos.Z > 0 then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - aimPos).Magnitude
                    if dist < fovRadius then
                        return currentTarget, part.Position
                    end
                end
            end
        end
    end
    
    local candidates = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
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
    
    if cfg.prioritizeclosest then
        table.sort(candidates, function(a, b) return a.dist < b.dist end)
    else
        for i = #candidates, 2, -1 do
            local j = rng:NextInteger(1, i)
            candidates[i], candidates[j] = candidates[j], candidates[i]
        end
    end
    
    for _, candidate in ipairs(candidates) do
        if fullCheck(candidate.player) then
            if candidate.player ~= currentTarget then
                currentTarget = candidate.player
                targetSwitchTime = now
                if cfg.targetstickinessrandom then
                    currentStickiness = rng:NextNumber(cfg.targetstickinessmin, cfg.targetstickinessmax)
                else
                    currentStickiness = cfg.targetstickinessduration
                end
            end
            return candidate.player, candidate.part.Position
        end
    end
    
    currentTarget = nil
    return nil, nil
end

local ShootEvent = ReplicatedStorage:WaitForChild("GunRemotes"):WaitForChild("ShootEvent")

local function createBulletTrail(startPos, endPos, isTaser)
    local distance = (endPos - startPos).Magnitude
    local trail = Instance.new("Part")
    trail.Name = "BulletTrail"
    trail.Anchored = true
    trail.CanCollide = false
    trail.CanQuery = false
    trail.CanTouch = false
    trail.Material = Enum.Material.Neon
    trail.Size = Vector3.new(0.1, 0.1, distance)
    trail.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -distance / 2)
    trail.Transparency = 0.5
    
    if isTaser then
        trail.BrickColor = BrickColor.new("Cyan")
        trail.Size = Vector3.new(0.2, 0.2, distance)
        local light = Instance.new("SurfaceLight")
        light.Color = Color3.fromRGB(0, 234, 255)
        light.Range = 7
        light.Brightness = 5
        light.Face = Enum.NormalId.Bottom
        light.Parent = trail
    else
        trail.BrickColor = BrickColor.Yellow()
    end
    
    trail.Parent = workspace
    Debris:AddItem(trail, isTaser and 0.8 or 0.1)
end

local function createBulletTracer(startPos, endPos)
    if not cfg.bullettracers then return end
    
    local distance = (endPos - startPos).Magnitude
    local tracer = Instance.new("Part")
    tracer.Name = "BulletTracer"
    tracer.Anchored = true
    tracer.CanCollide = false
    tracer.CanQuery = false
    tracer.CanTouch = false
    tracer.Material = Enum.Material.Neon
    tracer.Size = Vector3.new(cfg.tracerthickness, cfg.tracerthickness, distance)
    tracer.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -distance / 2)
    tracer.Transparency = cfg.tracertransparency
    tracer.Color = cfg.tracercolor
    tracer.TopSurface = Enum.SurfaceType.Smooth
    tracer.BottomSurface = Enum.SurfaceType.Smooth
    
    tracer.Parent = workspace
    
    if cfg.tracerfade then
        task.spawn(function()
            local startTime = os.clock()
            local endTime = startTime + cfg.tracerduration
            
            while os.clock() < endTime and tracer and tracer.Parent do
                local elapsed = os.clock() - startTime
                local progress = elapsed / cfg.tracerduration
                tracer.Transparency = cfg.tracertransparency + (1 - cfg.tracertransparency) * progress
                task.wait()
            end
            
            if tracer and tracer.Parent then
                tracer:Destroy()
            end
        end)
    else
        Debris:AddItem(tracer, cfg.tracerduration)
    end
end

local function autoShoot()
    if not cfg.autoshoot or not cfg.enabled or not currentGun then return end
    
    local now = os.clock()
    
    local shootDelay = cfg.shootdelay
    if cfg.autofirerate and currentGun then
        local fireRate = currentGun:GetAttribute("FireRate")
        if fireRate and fireRate > 0 then
            shootDelay = fireRate
        end
    end
    
    if now - lastAutoShoot < shootDelay then return end
    
    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myHead = myChar:FindFirstChild("Head")
    if not myHead then return end
    
    local muzzle = currentGun:FindFirstChild("Muzzle")
    local startPos = muzzle and muzzle.Position or myHead.Position
    
    local target, targetPos = getClosest(cfg.fov)
    if not target or not fullCheck(target) then 
        lastAutoTarget = nil
        return 
    end
    
    if target ~= lastAutoTarget then
        targetAcquiredTime = now
        lastAutoTarget = target
    end
    
    local targetPart = getTargetPart(target.Character)
    if not targetPart then return end
    
    local ammo = currentGun:GetAttribute("Local_CurrentAmmo") or currentGun:GetAttribute("CurrentAmmo") or 0
    if ammo <= 0 then return end
    
    lastAutoShoot = now
    
    local isTaser = currentGun:GetAttribute("Projectile") == "Taser"
    local isShotgun = currentGun:GetAttribute("IsShotgun")
    local shouldHit = false
    
    if cfg.taseralwayshit and isTaser then
        shouldHit = true
    elseif cfg.ifplayerstill and isStanding(target) then
        shouldHit = true
    elseif cfg.hitchanceAutoOnly and isShotgun then
        shouldHit = true
    else
        shouldHit = rollHit()
    end
    
    for burst = 1, cfg.rapidfireburst do
        if ammo <= 0 then break end
        
        local projectileCount = currentGun:GetAttribute("ProjectileCount") or 1
        local shots = {}
        
        for i = 1, projectileCount do
            local finalPos
            if shouldHit then
                finalPos = targetPart.Position
            else
                if cfg.missspread > 0 then
                    finalPos = getMissPos(targetPart.Position)
                else
                    return
                end
            end
            shots[i] = {myHead.Position, finalPos, shouldHit and targetPart or nil}
            createBulletTrail(startPos, finalPos, isTaser)
            createBulletTracer(startPos, finalPos)
        end
        
        ShootEvent:FireServer(shots)
        ammo = ammo - 1
        currentGun:SetAttribute("Local_CurrentAmmo", ammo)
    end
    
    if not cachedBulletsLabel then
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui then
            local home = playerGui:FindFirstChild("Home")
            if home then
                local hud = home:FindFirstChild("hud")
                if hud then
                    local br = hud:FindFirstChild("BottomRightFrame")
                    if br then
                        local gf = br:FindFirstChild("GunFrame")
                        if gf then
                            cachedBulletsLabel = gf:FindFirstChild("BulletsLabel")
                        end
                    end
                end
            end
        end
    end
    
    if cachedBulletsLabel then
        cachedBulletsLabel.Text = ammo .. "/" .. (currentGun:GetAttribute("MaxAmmo") or 30)
    end
    
    local handle = currentGun:FindFirstChild("Handle")
    if handle then
        local shootSound = handle:FindFirstChild("ShootSound")
        if shootSound then
            local sound = shootSound:Clone()
            sound.Parent = handle
            sound:Play()
            Debris:AddItem(sound, 2)
        end
    end
end

local moddedTools = {}

local function modGun(tool)
    if not tool or not tool:IsA("Tool") then return end
    tool:SetAttribute("FireRate", 0.000000000000000000000000000000000000001)
    tool:SetAttribute("AutoFire", true)
    tool:SetAttribute("SpreadRadius", 0.000000000000000000000000000000001)
    tool:SetAttribute("Range", 22222)
end

local function isGunModTarget(name)
    for gunName, selected in pairs(cfg.gunmodsselected) do
        if selected and gunName == name then
            return true
        end
    end
    return false
end

local function scanBackpack()
    local backpack = LocalPlayer:WaitForChild("Backpack")
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and isGunModTarget(tool.Name) then
            moddedTools[tool] = true
            modGun(tool)
        end
    end
end

local function setupGunMods()
    local backpack = LocalPlayer:WaitForChild("Backpack")
    
    backpack.ChildAdded:Connect(function(child)
        if child:IsA("Tool") and isGunModTarget(child.Name) then
            moddedTools[child] = true
            modGun(child)
        end
    end)
end

RunService.Heartbeat:Connect(function()
    if not cfg.gunmods then return end
    
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end
    
    for tool, _ in pairs(moddedTools) do
        if tool and tool.Parent == backpack then
            modGun(tool)
        else
            moddedTools[tool] = nil
        end
    end
end)

local arrestAuraActive = false

local function getPlayersInRange(range)
    local players = {}
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if not hrp then return players end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local targetChar = player.Character
            local targetHrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
            
            if targetHrp then
                local distance = (hrp.Position - targetHrp.Position).Magnitude
                if distance <= range then
                    table.insert(players, player)
                end
            end
        end
    end
    
    return players
end

local function getCriminals()
    local criminals = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team and player.Team.Name == "Criminals" then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                table.insert(criminals, player)
            end
        end
    end
    
    return criminals
end

local function arrestPlayer(player)
    local args = {[1] = player}
    pcall(function()
        ReplicatedStorage.Remotes.ArrestPlayer:InvokeServer(unpack(args))
    end)
end

task.spawn(function()
    while true do
        if cfg.arrestaura then
            local nearbyPlayers = getPlayersInRange(cfg.arrestaurarange)
            
            if #nearbyPlayers > 0 then
                local randomIndex = math.random(1, #nearbyPlayers)
                local targetPlayer = nearbyPlayers[randomIndex]
                arrestPlayer(targetPlayer)
            end
        end
        
        task.wait(cfg.arrestauradelay)
    end
end)

local function getGun()
    local char = LocalPlayer.Character
    if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and tool:GetAttribute("ToolType") == "Gun" then
            return tool
        end
    end
    return nil
end

task.spawn(function()
    while true do
        local gun = getGun()
        if gun ~= currentGun then
            currentGun = gun
            if currentGun ~= lastGun then
                lastAutoShoot = 0
                lastGun = currentGun
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if currentGun then
        autoShoot()
    end
    
    local char = LocalPlayer.Character
    if char and cfg.jitter then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            local vel = root.Velocity.Magnitude
            local freq = (vel > 2) and 1 or 8
            jitterFrameCounter = jitterFrameCounter + 1
            
            if jitterFrameCounter >= freq then
                local rad = math.rad(math.random(-cfg.jitterangle, cfg.jitterangle))
                root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, rad, 0)
                jitterFrameCounter = 0
            end
        end
    end
end)

task.spawn(function()
    while true do
        recordPosition()
        updateBacktrackClone()
    end
end)

RunService.PreRender:Connect(function()
    local aimPos = UserInputService:GetMouseLocation()
    local camera = workspace.CurrentCamera
    
    if camera then
        local lastInput = UserInputService:GetLastInputType()
        local locked = (lastInput == Enum.UserInputType.Touch) or (UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter)
        if locked then
            local viewportSize = camera.ViewportSize
            aimPos = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
        end
    end
    
    fovCircle.Position = aimPos
    fovCircle.Radius = cfg.fov
    fovCircle.Color = cfg.fovcolor
    fovCircle.Thickness = cfg.fovthickness
    fovCircle.Transparency = cfg.fovtransparency
    fovCircle.Filled = cfg.fovfilled
    fovCircle.NumSides = cfg.fovnumsides
    fovCircle.Visible = cfg.showfov and cfg.enabled and cfg.aimbotmode ~= "RageBot"
    
    if cfg.showtargetline and cfg.enabled then
        local target, targetPos = getClosest()
        if target and targetPos and camera then
            local screenPos, onScreen = camera:WorldToViewportPoint(targetPos)
            if onScreen then
                targetLine.From = aimPos
                targetLine.To = Vector2.new(screenPos.X, screenPos.Y)
                targetLine.Color = cfg.targetlinecolor
                targetLine.Thickness = cfg.targetlinethickness
                targetLine.Transparency = cfg.targetlinetransparency
                targetLine.Visible = true
            else
                targetLine.Visible = false
            end
        else
            targetLine.Visible = false
        end
    else
        targetLine.Visible = false
    end
    
    updateEsp()
    updateC4Esp()
end)

Players.PlayerRemoving:Connect(removeEsp)

local function clearEsp()
    for player, e in pairs(espCache) do
        if e then e:Destroy() end
        espCache[player] = nil
    end
end

LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function()
    clearEsp()
end)

local function noUpvals(fn)
    return function(...) return fn(...) end
end

local origCastRay
local hooked = false

local function setupHook()
    local castRayFunc = filtergc("function", {Name = "castRay"}, true)
    if not castRayFunc then return false end
    
    origCastRay = hookfunction(castRayFunc, noUpvals(function(startPos, targetPos, ...)
        if not cfg.enabled then return origCastRay(startPos, targetPos, ...) end
        
        local closest, closestPos = getClosest(cfg.fov)
        
        if closest and closest.Character then
            
            local isTaser = currentGun and currentGun:GetAttribute("Projectile") == "Taser"
            local isShotgun = currentGun and currentGun:GetAttribute("IsShotgun")
            local shouldHit = false
            
            if cfg.hitchanceAutoOnly and isShotgun then
                return origCastRay(startPos, targetPos, ...)
            end
            
            if cfg.shotgungamehandled and isShotgun then
                local targetPart = getTargetPart(closest.Character)
                if targetPart then
                    return origCastRay(startPos, targetPart.Position, ...)
                end
                return origCastRay(startPos, targetPos, ...)
            end
            
            if cfg.taseralwayshit and isTaser then
                shouldHit = true
            elseif cfg.ifplayerstill and isStanding(closest) then
                shouldHit = true
            else
                shouldHit = rollHit()
            end
            
            if shouldHit then
                local targetPart = getTargetPart(closest.Character)
                if targetPart then
                    if cfg.shotgunnaturalspread and isShotgun then
                        return origCastRay(startPos, targetPart.Position, ...)
                    end
                    return targetPart, targetPart.Position
                end
            else
                if cfg.missspread > 0 then
                    local targetPart = getTargetPart(closest.Character)
                    if targetPart then
                        local missPos = getMissPos(targetPart.Position)
                        return origCastRay(startPos, missPos, ...)
                    end
                end
                return origCastRay(startPos, targetPos, ...)
            end
        end
        
        return origCastRay(startPos, targetPos, ...)
    end))
    return true
end

if not setupHook() then
    task.spawn(function()
        while not hooked do
            task.wait(0.5)
            if setupHook() then
                hooked = true
            end
        end
    end)
else
    hooked = true
end


local Window = Library:CreateWindow({
    Title = 'PrisonLifeTaliban',
    Footer = 'taliban exploit | owned by Cizo and jaylen!, coded by f3kel666',
    Icon = 0,
    NotifySide = 'Right',
    ShowCustomCursor = true,
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

Library:SetWatermarkVisibility(false)

local FrameCounter = 0
local FPS = 60
local FrameTimer = tick()

local fpsGui = Instance.new("ScreenGui")
fpsGui.Name = "FPSCounter"
fpsGui.ResetOnSpawn = false
fpsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
fpsGui.Parent = CoreGui

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPSLabel"
fpsLabel.Size = UDim2.new(0, 150, 0, 20)
fpsLabel.Position = UDim2.new(0.01, 0, 0.01, 0)
fpsLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
fpsLabel.BackgroundTransparency = 0.3
fpsLabel.BorderSizePixel = 0
fpsLabel.Text = "PLT | 60 fps"
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 12
fpsLabel.Parent = fpsGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = fpsLabel

local dragging = false
local dragInput, mousePos, framePos

fpsLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = fpsLabel.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

fpsLabel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        fpsLabel.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

RunService.RenderStepped:Connect(function()
    FrameCounter = FrameCounter + 1
    
    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter
        FrameCounter = 0
        FrameTimer = tick()
    end
    
    fpsLabel.Text = string.format('PLT | %d fps', math.floor(FPS))
    fpsLabel.TextColor3 = cfg.fpslabelcolor
end)

local Tabs = {
    Main = Window:AddTab('Main', 'target'),
    Combat = Window:AddTab('Combat', 'swords'),
    Movement = Window:AddTab('Movement', 'footprints'),
    Visuals = Window:AddTab('Visuals', 'eye'),
    FPSBoost = Window:AddTab('FPS Boost', 'zap'),
    ['UI Settings'] = Window:AddTab('UI Settings', 'settings'),
}

local MainGroup = Tabs.Main:AddLeftGroupbox('Silent Aim')

MainGroup:AddToggle('SilentAimEnabled', {
    Text = 'Enable Silent Aim',
    Default = cfg.enabled,
    Tooltip = 'Toggle the entire silent aim system',
    Callback = function(Value)
        cfg.enabled = Value
        fovCircle.Visible = cfg.showfov and Value and cfg.aimbotmode ~= "RageBot"
    end
})

MainGroup:AddToggle('TeamCheck', {
    Text = 'Team Check',
    Default = cfg.teamcheck,
    Tooltip = 'Don\'t shoot teammates',
    Callback = function(Value) cfg.teamcheck = Value end
})

MainGroup:AddToggle('WallCheck', {
    Text = 'Wall Check',
    Default = cfg.wallcheck,
    Tooltip = 'Don\'t shoot through walls',
    Callback = function(Value) cfg.wallcheck = Value end
})

MainGroup:AddToggle('DeathCheck', {
    Text = 'Death Check',
    Default = cfg.deathcheck,
    Tooltip = 'Skip dead players',
    Callback = function(Value) cfg.deathcheck = Value end
})

MainGroup:AddToggle('FFCheck', {
    Text = 'ForceField Check',
    Default = cfg.ffcheck,
    Tooltip = 'Skip players with forcefield',
    Callback = function(Value) cfg.ffcheck = Value end
})

MainGroup:AddToggle('VehicleCheck', {
    Text = 'Vehicle Check',
    Default = cfg.vehiclecheck,
    Tooltip = 'Don\'t shoot people in vehicles',
    Callback = function(Value) cfg.vehiclecheck = Value end
})

local TeamGroup = Tabs.Main:AddRightGroupbox('Team Settings')

TeamGroup:AddToggle('CriminalsNoInmates', {
    Text = 'Criminals Ignore Inmates',
    Default = cfg.criminalsnoinnmates,
    Tooltip = 'Criminals won\'t shoot inmates',
    Callback = function(Value) cfg.criminalsnoinnmates = Value end
})

TeamGroup:AddToggle('InmatesNoCriminals', {
    Text = 'Inmates Ignore Criminals',
    Default = cfg.inmatesnocriminals,
    Tooltip = 'Inmates won\'t shoot criminals',
    Callback = function(Value) cfg.inmatesnocriminals = Value end
})

TeamGroup:AddToggle('HostileCheck', {
    Text = 'Hostile Check (Guards)',
    Default = cfg.hostilecheck,
    Tooltip = 'Only shoot hostile inmates (💢)',
    Callback = function(Value) cfg.hostilecheck = Value end
})

TeamGroup:AddToggle('TrespassCheck', {
    Text = 'Trespass Check (Guards)',
    Default = cfg.trespasscheck,
    Tooltip = 'Only shoot trespassing inmates (🔗)',
    Callback = function(Value) cfg.trespasscheck = Value end
})

local AimbotGroup = Tabs.Combat:AddLeftGroupbox('Aimbot Settings')

AimbotGroup:AddDropdown('AimbotMode', {
    Values = {'Mouse', 'RageBot'},
    Default = 1,
    Multi = false,
    Text = 'Aimbot Mode',
    Tooltip = 'Mouse = FOV based | RageBot = Closest visible target',
    Callback = function(Value)
        cfg.aimbotmode = Value
        if Value == "RageBot" then
            fovCircle.Visible = false
        else
            fovCircle.Visible = cfg.showfov and cfg.enabled
        end
    end
})

AimbotGroup:AddDivider()

AimbotGroup:AddSlider('FOV', {
    Text = 'FOV Circle Size',
    Default = cfg.fov,
    Min = 10,
    Max = 500,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        cfg.fov = Value
        fovCircle.Radius = Value
    end
})

AimbotGroup:AddToggle('ShowFOV', {
    Text = 'Show FOV Circle',
    Default = cfg.showfov,
    Tooltip = 'Display the FOV circle (Mouse mode only)',
    Callback = function(Value)
        cfg.showfov = Value
        fovCircle.Visible = Value and cfg.enabled and cfg.aimbotmode ~= "RageBot"
    end
})

AimbotGroup:AddToggle('ShowTargetLine', {
    Text = 'Show Target Line',
    Default = cfg.showtargetline,
    Tooltip = 'Draw a line to your current target',
    Callback = function(Value) cfg.showtargetline = Value end
})

AimbotGroup:AddToggle('PrioritizeClosest', {
    Text = 'Prioritize Closest',
    Default = cfg.prioritizeclosest,
    Tooltip = 'Target closest to cursor (Mouse mode only)',
    Callback = function(Value) cfg.prioritizeclosest = Value end
})

local FOVCustomGroup = Tabs.Combat:AddLeftGroupbox('FOV & Target Line', 'circle-dot')

FOVCustomGroup:AddLabel('FOV Circle Color'):AddColorPicker('FOVColor', {
    Default = cfg.fovcolor,
    Title = 'FOV Circle Color',
    Callback = function(Value) cfg.fovcolor = Value end
})

FOVCustomGroup:AddSlider('FOVThickness', {
    Text = 'FOV Thickness',
    Default = cfg.fovthickness,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.fovthickness = Value end
})

FOVCustomGroup:AddSlider('FOVTransparency', {
    Text = 'FOV Transparency',
    Default = cfg.fovtransparency,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value) cfg.fovtransparency = Value end
})

FOVCustomGroup:AddToggle('FOVFilled', {
    Text = 'FOV Filled',
    Default = cfg.fovfilled,
    Tooltip = 'Fill the FOV circle',
    Callback = function(Value) cfg.fovfilled = Value end
})

FOVCustomGroup:AddSlider('FOVNumSides', {
    Text = 'FOV Smoothness',
    Default = cfg.fovnumsides,
    Min = 12,
    Max = 128,
    Rounding = 0,
    Compact = false,
    Tooltip = 'Higher = smoother circle',
    Callback = function(Value) cfg.fovnumsides = Value end
})

FOVCustomGroup:AddDivider()

FOVCustomGroup:AddLabel('Target Line Color'):AddColorPicker('TargetLineColor', {
    Default = cfg.targetlinecolor,
    Title = 'Target Line Color',
    Callback = function(Value) cfg.targetlinecolor = Value end
})

FOVCustomGroup:AddSlider('TargetLineThickness', {
    Text = 'Line Thickness',
    Default = cfg.targetlinethickness,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.targetlinethickness = Value end
})

FOVCustomGroup:AddSlider('TargetLineTransparency', {
    Text = 'Line Transparency',
    Default = cfg.targetlinetransparency,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value) cfg.targetlinetransparency = Value end
})

local HitchanceGroup = Tabs.Combat:AddRightGroupbox('Hit Chance')

HitchanceGroup:AddSlider('HitChance', {
    Text = 'Hit Chance %',
    Default = cfg.hitchance,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.hitchance = Value end
})

HitchanceGroup:AddToggle('HitchanceAutoOnly', {
    Text = 'Auto Weapons Only',
    Default = cfg.hitchanceAutoOnly,
    Tooltip = 'Only apply hitchance to automatic weapons',
    Callback = function(Value) cfg.hitchanceAutoOnly = Value end
})

HitchanceGroup:AddToggle('IfPlayerStill', {
    Text = 'Always Hit Still Players',
    Default = cfg.ifplayerstill,
    Tooltip = 'Always hit if target isn\'t moving',
    Callback = function(Value) cfg.ifplayerstill = Value end
})

HitchanceGroup:AddSlider('StillThreshold', {
    Text = 'Still Threshold',
    Default = cfg.stillthreshold,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(Value) cfg.stillthreshold = Value end
})

HitchanceGroup:AddSlider('MissSpread', {
    Text = 'Miss Spread',
    Default = cfg.missspread,
    Min = 0,
    Max = 20,
    Rounding = 1,
    Compact = false,
    Callback = function(Value) cfg.missspread = Value end
})

local TargetGroup = Tabs.Combat:AddLeftGroupbox('Target Settings')

TargetGroup:AddDropdown('AimPart', {
    Values = {'Head', 'Torso', 'Left Arm', 'Right Arm', 'Left Leg', 'Right Leg', 'HumanoidRootPart'},
    Default = 1,
    Multi = false,
    Text = 'Aim Part',
    Tooltip = 'Which body part to aim at',
    Callback = function(Value) cfg.aimpart = Value end
})

TargetGroup:AddToggle('RandomParts', {
    Text = 'Random Parts',
    Default = cfg.randomparts,
    Tooltip = 'Randomly pick body parts',
    Callback = function(Value) cfg.randomparts = Value end
})

TargetGroup:AddDivider()

TargetGroup:AddToggle('TargetStickiness', {
    Text = 'Target Stickiness',
    Default = cfg.targetstickiness,
    Tooltip = 'Keep locked onto same target for duration',
    Callback = function(Value) cfg.targetstickiness = Value end
})

TargetGroup:AddSlider('StickinessDuration', {
    Text = 'Stickiness Duration',
    Default = cfg.targetstickinessduration,
    Min = 0.1,
    Max = 3,
    Rounding = 1,
    Compact = false,
    Callback = function(Value) cfg.targetstickinessduration = Value end
})

TargetGroup:AddToggle('StickinessRandom', {
    Text = 'Random Stickiness',
    Default = cfg.targetstickinessrandom,
    Tooltip = 'Use random duration range',
    Callback = function(Value) cfg.targetstickinessrandom = Value end
})

TargetGroup:AddSlider('StickinessMin', {
    Text = 'Min Stickiness',
    Default = cfg.targetstickinessmin,
    Min = 0.1,
    Max = 2,
    Rounding = 1,
    Compact = false,
    Callback = function(Value) cfg.targetstickinessmin = Value end
})

TargetGroup:AddSlider('StickinessMax', {
    Text = 'Max Stickiness',
    Default = cfg.targetstickinessmax,
    Min = 0.1,
    Max = 3,
    Rounding = 1,
    Compact = false,
    Callback = function(Value) cfg.targetstickinessmax = Value end
})

local AutoShootGroup = Tabs.Combat:AddRightGroupbox('Auto Shoot')

AutoShootGroup:AddToggle('AutoShoot', {
    Text = 'Enable Auto Shoot',
    Default = cfg.autoshoot,
    Tooltip = 'Automatically shoot when target acquired',
    Callback = function(Value) cfg.autoshoot = Value end
})

AutoShootGroup:AddSlider('RapidFireBurst', {
    Text = 'Bullets Per Shot',
    Default = cfg.rapidfireburst,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Tooltip = 'Number of bullets per shot',
    Callback = function(Value) cfg.rapidfireburst = Value end
})

AutoShootGroup:AddSlider('AutoShootDelay', {
    Text = 'Auto Shoot Delay',
    Default = cfg.autoshootdelay,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value) cfg.autoshootdelay = Value end
})

AutoShootGroup:AddToggle('AutoFireRate', {
    Text = 'Auto Detect FireRate',
    Default = cfg.autofirerate,
    Tooltip = 'Automatically use gun\'s FireRate as delay',
    Callback = function(Value) cfg.autofirerate = Value end
})

AutoShootGroup:AddSlider('AutoShootStartDelay', {
    Text = 'Start Delay',
    Default = cfg.autoshootstartdelay,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value) cfg.autoshootstartdelay = Value end
})

local ShieldGroup = Tabs.Combat:AddLeftGroupbox('Shield Breaker')

ShieldGroup:AddToggle('ShieldBreaker', {
    Text = 'Enable Shield Breaker',
    Default = cfg.shieldbreaker,
    Tooltip = 'Target riot shields to break them',
    Callback = function(Value) cfg.shieldbreaker = Value end
})

ShieldGroup:AddToggle('ShieldRandomHead', {
    Text = 'Random Head Shots',
    Default = cfg.shieldrandomhead,
    Tooltip = 'Sometimes hit head instead of shield',
    Callback = function(Value) cfg.shieldrandomhead = Value end
})

ShieldGroup:AddSlider('ShieldHeadChance', {
    Text = 'Head Chance %',
    Default = cfg.shieldheadchance,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.shieldheadchance = Value end
})

local TaserGroup = Tabs.Combat:AddRightGroupbox('Taser Settings')

TaserGroup:AddToggle('TaserBypassHostile', {
    Text = 'Bypass Hostile Check',
    Default = cfg.taserbypasshostile,
    Tooltip = 'Taser ignores hostile check',
    Callback = function(Value) cfg.taserbypasshostile = Value end
})

TaserGroup:AddToggle('TaserBypassTrespass', {
    Text = 'Bypass Trespass Check',
    Default = cfg.taserbypasstrespass,
    Tooltip = 'Taser ignores trespass check',
    Callback = function(Value) cfg.taserbypasstrespass = Value end
})

TaserGroup:AddToggle('TaserAlwaysHit', {
    Text = 'Taser Always Hit',
    Default = cfg.taseralwayshit,
    Tooltip = 'Taser never misses',
    Callback = function(Value) cfg.taseralwayshit = Value end
})

local ShotgunGroup = Tabs.Combat:AddLeftGroupbox('Shotgun Settings')

ShotgunGroup:AddToggle('ShotgunNaturalSpread', {
    Text = 'Natural Spread',
    Default = cfg.shotgunnaturalspread,
    Tooltip = 'Let shotgun bullets spread naturally',
    Callback = function(Value) cfg.shotgunnaturalspread = Value end
})

ShotgunGroup:AddToggle('ShotgunGameHandled', {
    Text = 'Game Handled',
    Default = cfg.shotgungamehandled,
    Tooltip = 'Let game handle shotgun spread/hitchance',
    Callback = function(Value) cfg.shotgungamehandled = Value end
})

local GunModsGroup = Tabs.Combat:AddRightGroupbox('Gun Mods', 'wrench')

GunModsGroup:AddLabel('Select guns to mod:')

for _, gunName in ipairs({"Revolver", "M100", "MP5", "AK-47", "Remington 870", "FAL", "M4A1", "M9"}) do
    GunModsGroup:AddToggle('GunMod_' .. gunName:gsub("%s", ""):gsub("-", ""), {
        Text = gunName,
        Default = cfg.gunmodsselected[gunName],
        Callback = function(Value) 
            cfg.gunmodsselected[gunName] = Value
        end
    })
end

GunModsGroup:AddButton({
    Text = 'Enable Moods',
    Func = function()
        cfg.gunmods = true
        setupGunMods()
        scanBackpack()
        Library:Notify('Mods applied to selected weapons! Run again if you die', 3)
    end,
    DoubleClick = false,
})

GunModsGroup:AddLabel('Mods Applied:'):AddColorPicker('GunModsIndicator', {
    Default = Color3.fromRGB(0, 255, 0),
    Title = 'Active Indicator'
})

local ArrestAuraGroup = Tabs.Combat:AddRightGroupbox('Arrest Aura', 'handcuffs')

ArrestAuraGroup:AddToggle('ArrestAura', {
    Text = 'Enable Arrest Aura',
    Default = cfg.arrestaura,
    Tooltip = 'Auto-arrest nearby players',
    Callback = function(Value) cfg.arrestaura = Value end
})

ArrestAuraGroup:AddSlider('ArrestAuraRange', {
    Text = 'Range',
    Default = cfg.arrestaurarange,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Suffix = ' studs',
    Compact = false,
    Callback = function(Value) cfg.arrestaurarange = Value end
})

ArrestAuraGroup:AddSlider('ArrestAuraDelay', {
    Text = 'Delay',
    Default = cfg.arrestauradelay,
    Min = 0.05,
    Max = 1,
    Rounding = 2,
    Suffix = 's',
    Compact = false,
    Callback = function(Value) cfg.arrestauradelay = Value end
})

local MovementGroup = Tabs.Movement:AddLeftGroupbox('Movement')

MovementGroup:AddToggle('Noclip', {
    Text = 'Noclip',
    Default = cfg.noclip,
    Tooltip = 'Walk through walls',
    Callback = function(Value)
        cfg.noclip = Value
        setupNoclip()
    end
})

MovementGroup:AddButton({
    Text = 'Noclip Bypass',
    Func = function()
        local hook = newcclosure(function() return end)
        for _, obj in getgc(false) do 
            if typeof(obj) == "function" then 
                local source = debug.info(obj, "s")
                if source and source:find("CharacterCollision") then 
                    hookfunction(obj, hook)
                end
            end
        end
        Library:Notify('Noclip Bypass Applied!', 3)
    end,
    DoubleClick = false,
    Tooltip = 'Bypass anti-noclip'
})

MovementGroup:AddDivider()

MovementGroup:AddToggle('InfiniteJump', {
    Text = 'Infinite Jump',
    Default = cfg.infinitejump,
    Tooltip = 'Jump infinitely in the air',
    Callback = function(Value)
        cfg.infinitejump = Value
        setupInfiniteJump()
    end
})

MovementGroup:AddButton({
    Text = 'No Jump CD',
    Func = function()
        assert(getconnections, "getconnections not found")
        local Players = cloneref(game:GetService('Players'))
        local lplr = Players.LocalPlayer
        for i,v in getconnections(lplr.Character.Humanoid:GetPropertyChangedSignal('Jump')) do
            v:Disconnect()
        end
        lplr.CharacterAdded:Connect(function()
            repeat task.wait() until lplr.Character:FindFirstChild('Humanoid')
            
            for i,v in getconnections(lplr.Character.Humanoid:GetPropertyChangedSignal('Jump')) do
                v:Disconnect()
            end
        end)
        Library:Notify('No Jump CD Applied!', 3)
    end,
    DoubleClick = false,
    Tooltip = 'Remove jump cooldown'
})

MovementGroup:AddDivider()

MovementGroup:AddToggle('NoAccel', {
    Text = 'No Acceleration',
    Default = cfg.noaccel,
    Tooltip = 'Remove movement acceleration',
    Callback = function(Value)
        cfg.noaccel = Value
        setupNoAccel()
    end
})

MovementGroup:AddToggle('BunnyHop', {
    Text = 'Bunny Hop',
    Default = cfg.bunnyhop,
    Tooltip = 'Auto jump when moving',
    Callback = function(Value)
        cfg.bunnyhop = Value
        setupBunnyHop()
    end
})

MovementGroup:AddDivider()

MovementGroup:AddToggle('Fly', {
    Text = 'Fly',
    Default = cfg.fly,
    Tooltip = 'Fly mode (WASD + Space/Shift) - Press F',
    Callback = function(Value)
        cfg.fly = Value
        setupFly()
    end
})

MovementGroup:AddLabel('Fly Keybind: F')

MovementGroup:AddSlider('FlySpeed', {
    Text = 'Fly Speed',
    Default = cfg.flyspeed,
    Min = 10,
    Max = 200,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.flyspeed = Value end
})

MovementGroup:AddDivider()

MovementGroup:AddToggle('HighJump', {
    Text = 'High Jump',
    Default = cfg.highjump,
    Tooltip = 'Jump higher than normal',
    Callback = function(Value) cfg.highjump = Value end
})

MovementGroup:AddSlider('HighJumpPower', {
    Text = 'High Jump Power',
    Default = cfg.highjumppower,
    Min = 50,
    Max = 300,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.highjumppower = Value end
})

MovementGroup:AddDivider()

MovementGroup:AddToggle('JumpBoost', {
    Text = 'Jump Boost',
    Default = cfg.jumpboost,
    Tooltip = 'Forward momentum when jumping',
    Callback = function(Value)
        cfg.jumpboost = Value
        setupJumpBoost()
    end
})

MovementGroup:AddSlider('JumpBoostPower', {
    Text = 'Jump Boost Power',
    Default = cfg.jumpboostpower,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.jumpboostpower = Value end
})

local SpeedGroup = Tabs.Movement:AddRightGroupbox('Speed & Jump')

SpeedGroup:AddToggle('WalkSpeedEnabled', {
    Text = 'Custom WalkSpeed',
    Default = cfg.walkspeedenabled,
    Tooltip = 'Enable custom walk speed',
    Callback = function(Value) cfg.walkspeedenabled = Value end
})

SpeedGroup:AddSlider('WalkSpeed', {
    Text = 'WalkSpeed',
    Default = cfg.walkspeed,
    Min = 0,
    Max = 32,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.walkspeed = Value end
})

SpeedGroup:AddDivider()

SpeedGroup:AddToggle('SpeedBoost', {
    Text = 'Speed Boost',
    Default = cfg.speedboost,
    Tooltip = 'Press V for forward speed boost. does not work with no accel. Might be detected',
    Callback = function(Value) cfg.speedboost = Value end
})

SpeedGroup:AddLabel('Speed Boost Keybind: V')

SpeedGroup:AddSlider('SpeedBoostAmount', {
    Text = 'Boost Power',
    Default = cfg.speedboostamount,
    Min = 50,
    Max = 200,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.speedboostamount = Value end
})

SpeedGroup:AddDivider()
SpeedGroup:AddToggle('JumpPowerEnabled', {
    Text = 'Custom JumpPower',
    Default = cfg.jumppowerenabled,
    Tooltip = 'Enable custom jump power',
    Callback = function(Value) cfg.jumppowerenabled = Value end
})

SpeedGroup:AddSlider('JumpPower', {
    Text = 'JumpPower',
    Default = cfg.jumppower,
    Min = 50,
    Max = 200,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.jumppower = Value end
})

local JumpCircleGroup = Tabs.Movement:AddLeftGroupbox('Jump Circle')

JumpCircleGroup:AddToggle('JumpCircle', {
    Text = 'Enable Jump Circle',
    Default = cfg.jumpcircle,
    Tooltip = 'Show circle effect when jumping',
    Callback = function(Value) 
        cfg.jumpcircle = Value 
        if LocalPlayer.Character then
            setupJumpCircle(LocalPlayer.Character)
        end
    end
})

JumpCircleGroup:AddInput('JumpCircleDecal', {
    Default = cfg.jumpcircledecal,
    Numeric = false,
    Finished = true,
    Text = 'Decal ID',
    Tooltip = 'rbxassetid:// format',
    Placeholder = 'rbxassetid://112096280571499',
    Callback = function(Value)
        if Value and Value ~= "" then
            cfg.jumpcircledecal = Value
        end
    end
})

JumpCircleGroup:AddSlider('JumpCircleSize', {
    Text = 'Circle Size',
    Default = cfg.jumpcirclesize,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Compact = false,
    Callback = function(Value) cfg.jumpcirclesize = Value end
})

JumpCircleGroup:AddSlider('JumpCircleGrowTime', {
    Text = 'Grow Time',
    Default = cfg.jumpcirclegrowtime,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(Value) cfg.jumpcirclegrowtime = Value end
})

JumpCircleGroup:AddSlider('JumpCircleFadeTime', {
    Text = 'Fade Time',
    Default = cfg.jumpcirclefadetime,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(Value) cfg.jumpcirclefadetime = Value end
})

local JitterGroup = Tabs.Movement:AddRightGroupbox('Jitter Anti-Aim', 'shield')

JitterGroup:AddToggle('Jitter', {
    Text = 'Enable Jitter',
    Default = cfg.jitter,
    Tooltip = 'Rapidly rotate your character',
    Callback = function(Value) cfg.jitter = Value end
})

JitterGroup:AddSlider('JitterAngle', {
    Text = 'Jitter Angle',
    Default = cfg.jitterangle,
    Min = 0,
    Max = 180,
    Rounding = 0,
    Suffix = '°',
    Compact = false,
    Callback = function(Value) cfg.jitterangle = Value end
})

local BacktrackGroup = Tabs.Movement:AddLeftGroupbox('Backtrack Viewer', 'rewind')

BacktrackGroup:AddToggle('Backtrack', {
    Text = 'Enable Backtrack',
    Default = cfg.backtrack,
    Tooltip = 'Show where you were based on ping',
    Callback = function(Value) cfg.backtrack = Value end
})

BacktrackGroup:AddSlider('BacktrackPing', {
    Text = 'Ping Multiplier',
    Default = cfg.backtrackping,
    Min = 0.5,
    Max = 3,
    Rounding = 1,
    Compact = false,
    Tooltip = '1 = actual ping, 2 = double ping',
    Callback = function(Value) cfg.backtrackping = Value end
})

BacktrackGroup:AddLabel('Backtrack Color'):AddColorPicker('BacktrackColor', {
    Default = cfg.backtrackcolor,
    Title = 'Backtrack Color',
    Callback = function(Value) cfg.backtrackcolor = Value end
})

BacktrackGroup:AddToggle('BacktrackRainbow', {
    Text = 'Rainbow Mode',
    Default = cfg.backtrackrainbow,
    Callback = function(Value) cfg.backtrackrainbow = Value end
})

BacktrackGroup:AddSlider('BacktrackTransparency', {
    Text = 'Transparency',
    Default = cfg.backtracktransparency,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value) cfg.backtracktransparency = Value end
})

BacktrackGroup:AddToggle('BacktrackSkeleton', {
    Text = 'Show Skeleton',
    Default = cfg.backtrackskeleton,
    Callback = function(Value) cfg.backtrackskeleton = Value end
})

local ESPGroup = Tabs.Visuals:AddLeftGroupbox('Player ESP')

ESPGroup:AddToggle('ESPEnabled', {
    Text = 'Enable ESP',
    Default = cfg.esp,
    Tooltip = 'Show player ESP',
    Callback = function(Value) cfg.esp = Value end
})

ESPGroup:AddToggle('ESPTeamCheck', {
    Text = 'Team Check',
    Default = cfg.espteamcheck,
    Tooltip = 'ESP team filtering',
    Callback = function(Value) cfg.espteamcheck = Value end
})

ESPGroup:AddToggle('ESPShowTeam', {
    Text = 'Show Teammates',
    Default = cfg.espshowteam,
    Tooltip = 'Show ESP for teammates',
    Callback = function(Value) cfg.espshowteam = Value end
})

ESPGroup:AddToggle('ESPShowDist', {
    Text = 'Show Distance',
    Default = cfg.espshowdist,
    Tooltip = 'Display distance on ESP',
    Callback = function(Value) cfg.espshowdist = Value end
})

ESPGroup:AddSlider('ESPMaxDist', {
    Text = 'Max Distance',
    Default = cfg.espmaxdist,
    Min = 50,
    Max = 2000,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.espmaxdist = Value end
})

ESPGroup:AddDivider()

ESPGroup:AddToggle('ESPBoxes', {
    Text = 'Boxes',
    Default = cfg.espboxes,
    Tooltip = '3D boxes around players',
    Callback = function(Value) cfg.espboxes = Value end
})

ESPGroup:AddToggle('ESPSkeleton', {
    Text = 'Skeleton',
    Default = cfg.espskeleton,
    Tooltip = 'Skeleton ESP',
    Callback = function(Value) cfg.espskeleton = Value end
})

ESPGroup:AddToggle('ESPTracers', {
    Text = 'Tracers',
    Default = cfg.esptracers,
    Tooltip = 'Lines to players',
    Callback = function(Value) cfg.esptracers = Value end
})

ESPGroup:AddToggle('ESPHealthBar', {
    Text = 'Health Bar',
    Default = cfg.esphealthbar,
    Tooltip = 'Show health bar',
    Callback = function(Value) cfg.esphealthbar = Value end
})

ESPGroup:AddToggle('ESPHealthText', {
    Text = 'Health Text',
    Default = cfg.esphealthtext,
    Tooltip = 'Show health number',
    Callback = function(Value) cfg.esphealthtext = Value end
})

local ESPTargetsGroup = Tabs.Visuals:AddRightGroupbox('ESP Targets')

ESPTargetsGroup:AddToggle('ESPGuards', {
    Text = 'Show Guards',
    Default = cfg.esptargets.guards,
    Callback = function(Value) cfg.esptargets.guards = Value end
})

ESPTargetsGroup:AddToggle('ESPInmates', {
    Text = 'Show Inmates',
    Default = cfg.esptargets.inmates,
    Callback = function(Value) cfg.esptargets.inmates = Value end
})

ESPTargetsGroup:AddToggle('ESPCriminals', {
    Text = 'Show Criminals',
    Default = cfg.esptargets.criminals,
    Callback = function(Value) cfg.esptargets.criminals = Value end
})

local ESPColorGroup = Tabs.Visuals:AddLeftGroupbox('ESP Colors')

ESPColorGroup:AddToggle('ESPUseTeamColors', {
    Text = 'Use Team Colors',
    Default = cfg.espuseteamcolors,
    Tooltip = 'Color ESP based on team',
    Callback = function(Value) cfg.espuseteamcolors = Value end
})

ESPColorGroup:AddLabel('Default Color'):AddColorPicker('ESPColor', {
    Default = cfg.espcolor,
    Title = 'Default ESP Color',
    Callback = function(Value) cfg.espcolor = Value end
})

ESPColorGroup:AddLabel('Guards Color'):AddColorPicker('ESPGuardsColor', {
    Default = cfg.espguards,
    Title = 'Guards ESP Color',
    Callback = function(Value) cfg.espguards = Value end
})

ESPColorGroup:AddLabel('Inmates Color'):AddColorPicker('ESPInmatesColor', {
    Default = cfg.espinmates,
    Title = 'Inmates ESP Color',
    Callback = function(Value) cfg.espinmates = Value end
})

ESPColorGroup:AddLabel('Criminals Color'):AddColorPicker('ESPCriminalsColor', {
    Default = cfg.espcriminals,
    Title = 'Criminals ESP Color',
    Callback = function(Value) cfg.espcriminals = Value end
})

ESPColorGroup:AddLabel('Team Color'):AddColorPicker('ESPTeamColor', {
    Default = cfg.espteam,
    Title = 'Team ESP Color',
    Callback = function(Value) cfg.espteam = Value end
})

local ESPCustomGroup = Tabs.Visuals:AddLeftGroupbox('ESP Customization', 'palette')

ESPCustomGroup:AddLabel('Box Color'):AddColorPicker('ESPBoxColor', {
    Default = cfg.espboxcolor,
    Title = 'ESP Box Color',
    Callback = function(Value) cfg.espboxcolor = Value end
})

ESPCustomGroup:AddSlider('ESPBoxThickness', {
    Text = 'Box Thickness',
    Default = cfg.espboxthickness,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.espboxthickness = Value end
})

ESPCustomGroup:AddDivider()

ESPCustomGroup:AddLabel('Skeleton Color'):AddColorPicker('ESPSkeletonColor', {
    Default = cfg.espskeletoncolor,
    Title = 'Skeleton Color',
    Callback = function(Value) cfg.espskeletoncolor = Value end
})

ESPCustomGroup:AddSlider('ESPSkeletonThickness', {
    Text = 'Skeleton Thickness',
    Default = cfg.espskeletonthickness,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.espskeletonthickness = Value end
})

ESPCustomGroup:AddDivider()

ESPCustomGroup:AddLabel('Tracer Color'):AddColorPicker('ESPTracerColor', {
    Default = cfg.esptracercolor,
    Title = 'Tracer Color',
    Callback = function(Value) cfg.esptracercolor = Value end
})

ESPCustomGroup:AddSlider('ESPTracerThickness', {
    Text = 'Tracer Thickness',
    Default = cfg.esptracerthickness,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.esptracerthickness = Value end
})

ESPCustomGroup:AddDivider()

ESPCustomGroup:AddSlider('ESPTextSize', {
    Text = 'Text Size',
    Default = cfg.esptextsize,
    Min = 8,
    Max = 20,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.esptextsize = Value end
})

ESPCustomGroup:AddToggle('ESPTextOutline', {
    Text = 'Text Outline',
    Default = cfg.esptextoutline,
    Tooltip = 'Add black outline to ESP text',
    Callback = function(Value) cfg.esptextoutline = Value end
})

ESPCustomGroup:AddDivider()

ESPCustomGroup:AddToggle('ESPHealthBarOutline', {
    Text = 'Health Bar Outline',
    Default = cfg.esphealthbaroutline,
    Tooltip = 'Show health bar background',
    Callback = function(Value) cfg.esphealthbaroutline = Value end
})

ESPCustomGroup:AddLabel('Health Bar Outline'):AddColorPicker('ESPHealthBarOutlineColor', {
    Default = cfg.esphealthbaroutlinecolor,
    Title = 'Health Bar Outline',
    Callback = function(Value) cfg.esphealthbaroutlinecolor = Value end
})

local C4ESPGroup = Tabs.Visuals:AddRightGroupbox('C4 ESP')

C4ESPGroup:AddToggle('C4ESP', {
    Text = 'Enable C4 ESP',
    Default = cfg.c4esp,
    Tooltip = 'Show C4 explosives',
    Callback = function(Value) cfg.c4esp = Value end
})

C4ESPGroup:AddToggle('C4ESPShowDist', {
    Text = 'Show Distance',
    Default = cfg.c4espshowdist,
    Tooltip = 'Display distance on C4 ESP',
    Callback = function(Value) cfg.c4espshowdist = Value end
})

C4ESPGroup:AddSlider('C4ESPMaxDist', {
    Text = 'Max Distance',
    Default = cfg.c4espmaxdist,
    Min = 50,
    Max = 1000,
    Rounding = 0,
    Compact = false,
    Callback = function(Value) cfg.c4espmaxdist = Value end
})

C4ESPGroup:AddLabel('C4 Color'):AddColorPicker('C4ESPColor', {
    Default = cfg.c4espcolor,
    Title = 'C4 ESP Color',
    Callback = function(Value) cfg.c4espcolor = Value end
})

local KillSoundGroup = Tabs.Visuals:AddLeftGroupbox('Kill Sound')

KillSoundGroup:AddToggle('KillSound', {
    Text = 'Enable Kill Sound',
    Default = cfg.killsound,
    Tooltip = 'Play a sound when you kill someone',
    Callback = function(Value) cfg.killsound = Value end
})

KillSoundGroup:AddInput('KillSoundID', {
    Default = cfg.killsoundid,
    Numeric = false,
    Finished = true,
    Text = 'Sound ID',
    Tooltip = 'rbxassetid:// format',
    Placeholder = 'rbxassetid://5043636498',
    Callback = function(Value)
        if Value and Value ~= "" then
            cfg.killsoundid = Value
        end
    end
})

KillSoundGroup:AddSlider('KillSoundVolume', {
    Text = 'Sound Volume',
    Default = cfg.killsoundvolume,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value) cfg.killsoundvolume = Value end
})

KillSoundGroup:AddButton({
    Text = 'Test Sound',
    Func = function()
        playKillSound()
    end,
    DoubleClick = false,
    Tooltip = 'Preview the kill sound'
})

local KillEffectGroup = Tabs.Visuals:AddRightGroupbox('Kill Effect')

KillEffectGroup:AddToggle('KillEffect', {
    Text = 'Enable Kill Effect',
    Default = cfg.killeffect,
    Tooltip = 'Show image on killed players',
    Callback = function(Value) cfg.killeffect = Value end
})

KillEffectGroup:AddInput('KillEffectImage', {
    Default = cfg.killeffectimage,
    Numeric = false,
    Finished = true,
    Text = 'Image ID',
    Tooltip = 'rbxassetid:// format',
    Placeholder = 'rbxassetid://112691580111061',
    Callback = function(Value)
        if Value and Value ~= "" then
            cfg.killeffectimage = Value
        end
    end
})

KillEffectGroup:AddSlider('KillEffectSize', {
    Text = 'Effect Size',
    Default = cfg.killeffectsize,
    Min = 1,
    Max = 15,
    Rounding = 1,
    Compact = false,
    Callback = function(Value) cfg.killeffectsize = Value end
})

KillEffectGroup:AddToggle('KillEffectTilt', {
    Text = 'Tilt Effect (Blink)',
    Default = cfg.killeffecttilt,
    Tooltip = 'Make the image appear/disappear',
    Callback = function(Value) cfg.killeffecttilt = Value end
})

KillEffectGroup:AddSlider('KillEffectTiltSpeed', {
    Text = 'Tilt Speed',
    Default = cfg.killeffecttiltspeed,
    Min = 0.1,
    Max = 2,
    Rounding = 1,
    Compact = false,
    Tooltip = 'Time between blinks',
    Callback = function(Value) cfg.killeffecttiltspeed = Value end
})

KillEffectGroup:AddDivider()

KillEffectGroup:AddToggle('HitNotifications', {
    Text = 'Hit Notifications',
    Default = cfg.hitnotifications,
    Tooltip = 'Show damage and kill notifications',
    Callback = function(Value) cfg.hitnotifications = Value end
})

local PlayerTrailGroup = Tabs.Visuals:AddLeftGroupbox('Player Trail')

PlayerTrailGroup:AddToggle('PlayerTrail', {
    Text = 'Enable Trail',
    Default = cfg.playertrail,
    Tooltip = 'Add a trail effect to yourself',
    Callback = function(Value) 
        cfg.playertrail = Value 
        createPlayerTrail()
    end
})

PlayerTrailGroup:AddLabel('Trail Color'):AddColorPicker('TrailColor', {
    Default = cfg.trailcolor,
    Title = 'Trail Color',
    Callback = function(Value) 
        cfg.trailcolor = Value 
        createPlayerTrail()
    end
})

PlayerTrailGroup:AddSlider('TrailLifetime', {
    Text = 'Lifetime',
    Default = cfg.traillifetime,
    Min = 0.5,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(Value) 
        cfg.traillifetime = Value 
        createPlayerTrail()
    end
})

PlayerTrailGroup:AddSlider('TrailTransparency', {
    Text = 'Transparency',
    Default = cfg.trailtransparency,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value) 
        cfg.trailtransparency = Value 
        createPlayerTrail()
    end
})

local BulletTracersGroup = Tabs.Visuals:AddLeftGroupbox('Bullet Tracers')

BulletTracersGroup:AddToggle('BulletTracers', {
    Text = 'Enable Bullet Tracers',
    Default = cfg.bullettracers,
    Tooltip = 'Show visual bullet trails',
    Callback = function(Value) cfg.bullettracers = Value end
})

BulletTracersGroup:AddLabel('Tracer Color'):AddColorPicker('TracerColor', {
    Default = cfg.tracercolor,
    Title = 'Tracer Color',
    Callback = function(Value) cfg.tracercolor = Value end
})

BulletTracersGroup:AddSlider('TracerDuration', {
    Text = 'Duration (seconds)',
    Default = cfg.tracerduration,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(Value) cfg.tracerduration = Value end
})

BulletTracersGroup:AddSlider('TracerTransparency', {
    Text = 'Transparency',
    Default = cfg.tracertransparency,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value) cfg.tracertransparency = Value end
})

BulletTracersGroup:AddSlider('TracerThickness', {
    Text = 'Thickness',
    Default = cfg.tracerthickness,
    Min = 0.05,
    Max = 0.5,
    Rounding = 2,
    Compact = false,
    Callback = function(Value) cfg.tracerthickness = Value end
})

BulletTracersGroup:AddToggle('TracerFade', {
    Text = 'Fade Out',
    Default = cfg.tracerfade,
    Tooltip = 'Make tracers fade out smoothly',
    Callback = function(Value) cfg.tracerfade = Value end
})

local AdvancedESPGroup = Tabs.Visuals:AddRightGroupbox('Advanced ESP', 'sparkles')

AdvancedESPGroup:AddToggle('Chams', {
    Text = 'Chams',
    Default = cfg.chams,
    Tooltip = 'See players through walls',
    Callback = function(Value)
        cfg.chams = Value
        updateAllAdvancedESP()
    end
})

AdvancedESPGroup:AddDropdown('ChamsMaterial', {
    Values = {'ForceField', 'Glass', 'Neon', 'SmoothPlastic'},
    Default = 1,
    Text = 'Chams Material',
    Callback = function(Value)
        cfg.chamsmaterial = Value
        updateAllAdvancedESP()
    end
})

AdvancedESPGroup:AddLabel('Chams Color'):AddColorPicker('ChamsColor', {
    Default = cfg.chamscolor,
    Title = 'Chams Color',
    Callback = function(Value)
        cfg.chamscolor = Value
        updateAllAdvancedESP()
    end
})

AdvancedESPGroup:AddSlider('ChamsTransparency', {
    Text = 'Transparency',
    Default = cfg.chamstransparency,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        cfg.chamstransparency = Value
        updateAllAdvancedESP()
    end
})

AdvancedESPGroup:AddDivider()

AdvancedESPGroup:AddToggle('GlowESP', {
    Text = 'Glow ESP',
    Default = cfg.glowesp,
    Tooltip = 'Highlight players with glow',
    Callback = function(Value)
        cfg.glowesp = Value
        updateAllAdvancedESP()
    end
})

AdvancedESPGroup:AddLabel('Glow Color'):AddColorPicker('GlowColor', {
    Default = cfg.glowcolor,
    Title = 'Glow Outline Color',
    Callback = function(Value)
        cfg.glowcolor = Value
        updateAllAdvancedESP()
    end
})

AdvancedESPGroup:AddLabel('Fill Color'):AddColorPicker('GlowFill', {
    Default = cfg.glowfill,
    Title = 'Glow Fill Color',
    Callback = function(Value)
        cfg.glowfill = Value
        updateAllAdvancedESP()
    end
})

AdvancedESPGroup:AddDivider()

AdvancedESPGroup:AddToggle('HeadDot', {
    Text = 'Head Dot',
    Default = cfg.headdot,
    Tooltip = 'Show dot on player heads',
    Callback = function(Value)
        cfg.headdot = Value
        updateAllAdvancedESP()
    end
})

AdvancedESPGroup:AddLabel('Dot Color'):AddColorPicker('HeadDotColor', {
    Default = cfg.headdotcolor,
    Title = 'Head Dot Color',
    Callback = function(Value)
        cfg.headdotcolor = Value
        updateAllAdvancedESP()
    end
})

AdvancedESPGroup:AddSlider('HeadDotSize', {
    Text = 'Dot Size',
    Default = cfg.headdotsize,
    Min = 0.2,
    Max = 2,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        cfg.headdotsize = Value
        updateAllAdvancedESP()
    end
})

local SessionStatsGroup = Tabs.Visuals:AddRightGroupbox('Session Stats', 'bar-chart')

SessionStatsGroup:AddToggle('ShowStats', {
    Text = 'Show Stats',
    Default = cfg.showstats,
    Tooltip = 'Display session statistics',
    Callback = function(Value)
        cfg.showstats = Value
        createStatsGUI()
    end
})

SessionStatsGroup:AddButton({
    Text = 'Reset Stats',
    Func = function()
        sessionStats.kills = 0
        sessionStats.deaths = 0
        sessionStats.currentStreak = 0
        sessionStats.bestStreak = 0
        sessionStats.shotsHit = 0
        sessionStats.shotsFired = 0
        Library:Notify('Stats reset!', 2)
    end,
    Tooltip = 'Reset all session statistics'
})

SessionStatsGroup:AddLabel('Stats Position:')

SessionStatsGroup:AddSlider('StatsX', {
    Text = 'X Position',
    Default = cfg.statsx,
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        cfg.statsx = Value
        createStatsGUI()
    end
})

SessionStatsGroup:AddSlider('StatsY', {
    Text = 'Y Position',
    Default = cfg.statsy,
    Min = 0,
    Max = 800,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        cfg.statsy = Value
        createStatsGUI()
    end
})

SessionStatsGroup:AddDivider()

SessionStatsGroup:AddToggle('StatsDraggable', {
    Text = 'Draggable',
    Default = cfg.statsdraggable,
    Tooltip = 'Make stats menu draggable',
    Callback = function(Value)
        cfg.statsdraggable = Value
        createStatsGUI()
    end
})

SessionStatsGroup:AddLabel('Background Color'):AddColorPicker('StatsBackgroundColor', {
    Default = cfg.statsbackgroundcolor,
    Title = 'Stats Background',
    Callback = function(Value)
        cfg.statsbackgroundcolor = Value
    end
})

SessionStatsGroup:AddLabel('Title Color'):AddColorPicker('StatsTitleColor', {
    Default = cfg.statstitlecolor,
    Title = 'Stats Title',
    Callback = function(Value)
        cfg.statstitlecolor = Value
    end
})

SessionStatsGroup:AddLabel('Text Color'):AddColorPicker('StatsTextColor', {
    Default = cfg.statstextcolor,
    Title = 'Stats Text',
    Callback = function(Value)
        cfg.statstextcolor = Value
    end
})

local KillSayGroup = Tabs.Visuals:AddLeftGroupbox('Kill Say', 'message-circle')

KillSayGroup:AddToggle('KillSay', {
    Text = 'Enable Kill Say',
    Default = cfg.killsay,
    Tooltip = 'Send message in chat when you kill',
    Callback = function(Value) cfg.killsay = Value end
})

KillSayGroup:AddLabel('Phrases (use {DISPLAYNAME}):')

for i = 1, 5 do
    KillSayGroup:AddInput('KillSayPhrase' .. i, {
        Default = cfg.killsayphrases[i] or '',
        Text = 'Phrase ' .. i,
        Placeholder = 'Enter phrase...',
        Callback = function(Value)
            cfg.killsayphrases[i] = Value
        end
    })
end

local OptimizationGroup = Tabs.FPSBoost:AddLeftGroupbox('Optimizations', 'gauge')

OptimizationGroup:AddToggle('NoTextures', {
    Text = 'No Textures',
    Default = cfg.fpsboost.notextures,
    Tooltip = 'Remove all textures from parts',
    Callback = function(Value)
        cfg.fpsboost.notextures = Value
        if Value then removeTextures() end
    end
})

OptimizationGroup:AddToggle('NoDecals', {
    Text = 'No Decals',
    Default = cfg.fpsboost.nodecals,
    Tooltip = 'Remove all decals and surface guis',
    Callback = function(Value)
        cfg.fpsboost.nodecals = Value
        if Value then removeDecals() end
    end
})

OptimizationGroup:AddToggle('NoParticles', {
    Text = 'No Particles',
    Default = cfg.fpsboost.noparticles,
    Tooltip = 'Disable all particle effects',
    Callback = function(Value)
        cfg.fpsboost.noparticles = Value
        if Value then removeParticles() end
    end
})

OptimizationGroup:AddToggle('NoSky', {
    Text = 'No Sky',
    Default = cfg.fpsboost.nosky,
    Tooltip = 'Remove sky, atmosphere, and clouds',
    Callback = function(Value)
        cfg.fpsboost.nosky = Value
        if Value then removeSky() end
    end
})

OptimizationGroup:AddToggle('NoShadows', {
    Text = 'No Shadows',
    Default = cfg.fpsboost.noshadows,
    Tooltip = 'Disable all shadows',
    Callback = function(Value)
        cfg.fpsboost.noshadows = Value
        removeShadows()
    end
})

OptimizationGroup:AddToggle('LowQuality', {
    Text = 'Low Quality',
    Default = cfg.fpsboost.lowquality,
    Tooltip = 'Set rendering quality to lowest',
    Callback = function(Value)
        cfg.fpsboost.lowquality = Value
        if Value then applyLowQuality() end
    end
})

OptimizationGroup:AddToggle('NightMode', {
    Text = 'Night Mode',
    Default = cfg.fpsboost.nightmode,
    Tooltip = 'Set time to midnight, remove ambient light',
    Callback = function(Value)
        cfg.fpsboost.nightmode = Value
        applyNightMode()
    end
})

local ActionsGroup = Tabs.FPSBoost:AddRightGroupbox('Actions', 'settings')

ActionsGroup:AddButton({
    Text = 'Apply All Optimizations',
    Func = function()
        cfg.fpsboost.notextures = true
        cfg.fpsboost.nodecals = true
        cfg.fpsboost.noparticles = true
        cfg.fpsboost.nosky = true
        cfg.fpsboost.lowquality = true
        cfg.fpsboost.noshadows = true
        
        applyAllOptimizations()
        
        Toggles.NoTextures:SetValue(true)
        Toggles.NoDecals:SetValue(true)
        Toggles.NoParticles:SetValue(true)
        Toggles.NoSky:SetValue(true)
        Toggles.LowQuality:SetValue(true)
        Toggles.NoShadows:SetValue(true)
    end,
    Tooltip = 'Enable all FPS boost options at once'
})

ActionsGroup:AddButton({
    Text = 'Reset All',
    Func = function()
        resetOptimizations()
        
        Toggles.NoTextures:SetValue(false)
        Toggles.NoDecals:SetValue(false)
        Toggles.NoParticles:SetValue(false)
        Toggles.NoSky:SetValue(false)
        Toggles.LowQuality:SetValue(false)
        Toggles.NoShadows:SetValue(false)
        Toggles.NightMode:SetValue(false)
    end,
    Tooltip = 'Reset all optimizations (rejoin for full reset)'
})

ActionsGroup:AddDivider()

ActionsGroup:AddDropdown('FPSPreset', {
    Values = {'potato pc', 'balanced', 'quality' },
    Default = 2,
    Multi = false,
    Text = 'FPS Preset',
    Tooltip = 'Quick preset configurations',
    Callback = function(Value)
        if Value == 'Potato PC' then
            cfg.fpsboost.notextures = true
            cfg.fpsboost.nodecals = true
            cfg.fpsboost.noparticles = true
            cfg.fpsboost.nosky = true
            cfg.fpsboost.lowquality = true
            cfg.fpsboost.noshadows = true
            cfg.fpsboost.nightmode = true
            
            applyAllOptimizations()
            
            Toggles.NoTextures:SetValue(true)
            Toggles.NoDecals:SetValue(true)
            Toggles.NoParticles:SetValue(true)
            Toggles.NoSky:SetValue(true)
            Toggles.LowQuality:SetValue(true)
            Toggles.NoShadows:SetValue(true)
            Toggles.NightMode:SetValue(true)
            
            Library:Notify('potato enabled', 3)
            
        elseif Value == 'Balanced' then
            cfg.fpsboost.notextures = false
            cfg.fpsboost.nodecals = true
            cfg.fpsboost.noparticles = true
            cfg.fpsboost.nosky = false
            cfg.fpsboost.lowquality = false
            cfg.fpsboost.noshadows = true
            cfg.fpsboost.nightmode = false
            
            removeDecals()
            removeParticles()
            removeShadows()
            
            Toggles.NoTextures:SetValue(false)
            Toggles.NoDecals:SetValue(true)
            Toggles.NoParticles:SetValue(true)
            Toggles.NoSky:SetValue(false)
            Toggles.LowQuality:SetValue(false)
            Toggles.NoShadows:SetValue(true)
            Toggles.NightMode:SetValue(false)
            
            Library:Notify('balanced', 3)
            
        elseif Value == 'Quality' then
            resetOptimizations()
            
            Toggles.NoTextures:SetValue(false)
            Toggles.NoDecals:SetValue(false)
            Toggles.NoParticles:SetValue(false)
            Toggles.NoSky:SetValue(false)
            Toggles.LowQuality:SetValue(false)
            Toggles.NoShadows:SetValue(false)
            Toggles.NightMode:SetValue(false)
            
            Library:Notify('quality', 3)
        end
    end
})

local InfoGroup = Tabs.FPSBoost:AddLeftGroupbox('Information', 'info')

InfoGroup:AddLabel('tips')
InfoGroup:AddLabel('no tips fucky ou')
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu', 'wrench')

MenuGroup:AddToggle("KeybindMenuOpen", { 
    Default = false, 
    Text = "Open Keybind Menu", 
    Callback = function(value) 
        Library.KeybindFrame.Visible = value 
    end
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor", 
    Default = true, 
    Callback = function(Value) 
        Library.ShowCustomCursor = Value 
    end
})

MenuGroup:AddDropdown('NotificationSide', {
    Values = { 'Left', 'Right' },
    Default = 'Right',
    Text = 'Notification Side',
    Callback = function(Value)
        Library:SetNotifySide(Value)
    end
})

MenuGroup:AddDivider()
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { 
    Default = 'End', 
    NoUI = true, 
    Text = 'Menu keybind' 
})

MenuGroup:AddDivider()

MenuGroup:AddLabel('FPS Label Color'):AddColorPicker('FPSLabelColor', {
    Default = cfg.fpslabelcolor,
    Title = 'FPS Counter Color',
    Callback = function(Value)
        cfg.fpslabelcolor = Value
    end
})

MenuGroup:AddButton('Unload', function() 
    Library:Unload() 
end)

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('prisonlifetaliban')
SaveManager:SetFolder('prisonlifetaliban/configs')

SaveManager:BuildConfigSection(Tabs['UI Settings'])

ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()

Library:Notify('PLT loaded', 5)
Library:Notify('if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~) ', 5)
Library:Notify('if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~) ', 5)
Library:Notify('check console ', 5)
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
print("if you see this DONT USE FLY. DO NOT USE IT, IT WILL GET YOU DETECTED IF USED TOO MUCH (10S~)")
