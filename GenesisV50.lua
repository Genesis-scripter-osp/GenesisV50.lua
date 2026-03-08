--// Genesis Hub Main Loader

if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat wait() until game.Players.LocalPlayer

local Genesis = {}
Genesis.Modules = {}

local HttpService = game:GetService("HttpService")

-- Load Module
function Genesis:LoadModule(name, url)

    local success, module = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    if success then
        Genesis.Modules[name] = module
        print("[Genesis] Loaded:", name)
    else
        warn("[Genesis] Failed:", name)
    end

end


-- Base URL
local BASE = "https://raw.githubusercontent.com/Genesis-scripter-osp/GenesisV50.lua/main/"

-- Load Modules
Genesis:LoadModule("UI", BASE.."ui/window.lua")
Genesis:LoadModule("Core", BASE.."core/engine.lua")
Genesis:LoadModule("Visual", BASE.."visual/esp.lua")
Genesis:LoadModule("Network", BASE.."network/serverhop.lua")

-- Wait modules
repeat wait() until Genesis.Modules.UI
repeat wait() until Genesis.Modules.Core

-- Start Hub
Genesis.Modules.UI:Init()

-- Tabs
local FarmTab = Genesis.Modules.UI:CreateTab("Auto Farm")
local CombatTab = Genesis.Modules.UI:CreateTab("Combat")
local VisualTab = Genesis.Modules.UI:CreateTab("Visual")
local ServerTab = Genesis.Modules.UI:CreateTab("Server")

-- Auto Farm
Genesis.Modules.UI:CreateToggle(FarmTab,"Auto Farm",function(v)
    Genesis.Modules.Core.AutoFarm = v
    Genesis.Modules.Core:StartFarm()
end)

-- Fast Attack
Genesis.Modules.UI:CreateToggle(CombatTab,"Fast Attack",function(v)
    Genesis.Modules.Core.FastAttack = v
    Genesis.Modules.Core:FastAttackLoop()
end)

-- ESP
Genesis.Modules.UI:CreateToggle(VisualTab,"ESP Player",function(v)
    Genesis.Modules.Visual:PlayerESP(v)
end)

-- Server Hop
Genesis.Modules.UI:CreateButton(ServerTab,"Server Hop Low Player",function()
    Genesis.Modules.Network:HopLowServer()
end)

print("Genesis Hub Loaded")
