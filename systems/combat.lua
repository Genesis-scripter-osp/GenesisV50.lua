local Combat = { FastAttack = true }
function Combat:Attack()
    local lp = game.Players.LocalPlayer
    local tool = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
    if tool and self.FastAttack then
        -- Gửi tín hiệu đánh nhanh lên Server
        game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterAttack"]:FireServer(tool)
        -- Giả lập click chuột
        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end
function Combat:Init() 
    _G.Genesis:Register("Combat", self)
    game:GetService("RunService").Stepped:Connect(function() self:Attack() end)
end
return Combat
local Combat = { FastAttack = false }
function Combat:Attack()
    if self.FastAttack then
        local lp = game.Players.LocalPlayer
        local tool = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
        if tool and tool:IsA("Tool") then
            -- Bypass cooldown để đánh siêu nhanh
            game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterAttack"]:FireServer(tool)
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
        end
    end
end
function Combat:Init() 
    _G.Genesis:Register("Combat", self)
    game:GetService("RunService").RenderStepped:Connect(function() self:Attack() end)
end
return Combat
