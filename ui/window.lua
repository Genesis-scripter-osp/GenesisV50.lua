local UI = {}

function UI:Init()
    -- 1. Kiểm tra nếu đã có Menu thì không tạo thêm (Tránh lỗi hiện cả ngàn cái)
    if game.CoreGui:FindFirstChild("GenesisMenu") then return end
    
    _G.Genesis:Register("UI", self)
    
    -- 2. Tạo giao diện chính
    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "GenesisMenu"
    
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 300, 0, 250)
    frame.Position = UDim2.new(0.5, -150, 0.5, -125)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Active = true
    frame.Draggable = true -- Duy có thể di chuyển menu

    -- 3. Tiêu đề bản Hub
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "GENESIS V50 - SUPREME"
    title.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 18

    -- 4. Nút bấm Fast Attack
    local atkBtn = Instance.new("TextButton", frame)
    atkBtn.Size = UDim2.new(0, 260, 0, 50)
    atkBtn.Position = UDim2.new(0, 20, 0, 70)
    atkBtn.Text = "FAST ATTACK: OFF"
    atkBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    atkBtn.TextColor3 = Color3.new(1, 1, 1)
    atkBtn.TextSize = 20

    atkBtn.MouseButton1Click:Connect(function()
        local Combat = _G.Genesis:Get("Combat")
        if Combat then
            Combat.FastAttack = not Combat.FastAttack
            atkBtn.Text = "FAST ATTACK: " .. (Combat.FastAttack and "ON" or "OFF")
            atkBtn.BackgroundColor3 = Combat.FastAttack and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(60, 60, 60)
        end
    end)
end

return UI
