local Utils = {}

function Utils:Distance(pos1,pos2)

    return (pos1 - pos2).Magnitude

end


function Utils:Teleport(position)

    local player = game.Players.LocalPlayer
    local char = player.Character

    if char and char:FindFirstChild("HumanoidRootPart") then

        char.HumanoidRootPart.CFrame = CFrame.new(position)

    end

end


function Utils:GetEnemies()

    local enemies = {}

    for _,v in pairs(workspace.Enemies:GetChildren()) do

        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then

            table.insert(enemies,v)

        end

    end

    return enemies

end


return Utils
