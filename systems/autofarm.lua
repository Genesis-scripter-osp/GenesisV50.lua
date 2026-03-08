local Farm = {}

local player = game.Players.LocalPlayer

function Farm:GetMob()

    if not player.Character then return end
    if not player.Character:FindFirstChild("HumanoidRootPart") then return end

    local nearest
    local dist = math.huge

    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return end

    for _,mob in pairs(enemies:GetChildren()) do

        if mob:FindFirstChild("HumanoidRootPart") then

            local myPos = player.Character.HumanoidRootPart.Position
            local mobPos = mob.HumanoidRootPart.Position

            local d = (mobPos - myPos).Magnitude

            if d < dist then
                dist = d
                nearest = mob
            end

        end

    end

    return nearest

end


function Farm:Run()

    local mob = self:GetMob()

    if mob then

        player.Character.HumanoidRootPart.CFrame =
        mob.HumanoidRootPart.CFrame * CFrame.new(0,0,3)

    end

end

return Farm
