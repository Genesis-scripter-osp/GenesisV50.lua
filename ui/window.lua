-- [[ GENESIS V50 - SUPREME UI BY DUY THU ]]
local UI = {}

function UI:Init()
    -- 1. Chống hiện nhiều Menu (Tránh lỗi "cả ngàn cái")
    if game.CoreGui:FindFirstChild("GenesisMenu") then return end
    
    _G.Genesis:Register("UI", self)
    
    -- 2. Tạo ScreenGui chính
    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "GenesisMenu"
    
    -- 3. Khung Menu chính
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 300, 0, 250)
    frame.Position = UDim2.new(0.5, -150, 0.5, -125)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true -- Duy có thể di chuyển menu trên điện thoại

    -- Bo góc cho đẹp
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 10)

    -- 4. Tiêu đề
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "GENESIS V50 - DUY THU"
    title.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 18
    local tCorner = Instance.new("UICorner", title)

    --- [[ HỆ THỐNG NÚT BẤM ]] ---

    -- NÚT 1: FAST ATTACK (Đánh nhanh)
    local atkBtn = Instance.new("TextButton", frame)
    atkBtn.Size = UDim2.new(0, 260, 0, 45)
    atkBtn.Position = UDim2.new(0, 20, 0, 60)
    atkBtn.Text = "FAST ATTACK: OFF"
    atkBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    atkBtn.TextColor3 = Color3.new(1, 1, 1)
    atkBtn.TextSize = 16
    Instance.new("UICorner", atkBtn)

    atkBtn.MouseButton1Click:Connect(function()
        local Combat = _G.Genesis:Get("Combat")
        if Combat then
            Combat.FastAttack = not Combat.FastAttack
            atkBtn.Text = "FAST ATTACK: " .. (Combat.FastAttack and "ON" or "OFF")
            atkBtn.BackgroundColor3 = Combat.FastAttack and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 60)
        end
    end)

    -- NÚT 2: AUTO FARM (Tự động cày cấp)
    local farmBtn = Instance.new("TextButton", frame)
    farmBtn.Size = UDim2.new(0, 260, 0, 45)
    farmBtn.Position = UDim2.new(0, 20, 0, 115)
    farmBtn.Text = "AUTO FARM: OFF"
    farmBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    farmBtn.TextColor3 = Color3.new(1, 1, 1)
    farmBtn.TextSize = 16
    Instance.new("UICorner", farmBtn)

    farmBtn.MouseButton1Click:Connect(function()
        local AF = _G.Genesis:Get("AutoFarm")
        if AF then
            AF.Enabled = not AF.Enabled
            farmBtn.Text = "AUTO FARM: " .. (AF.Enabled and "ON" or "OFF")
            farmBtn.BackgroundColor3 = AF.Enabled and Color3.fromRGB(255, 140, 0) or Color3.fromRGB(60, 60, 60)
        end
    end)

    print("✅ Giao diện Supreme V50 đã sẵn sàng!")
end

return UI
