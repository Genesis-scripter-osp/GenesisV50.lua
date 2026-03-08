local Farm = {}

local player = game.Players.LocalPlayer

function Farm:GetMob()

    local nearest
    local dist = math.huge

    for _,mob in pairs(workspace.Enemies:GetChildren()) do

        if mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then

            local d = (mob.HumanoidRootPart.Position -
            player.Character.HumanoidRootPart.Position).Magnitude

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
        mob.HumanoidRootPart.CFrame * CFrame.new(0,0,4)

    end

end

return Farm
