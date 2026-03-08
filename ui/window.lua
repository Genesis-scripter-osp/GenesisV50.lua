local UI = {}

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GenesisHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-------------------------------------
-- OPEN BUTTON
-------------------------------------

local OpenButton = Instance.new("ImageButton")
OpenButton.Size = UDim2.new(0,50,0,50)
OpenButton.Position = UDim2.new(0,20,0.6,0)
OpenButton.BackgroundTransparency = 1
OpenButton.Image = "rbxassetid://7733964640"
OpenButton.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(1,0)
Corner.Parent = OpenButton

-------------------------------------
-- MAIN WINDOW
-------------------------------------

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,520,0,360)
Main.Position = UDim2.new(0.5,-260,0.5,-180)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.Visible = false
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,8)
MainCorner.Parent = Main

-------------------------------------
-- TOP BAR
-------------------------------------

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1,0,0,40)
TopBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
TopBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.Text = "Genesis Hub"
Title.Size = UDim2.new(0,200,1,0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = TopBar

-------------------------------------
-- CLOSE BUTTON
-------------------------------------

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,40,1,0)
Close.Position = UDim2.new(1,-40,0,0)
Close.Text = "X"
Close.BackgroundTransparency = 1
Close.TextColor3 = Color3.fromRGB(255,70,70)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.Parent = TopBar

-------------------------------------
-- TAB HOLDER
-------------------------------------

local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(0,120,1,-40)
Tabs.Position = UDim2.new(0,0,0,40)
Tabs.BackgroundColor3 = Color3.fromRGB(25,25,25)
Tabs.Parent = Main

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = Tabs
TabLayout.Padding = UDim.new(0,5)

-------------------------------------
-- PAGE HOLDER
-------------------------------------

local Pages = Instance.new("Frame")
Pages.Size = UDim2.new(1,-120,1,-40)
Pages.Position = UDim2.new(0,120,0,40)
Pages.BackgroundTransparency = 1
Pages.Parent = Main

-------------------------------------
-- DRAG SYSTEM
-------------------------------------

local dragging
local dragInput
local dragStart
local startPos

local function update(input)

    local delta = input.Position - dragStart

    Main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

TopBar.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end

        end)
    end
end)

TopBar.InputChanged:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end

end)

UIS.InputChanged:Connect(function(input)

    if input == dragInput and dragging then
        update(input)
    end

end)

-------------------------------------
-- TOGGLE HUB
-------------------------------------

local open = false

OpenButton.MouseButton1Click:Connect(function()

    open = not open

    if open then

        Main.Visible = true

        Main.Size = UDim2.new(0,0,0,0)

        TweenService:Create(
            Main,
            TweenInfo.new(.25),
            {Size = UDim2.new(0,520,0,360)}
        ):Play()

    else

        TweenService:Create(
            Main,
            TweenInfo.new(.2),
            {Size = UDim2.new(0,0,0,0)}
        ):Play()

        wait(.2)
        Main.Visible = false

    end

end)

Close.MouseButton1Click:Connect(function()

    Main.Visible = false
    open = false

end)

-------------------------------------
-- TAB SYSTEM
-------------------------------------

function UI:CreateTab(name)

    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1,0,0,40)
    TabButton.Text = name
    TabButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
    TabButton.TextColor3 = Color3.fromRGB(255,255,255)
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextSize = 14
    TabButton.Parent = Tabs

    local Page = Instance.new("Frame")
    Page.Size = UDim2.new(1,0,1,0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Page.Parent = Pages

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0,6)
    Layout.Parent = Page

    TabButton.MouseButton1Click:Connect(function()

        for i,v in pairs(Pages:GetChildren()) do
            if v:IsA("Frame") then
                v.Visible = false
            end
        end

        Page.Visible = true

    end)

    local TabFunctions = {}

    function TabFunctions:CreateButton(text,callback)

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1,-10,0,35)
        Button.Text = text
        Button.BackgroundColor3 = Color3.fromRGB(50,50,50)
        Button.TextColor3 = Color3.fromRGB(255,255,255)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 14
        Button.Parent = Page

        Button.MouseButton1Click:Connect(callback)

    end

    function TabFunctions:CreateToggle(text,callback)

        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.new(1,-10,0,35)
        Toggle.Text = text.." : OFF"
        Toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
        Toggle.TextColor3 = Color3.fromRGB(255,255,255)
        Toggle.Font = Enum.Font.Gotham
        Toggle.TextSize = 14
        Toggle.Parent = Page

        local state = false

        Toggle.MouseButton1Click:Connect(function()

            state = not state

            Toggle.Text = text.." : "..(state and "ON" or "OFF")

            callback(state)

        end)

    end

    return TabFunctions

end

return UI
