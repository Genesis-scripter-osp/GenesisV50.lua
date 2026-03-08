local Genesis = {}

local BASE = "https://raw.githubusercontent.com/Genesis-scripter-osp/GenesisV50.lua/main/"

function Genesis:Load(path)

    local success,module = pcall(function()
        return loadstring(game:HttpGet(BASE..path))()
    end)

    if success then
        print("Loaded:",path)
        return module
    else
        warn("Genesis Load Error:",path)
        warn(module)
    end

end


-- CORE
local Engine = Genesis:Load("core/engine.lua")
local Player = Genesis:Load("core/player.lua")
local Services = Genesis:Load("core/services.lua")
local Utils = Genesis:Load("core/utils.lua")


-- UI
local UI = Genesis:Load("ui/window.lua")


-- SYSTEMS
local AutoFarm = Genesis:Load("systems/autofarm.lua")
local FastAttack = Genesis:Load("systems/fastattack.lua")


-- VISUAL
local ESP = Genesis:Load("visual/esp.lua")


-- NETWORK
local ServerHop = Genesis:Load("network/serverhop.lua")



-- CREATE UI
local window = UI:CreateWindow("Genesis Hub V5")


window:AddToggle("Auto Farm",function(state)

    if state then

        Engine:AddLoop("AutoFarm",1,function()
            AutoFarm:Run()
        end)

    else

        Engine:RemoveLoop("AutoFarm")

    end

end)



window:AddToggle("Fast Attack",function(state)

    if state then
        task.spawn(function()
            FastAttack:Start()
        end)
    end

end)



window:AddButton("Enemy ESP",function()

    ESP:EnableEnemies()

end)



window:AddButton("Server Hop Low Player",function()

    ServerHop:LowPlayer()

end)



return Genesis
