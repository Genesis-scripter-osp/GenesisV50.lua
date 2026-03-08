-- core/engine.lua

local Engine = {}

local Services = {}

Services.Players = game:GetService("Players")
Services.RunService = game:GetService("RunService")
Services.HttpService = game:GetService("HttpService")
Services.UserInputService = game:GetService("UserInputService")
Services.TeleportService = game:GetService("TeleportService")

local LocalPlayer = Services.Players.LocalPlayer

Engine.Modules = {}
Engine.Connections = {}
Engine.Loops = {}

Engine.Started = false

-------------------------------------------------
-- MODULE REGISTER
-------------------------------------------------

function Engine:Register(name,module)

    if not name then
        warn("Module missing name")
        return
    end

    self.Modules[name] = module

end

-------------------------------------------------
-- GET MODULE
-------------------------------------------------

function Engine:Get(name)

    return self.Modules[name]

end

-------------------------------------------------
-- CONNECTION MANAGER
-------------------------------------------------

function Engine:Bind(signal,func)

    local connection = signal:Connect(func)

    table.insert(self.Connections,connection)

    return connection

end

-------------------------------------------------
-- LOOP MANAGER
-------------------------------------------------

function Engine:AddLoop(name,func)

    if self.Loops[name] then
        return
    end

    local running = true

    self.Loops[name] = running

    task.spawn(function()

        while running do

            local success,err = pcall(func)

            if not success then
                warn("Loop error:",err)
            end

            task.wait()

        end

    end)

end

function Engine:StopLoop(name)

    if self.Loops[name] then
        self.Loops[name] = false
    end

end

-------------------------------------------------
-- PLAYER UTIL
-------------------------------------------------

function Engine:GetPlayers()

    return Services.Players:GetPlayers()

end

function Engine:GetLocalPlayer()

    return LocalPlayer

end

-------------------------------------------------
-- CHARACTER UTIL
-------------------------------------------------

function Engine:GetCharacter(player)

    player = player or LocalPlayer

    return player.Character

end

function Engine:GetHumanoid(player)

    local char = self:GetCharacter(player)

    if char then
        return char:FindFirstChildOfClass("Humanoid")
    end

end

function Engine:GetRoot(player)

    local char = self:GetCharacter(player)

    if char then
        return char:FindFirstChild("HumanoidRootPart")
    end

end

-------------------------------------------------
-- SAFE CALL
-------------------------------------------------

function Engine:Safe(func,...)

    local args = {...}

    local success,result = pcall(function()
        return func(unpack(args))
    end)

    if success then
        return result
    else
        warn("Safe call error:",result)
    end

end

-------------------------------------------------
-- NOTIFY
-------------------------------------------------

function Engine:Notify(text)

    print("[Genesis]",text)

end

-------------------------------------------------
-- CHARACTER ADDED EVENT
-------------------------------------------------

function Engine:BindCharacter(func)

    local function run(char)

        task.wait(1)

        func(char)

    end

    if LocalPlayer.Character then
        run(LocalPlayer.Character)
    end

    self:Bind(LocalPlayer.CharacterAdded,run)

end

-------------------------------------------------
-- PLAYER ADDED EVENT
-------------------------------------------------

function Engine:PlayerAdded(func)

    for _,p in pairs(self:GetPlayers()) do
        func(p)
    end

    self:Bind(Services.Players.PlayerAdded,func)

end

-------------------------------------------------
-- FPS LOOP
-------------------------------------------------

function Engine:RenderLoop(func)

    local connection

    connection = Services.RunService.RenderStepped:Connect(function(dt)

        local success,err = pcall(func,dt)

        if not success then
            warn(err)
            connection:Disconnect()
        end

    end)

    table.insert(self.Connections,connection)

end

-------------------------------------------------
-- HEARTBEAT LOOP
-------------------------------------------------

function Engine:HeartbeatLoop(func)

    local connection

    connection = Services.RunService.Heartbeat:Connect(function(dt)

        local success,err = pcall(func,dt)

        if not success then
            warn(err)
            connection:Disconnect()
        end

    end)

    table.insert(self.Connections,connection)

end

-------------------------------------------------
-- CLEANUP
-------------------------------------------------

function Engine:Destroy()

    for _,c in pairs(self.Connections) do
        pcall(function()
            c:Disconnect()
        end)
    end

    self.Connections = {}
    self.Loops = {}

end

-------------------------------------------------
-- INIT
-------------------------------------------------

function Engine:Init()

    if self.Started then return end

    self.Started = true

    self:Notify("Engine started")

end

return Engine
