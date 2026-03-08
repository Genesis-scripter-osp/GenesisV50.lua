-- [[ GENESIS V50 - COMBAT SYSTEM BY DUY THU ]]
local Combat = {
    FastAttack = false, -- Biến này để Menu bật/tắt
    AttackDistance = 15 -- Khoảng cách đánh
}

function Combat:Init()
    _G.Genesis:Register("Combat", self)
    
    -- Vòng lặp kiểm tra và đánh nhanh
    spawn(function()
        while wait() do
            if self.FastAttack then
                pcall(function()
                    -- Lệnh đánh của Blox Fruit (Duy có thể thay đổi tùy bản game)
                    local VirtualUser = game:GetService("VirtualUser")
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton1(Vector2.new(850, 450))
                end)
            end
        end
    end)
    
    print("⚔️ Combat System đã sẵn sàng!")
end

return Combat
