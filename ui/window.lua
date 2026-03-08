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
