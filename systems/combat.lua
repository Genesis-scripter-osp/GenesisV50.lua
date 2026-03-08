local Combat = { FastAttack = false }

function Combat:Attack()
    if self.FastAttack then
        local lp = game.Players.LocalPlayer
        -- Kiểm tra xem nhân vật có đang cầm vũ khí (Kiếm, Đấm, Trái ác quỷ) không
        local tool = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
        
        if tool then
            -- 1. Gửi lệnh đăng ký đòn đánh lên Server Blox Fruits
            game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterAttack"]:FireServer(tool)
            
            -- 2. Tự động click chuột trái (Bypass cooldown)
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
        else
            -- Nếu không cầm gì thì thông báo nhẹ trong Console (F9)
            -- Duy nhớ phải cầm vũ khí trên tay thì nó mới đánh nhé!
        end
    end
end

function Combat:Init() 
    _G.Genesis:Register("Combat", self)
    -- Chạy vòng lặp đánh liên tục
    game:GetService("RunService").Stepped:Connect(function()
        self:Attack()
    end)
    print("⚔️ Hệ thống Combat đã sẵn sàng!")
end

return Combat
