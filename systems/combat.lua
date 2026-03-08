local Combat = { FastAttack = false }
function Combat:Attack()
    if self.FastAttack then
        local lp = game.Players.LocalPlayer
        local tool = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
        if tool then
            -- Gửi lệnh đánh liên tục lên server
            game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterAttack"]:FireServer(tool)
            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
    end
end
function Combat:Init() 
    _G.Genesis:Register("Combat", self)
    game:GetService("RunService").RenderStepped:Connect(function() self:Attack() end)
end
return Combat
