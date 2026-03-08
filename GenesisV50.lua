-- Genesis Hub Main Loader

if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat task.wait() until game.Players.LocalPlayer

------------------------------------------------
-- HUB TABLE
------------------------------------------------

local Genesis = {}
Genesis.Modules = {}

------------------------------------------------
-- MODULE LOADER
------------------------------------------------

function Genesis:LoadModule(name,path)

    local url =
    "https://raw.githubusercontent.com/Genesis-scripter-osp/GenesisV50.lua/main/"..path

    local success,result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    if success and result then
        self.Modules[name] = result
        print("[Genesis] Loaded:",name)
    else
        warn("[Genesis] Failed:",name)
    end

end

------------------------------------------------
-- LOAD CORE
------------------------------------------------

Genesis:LoadModule("Engine","core/engine.lua")
Genesis:LoadModule("Player","core/player.lua")
Genesis:LoadModule("Services","core/services.lua")
Genesis:LoadModule("Utils","core/utils.lua")

------------------------------------------------
-- LOAD NETWORK
------------------------------------------------

Genesis:LoadModule("Network","network/network.lua")

------------------------------------------------
-- LOAD SYSTEMS
------------------------------------------------

Genesis:LoadModule("AutoFarm","systems/autofarm.lua")
Genesis:LoadModule("FastAttack","systems/fastattack.lua")
Genesis:LoadModule("ServerHop","systems/serverhop.lua")

------------------------------------------------
-- LOAD VISUAL
------------------------------------------------

Genesis:LoadModule("ESP","visual/esp.lua")

------------------------------------------------
-- LOAD UI
------------------------------------------------

Genesis:LoadModule("UI","ui/window.lua")

------------------------------------------------
-- WAIT UI
------------------------------------------------

repeat task.wait() until Genesis.Modules.UI

local UI = Genesis.Modules.UI

UI:Init()

------------------------------------------------
-- CREATE TABS
------------------------------------------------

local FarmTab = UI:CreateTab("Farm")
local CombatTab = UI:CreateTab("Combat")
local VisualTab = UI:CreateTab("Visual")
local ServerTab = UI:CreateTab("Server")

------------------------------------------------
-- FARM FEATURES
------------------------------------------------

FarmTab:CreateToggle("Auto Farm",function(v)

    if Genesis.Modules.AutoFarm then

        if v then
            Genesis.Modules.AutoFarm:Start()
        else
            Genesis.Modules.AutoFarm:Stop()
        end

    end

end)

------------------------------------------------
-- COMBAT FEATURES
------------------------------------------------

CombatTab:CreateToggle("Fast Attack",function(v)

    if Genesis.Modules.FastAttack then

        if v then
            Genesis.Modules.FastAttack:Start()
        else
            Genesis.Modules.FastAttack:Stop()
        end

    end

end)

------------------------------------------------
-- VISUAL FEATURES
------------------------------------------------

VisualTab:CreateToggle("Player ESP",function(v)

    if Genesis.Modules.ESP then
        Genesis.Modules.ESP:Toggle(v)
    end

end)

------------------------------------------------
-- SERVER FEATURES
------------------------------------------------

ServerTab:CreateButton("Server Hop",function()

    if Genesis.Modules.ServerHop then
        Genesis.Modules.ServerHop:Hop()
    end

end)

ServerTab:CreateButton("Rejoin Server",function()

    game:GetService("TeleportService"):
    Teleport(game.PlaceId,game.Players.LocalPlayer)

end)

------------------------------------------------
-- DEBUG TAB
------------------------------------------------

local InfoTab = UI:CreateTab("Info")

InfoTab:CreateButton("Print Loaded Modules",function()

    for name,_ in pairs(Genesis.Modules) do
        print("Loaded:",name)
    end

end)

InfoTab:CreateButton("Destroy Hub",function()

    if UI.Destroy then
        UI:Destroy()
    end

end)

------------------------------------------------
-- FINISH
------------------------------------------------

print("Genesis Hub Loaded Successfully")
