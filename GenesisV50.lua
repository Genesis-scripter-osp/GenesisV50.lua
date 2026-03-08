-- Genesis Hub V5 Loader

local Genesis = {}

local BASE =
"https://raw.githubusercontent.com/Genesis-scripter-osp/GenesisV50/main/"

function Genesis:Load(path)

    local ok, module = pcall(function()
        return loadstring(game:HttpGet(BASE .. path))()
    end)

    if ok then
        print("[Genesis] Loaded:",path)
        return module
    else
        warn("[Genesis] Failed:",path)
        warn(module)
    end

end

-- load core
local Scheduler =
Genesis:Load("core/scheduler.lua")

-- load ui
local UI =
Genesis:Load("ui/window.lua")

-- load systems
local AutoFarm =
Genesis:Load("systems/autofarm.lua")

local FastAttack =
Genesis:Load("systems/fastattack.lua")

-- load visual
local ESP =
Genesis:Load("visual/esp.lua")

-- load network
local ServerHop =
Genesis:Load("network/serverhop.lua")

-- create window
local window = UI:CreateWindow("Genesis Hub V5")

window:AddToggle("Auto Farm",function(state)

    if state then
        Scheduler:Add("farm",1,function()
            AutoFarm:Run()
        end)
    else
        Scheduler:Remove("farm")
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
