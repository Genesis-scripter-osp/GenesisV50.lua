local Player = loadstring(game:HttpGet("YOUR_URL/core/player.lua"))()
local Utils = loadstring(game:HttpGet("YOUR_URL/core/utils.lua"))()

local AutoFarm = {}

function AutoFarm:Run()

    local enemies = Utils:GetEnemies()

    if #enemies == 0 then return end

    local target = enemies[1]

    local root = Player:Root()

    root.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0,5,0)

end

return AutoFarm
