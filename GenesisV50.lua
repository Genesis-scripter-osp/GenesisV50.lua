-- Genesis Hub Main

if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat task.wait() until game.Players.LocalPlayer

--------------------------------------------------
-- HUB
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
        self.Modules[name] = result
        print("[Genesis] Loaded:",name)
    else
        warn("[Genesis] Failed:",name)
    end

end

--------------------------------------------------
-- CORE
--------------------------------------------------

Genesis:LoadModule("Engine","core/engine.lua")
Genesis:LoadModule("Player","core/player.lua")
Genesis:LoadModule("Services","core/services.lua")
Genesis:LoadModule("Utils","core/utils.lua")

--------------------------------------------------
-- NETWORK
--------------------------------------------------

Genesis:LoadModule("Network","network/network.lua")

--------------------------------------------------
-- SYSTEMS
--------------------------------------------------

Genesis:LoadModule("AutoFarm","systems/autofarm.lua")
Genesis:LoadModule("FastAttack","systems/fastattack.lua")
Genesis:LoadModule("ServerHop","systems/serverhop.lua")

--------------------------------------------------
-- VISUAL
--------------------------------------------------

Genesis:LoadModule("ESP","visual/esp.lua")

--------------------------------------------------
-- UI
--------------------------------------------------

Genesis:LoadModule("UI","ui/window.lua")

repeat task.wait() until Genesis.Modules.UI

Genesis.Modules.UI:Init()

--------------------------------------------------
-- TABS
--------------------------------------------------

local FarmTab = Genesis.Modules.UI:CreateTab("Farm")
local CombatTab = Genesis.Modules.UI:CreateTab("Combat")
local VisualTab = Genesis.Modules.UI:CreateTab("Visual")
local ServerTab = Genesis.Modules.UI:CreateTab("Server")

--------------------------------------------------
-- FARM
--------------------------------------------------

Genesis.Modules.UI:CreateToggle(FarmTab,"Auto Farm",function(v)

    if Genesis.Modules.AutoFarm then

        if v then
            Genesis.Modules.AutoFarm:Start()
        else
            Genesis.Modules.AutoFarm:Stop()
        end

    end

end)

--------------------------------------------------
-- COMBAT
--------------------------------------------------

Genesis.Modules.UI:CreateToggle(CombatTab,"Fast Attack",function(v)

    if Genesis.Modules.FastAttack then

        if v then
            Genesis.Modules.FastAttack:Start()
        else
            Genesis.Modules.FastAttack:Stop()
        end

    end

end)

--------------------------------------------------
-- VISUAL
--------------------------------------------------

Genesis.Modules.UI:CreateToggle(VisualTab,"Player ESP",function(v)

    if Genesis.Modules.ESP then
        Genesis.Modules.ESP:Toggle(v)
    end

end)

--------------------------------------------------
-- SERVER
--------------------------------------------------

Genesis.Modules.UI:CreateButton(ServerTab,"Server Hop",function()

    if Genesis.Modules.ServerHop then
        Genesis.Modules.ServerHop:Hop()
    end

end)

Genesis.Modules.UI:CreateButton(ServerTab,"Rejoin Server",function()

    game:GetService("TeleportService"):
    Teleport(game.PlaceId,game.Players.LocalPlayer)

end)

--------------------------------------------------
-- FINISH
--------------------------------------------------

print("Genesis Hub Loaded")
