-- PLAYER.LUA - Movement features

local Config = _G.SixHX_Config

local function setupFly()
    if Config.State.flyConnection then
        Config.State.flyConnection:Disconnect()
        Config.State.flyConnection = nil
    end
    
    if Config.State.flyBodyVelocity then
        Config.State.flyBodyVelocity:Destroy()
        Config.State.flyBodyVelocity = nil
    end
    
    if Config.State.flyBodyGyro then
        Config.State.flyBodyGyro:Destroy()
        Config.State.flyBodyGyro = nil
    end
    
    if not Config.Toggles.Fly or not Config.Toggles.Fly.Value then return end
    
    local char = Config.LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    Config.State.flyBodyVelocity = Instance.new("BodyVelocity")
    Config.State.flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    Config.State.flyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    Config.State.flyBodyVelocity.Parent = hrp
    
    Config.State.flyBodyGyro = Instance.new("BodyGyro")
    Config.State.flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    Config.State.flyBodyGyro.P = 9e4
    Config.State.flyBodyGyro.Parent = hrp
    
    Config.State.flyConnection = Config.Services.RunService.Heartbeat:Connect(function()
        if Config.State.panicMode or not Config.Toggles.Fly.Value then
            if Config.State.flyBodyVelocity then Config.State.flyBodyVelocity:Destroy() Config.State.flyBodyVelocity = nil end
            if Config.State.flyBodyGyro then Config.State.flyBodyGyro:Destroy() Config.State.flyBodyGyro = nil end
            if Config.State.flyConnection then Config.State.flyConnection:Disconnect() Config.State.flyConnection = nil end
            return
        end
        
        local char = Config.LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp or not Config.State.flyBodyVelocity or not Config.State.flyBodyGyro then return end
        
        local camera = workspace.CurrentCamera
        local speed = Config.Options.FlySpeed.Value
        
        local moveDirection = Vector3.new(0, 0, 0)
        
        if Config.Services.UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + camera.CFrame.LookVector
        end
        if Config.Services.UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - camera.CFrame.LookVector
        end
        if Config.Services.UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - camera.CFrame.RightVector
        end
        if Config.Services.UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + camera.CFrame.RightVector
        end
        if Config.Services.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if Config.Services.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        if moveDirection.Magnitude > 0 then
            Config.State.flyBodyVelocity.Velocity = moveDirection.Unit * speed
        else
            Config.State.flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
        
        Config.State.flyBodyGyro.CFrame = camera.CFrame
    end)
end

local function setupNoclip(enabled)
    if Config.State.noclipConnection then
        Config.State.noclipConnection:Disconnect()
        Config.State.noclipConnection = nil
    end
    
    if enabled and not Config.State.panicMode then
        Config.State.noclipConnection = Config.Services.RunService.Stepped:Connect(function()
            if Config.State.panicMode then return end
            local char = Config.LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end

local function setupBunnyHop(enabled)
    if Config.State.bunnyHopConnection then
        Config.State.bunnyHopConnection:Disconnect()
        Config.State.bunnyHopConnection = nil
    end
    
    if enabled and not Config.State.panicMode then
        Config.State.bunnyHopConnection = Config.Services.RunService.Heartbeat:Connect(function()
            if Config.State.panicMode then return end
            local char = Config.LocalPlayer.Character
            if not char then return end
            
            local humanoid = char:FindFirstChild("Humanoid")
            if not humanoid then return end
            
            if humanoid.FloorMaterial ~= Enum.Material.Air then
                local moveDir = humanoid.MoveDirection
                if moveDir.Magnitude > 0.1 then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
end

local function setupInfiniteJump(enabled)
    if Config.State.infJumpConnection then
        Config.State.infJumpConnection:Disconnect()
        Config.State.infJumpConnection = nil
    end
    
    if enabled and not Config.State.panicMode then
        Config.State.infJumpConnection = Config.Services.UserInputService.JumpRequest:Connect(function()
            if Config.State.panicMode then return end
            local char = Config.LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
end

local function updateWalkSpeed()
    if Config.State.panicMode then return end
    local char = Config.LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid and Config.Toggles.WalkSpeedToggle and Config.Toggles.WalkSpeedToggle.Value then
            humanoid.WalkSpeed = Config.Options.WalkSpeed.Value
        end
    end
end

return {
    setupFly = setupFly,
    setupNoclip = setupNoclip,
    setupBunnyHop = setupBunnyHop,
    setupInfiniteJump = setupInfiniteJump,
    updateWalkSpeed = updateWalkSpeed,
}