local Players = game:GetService("Players")

local Player = {}

local LocalPlayer = Players.LocalPlayer


function Player:Get()

    return LocalPlayer

end


function Player:Character()

    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

end


function Player:Humanoid()

    return self:Character():WaitForChild("Humanoid")

end


function Player:Root()

    return self:Character():WaitForChild("HumanoidRootPart")

end


return Player
