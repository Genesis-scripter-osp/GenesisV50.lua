local UI = {}
function UI:Init()
    _G.Genesis:Register("UI", self)
    local sg = Instance.new("ScreenGui", game.CoreGui)
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 300, 0, 200)
    frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.Active = true
    frame.Draggable = true -- Quan trọng để Duy di chuyển menu
    
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "GENESIS V50 - DUY THU"
    title.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    title.TextColor3 = Color3.new(1, 1, 1)
    print("✅ Menu GenesisV50 đã lên!")
end
return UI
local UI = {}
function UI:Init()
    _G.Genesis:Register("UI", self)
    local sg = Instance.new("ScreenGui", game.CoreGui)
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 300, 0, 250)
    frame.Position = UDim2.new(0.5, -150, 0.5, -125)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.Active = true
    frame.Draggable = true

    -- Tiêu đề
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "GENESIS V50 - DUY THU"
    title.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    title.TextColor3 = Color3.new(1, 1, 1)

    -- Nút bật Auto Farm (Ví dụ)
    local farmBtn = Instance.new("TextButton", frame)
    farmBtn.Size = UDim2.new(0, 260, 0, 40)
    farmBtn.Position = UDim2.new(0, 20, 0, 60)
    farmBtn.Text = "Bật Auto Farm: OFF"
    farmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    farmBtn.TextColor3 = Color3.new(1, 1, 1)

    farmBtn.MouseButton1Click:Connect(function()
        local Combat = _G.Genesis:Get("Combat")
        if Combat then
            Combat.FastAttack = not Combat.FastAttack
            farmBtn.Text = "Bật Auto Farm: " .. (Combat.FastAttack and "ON" or "OFF")
            farmBtn.BackgroundColor3 = Combat.FastAttack and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
        end
    end)
    
    print("✅ Giao diện tính năng đã sẵn sàng!")
end
return UI
