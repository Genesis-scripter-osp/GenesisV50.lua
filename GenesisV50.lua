-- Genesis Hub Main

repeat task.wait() until game:IsLoaded()

--------------------------------------------------
-- SERVICES
--------------------------------------------------

local HttpService = game:GetService("HttpService")

--------------------------------------------------
-- LOAD MODULE FUNCTION
--------------------------------------------------

local function LoadModule(path)

    local url =
    "https://raw.githubusercontent.com/Genesis-scripter-osp/GenesisV50.lua/main/"..path

    local success,result = pcall(function()

        return loadstring(game:HttpGet(url))()

    end)

    if success then
        print("Loaded:",path)
        return result
    else
        warn("Failed:",path,result)
    end

end

--------------------------------------------------
-- LOAD CORE
--------------------------------------------------

local Engine = LoadModule("core/engine.lua")

Engine:Init()

--------------------------------------------------
-- LOAD NETWORK
--------------------------------------------------

local Network = LoadModule("network/network.lua")

if Network then
    Network:Init()
    Engine:Register("Network",Network)
end

--------------------------------------------------
-- LOAD SYSTEM
--------------------------------------------------

local ServerHop = LoadModule("system/serverhop.lua")

if ServerHop then
    Engine:Register("ServerHop",ServerHop)
end

--------------------------------------------------
-- LOAD VISUAL
--------------------------------------------------

local ESP = LoadModule("visual/esp.lua")

if ESP then
    Engine:Register("ESP",ESP)
end

--------------------------------------------------
-- LOAD UI
--------------------------------------------------

local Window = LoadModule("ui/window.lua")

local UI = Window.new({
    Title = "Genesis Hub",
    ToggleKey = Enum.KeyCode.RightControl
})

Engine:Register("UI",UI)

--------------------------------------------------
-- UI TABS
--------------------------------------------------

local FarmTab = UI:CreateTab("Farm")
local CombatTab = UI:CreateTab("Combat")
local VisualTab = UI:CreateTab("Visual")
local SystemTab = UI:CreateTab("System")

--------------------------------------------------
-- BUTTONS
--------------------------------------------------

SystemTab:CreateButton({

    Name = "Server Hop",

    Callback = function()

        local hop = Engine:Get("ServerHop")

        if hop then
            hop:Hop()
        end

    end

})

VisualTab:CreateToggle({

    Name = "Player ESP",

    Default = false,

    Callback = function(v)

        local esp = Engine:Get("ESP")

        if esp then

            if v then
                esp:Start()
            else
                esp:Stop()
            end

        end

    end

})

--------------------------------------------------
-- NOTIFY
--------------------------------------------------

Engine:Notify("Genesis Hub Loaded")

print("Genesis Hub Started")
