-- Genesis Hub Loader

if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat task.wait() until game.Players.LocalPlayer

local Genesis = {}
Genesis.Modules = {}

function Genesis:LoadModule(name, url)

    local success, module = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    if success then
        self.Modules[name] = module
        print("[Genesis] Loaded:", name)
    else
        warn("[Genesis] Failed:", name)
    end

end


local BASE = "https://raw.githubusercontent.com/Genesis-scripter-osp/GenesisV50.lua/main/"

-- CORE
Genesis:LoadModule("Engine", BASE.."core/engine.lua")
Genesis:LoadModule("Player", BASE.."core/player.lua")
Genesis:LoadModule("Services", BASE.."core/services.lua")
Genesis:LoadModule("Utils", BASE.."core/utils.lua")

-- SYSTEMS
Genesis:LoadModule("AutoFarm", BASE.."systems/autofarm.lua")
Genesis:LoadModule("FastAttack", BASE.."systems/fastattack.lua")

-- VISUAL
Genesis:LoadModule("ESP", BASE.."visual/esp.lua")

-- NETWORK
Genesis:LoadModule("ServerHop", BASE.."network/serverhop.lua")

-- UI
Genesis:LoadModule("UI", BASE.."ui/window.lua")


repeat task.wait() until Genesis.Modules.UI

-- Start UI
Genesis.Modules.UI:Init()

-- Tabs
local FarmTab = Genesis.Modules.UI:CreateTab("Farm")
local CombatTab = Genesis.Modules.UI:CreateTab("Combat")
local VisualTab = Genesis.Modules.UI:CreateTab("Visual")
local ServerTab = Genesis.Modules.UI:CreateTab("Server")

-- Auto Farm
Genesis.Modules.UI:CreateToggle(FarmTab,"Auto Farm",function(v)

    if v then
        Genesis.Modules.AutoFarm:Start()
    else
        Genesis.Modules.AutoFarm:Stop()
    end

end)

-- Fast Attack
Genesis.Modules.UI:CreateToggle(CombatTab,"Fast Attack",function(v)

    if v then
        Genesis.Modules.FastAttack:Start()
    else
        Genesis.Modules.FastAttack:Stop()
    end

end)

-- ESP
Genesis.Modules.UI:CreateToggle(VisualTab,"Player ESP",function(v)
    Genesis.Modules.ESP:Toggle(v)
end)

-- Server Hop
Genesis.Modules.UI:CreateButton(ServerTab,"Hop Low Player",function()
    Genesis.Modules.ServerHop:HopLowServer()
end)

print("Genesis Hub Loaded")
