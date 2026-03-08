-- Genesis Hub Main

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

repeat task.wait() until Players.LocalPlayer

--------------------------------------------------
-- HUB TABLE
--------------------------------------------------

local Genesis = {}
Genesis.Modules = {}

--------------------------------------------------
-- MODULE LOADER
--------------------------------------------------

function Genesis:LoadModule(name,path)

    local url =
    "https://raw.githubusercontent.com/Genesis-scripter-osp/GenesisV50.lua/main/"..path

    local success,result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    if success then
        Genesis.Modules[name] = result
        print("Loaded:",name)
    else
        warn("Failed:",name)
    end

end

--------------------------------------------------
-- LOAD CORE
--------------------------------------------------

Genesis:LoadModule("Engine","core/engine.lua")
Genesis:LoadModule("Player","core/player.lua")
Genesis:LoadModule("Services","core/services.lua")
Genesis:LoadModule("Utils","core/utils.lua")

--------------------------------------------------
-- LOAD NETWORK
--------------------------------------------------

Genesis:LoadModule("Network","network/network.lua")

--------------------------------------------------
-- LOAD SYSTEMS
--------------------------------------------------

Genesis:LoadModule("AutoFarm","systems/autofarm.lua")
Genesis:LoadModule("FastAttack","systems/fastattack.lua")
Genesis:LoadModule("ServerHop","systems/serverhop.lua")

--------------------------------------------------
-- LOAD VISUAL
--------------------------------------------------

Genesis:LoadModule("ESP","visual/esp.lua")

--------------------------------------------------
-- LOAD UI
--------------------------------------------------

Genesis:LoadModule("UI","ui/window.lua")

--------------------------------------------------
-- WAIT UI
--------------------------------------------------

repeat task.wait() until Genesis.Modules.UI

local UI = Genesis.Modules.UI

UI:Init()

--------------------------------------------------
-- CREATE TABS
--------------------------------------------------

local FarmTab = UI:CreateTab("Farm")
local CombatTab = UI:CreateTab("Combat")
local VisualTab = UI:CreateTab("Visual")
local ServerTab = UI:CreateTab("Server")

--------------------------------------------------
-- FARM TAB
--------------------------------------------------

if FarmTab then

FarmTab:CreateToggle("Auto Farm",function(v)

    if Genesis.Modules.AutoFarm then

        if v then
            Genesis.Modules.AutoFarm:Start()
        else
            Genesis.Modules.AutoFarm:Stop()
        end

    end

end)

FarmTab:CreateSlider("Farm Speed",1,10,function(v)

    if Genesis.Modules.AutoFarm and Genesis.Modules.AutoFarm.SetSpeed then
        Genesis.Modules.AutoFarm:SetSpeed(v)
    end

end)

end

--------------------------------------------------
-- COMBAT TAB
--------------------------------------------------

if CombatTab then

CombatTab:CreateToggle("Fast Attack",function(v)

    if Genesis.Modules.FastAttack then

        if v then
            Genesis.Modules.FastAttack:Start()
        else
            Genesis.Modules.FastAttack:Stop()
        end

    end

end)

end

--------------------------------------------------
-- VISUAL TAB
--------------------------------------------------

if VisualTab then

VisualTab:CreateToggle("Player ESP",function(v)

    if Genesis.Modules.ESP then
        Genesis.Modules.ESP:Toggle(v)
    end

end)

VisualTab:CreateDropdown("ESP Mode",{"Player","Fruit","Chest"},function(v)

    if Genesis.Modules.ESP and Genesis.Modules.ESP.SetMode then
        Genesis.Modules.ESP:SetMode(v)
    end

end)

end

--------------------------------------------------
-- SERVER TAB
--------------------------------------------------

if ServerTab then

ServerTab:CreateButton("Server Hop",function()

    if Genesis.Modules.ServerHop then
        Genesis.Modules.ServerHop:Hop()
    end

end)

ServerTab:CreateButton("Rejoin Server",function()

    TeleportService:Teleport(game.PlaceId,Players.LocalPlayer)

end)

end

--------------------------------------------------
-- INFO TAB
--------------------------------------------------

local InfoTab = UI:CreateTab("Info")

InfoTab:CreateButton("Print Loaded Modules",function()

    for name,_ in pairs(Genesis.Modules) do
        print("Loaded:",name)
    end

end)

--------------------------------------------------
-- FINISH
--------------------------------------------------

print("Genesis Hub Loaded Successfully")
