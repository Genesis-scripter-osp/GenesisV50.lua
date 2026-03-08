local UI = {}
UI.__index = UI

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local ScreenGui
local MainFrame
local TabButtons
local TabContainer

local Tabs = {}

local Visible = true
local ToggleKey = Enum.KeyCode.RightControl

-------------------------------------------------
-- DRAG SYSTEM
-------------------------------------------------

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)

    local delta = input.Position - dragStart

    MainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )

end

-------------------------------------------------
-- INIT UI
-------------------------------------------------

function UI:Init()

ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GenesisUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,600,0,400)
MainFrame.Position = UDim2.new(0.5,-300,0.5,-200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
MainFrame.Parent = ScreenGui

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1,0,0,35)
Top.BackgroundColor3 = Color3.fromRGB(20,20,20)
Top.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,1,0)
Title.BackgroundTransparency = 1
Title.Text = "Genesis Hub"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 20
Title.Font = Enum.Font.SourceSansBold
Title.Parent = Top

-------------------------------------------------
-- TAB BUTTONS
-------------------------------------------------

TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(0,150,1,-35)
TabButtons.Position = UDim2.new(0,0,0,35)
TabButtons.BackgroundColor3 = Color3.fromRGB(25,25,25)
TabButtons.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = TabButtons

-------------------------------------------------
-- TAB CONTENT
-------------------------------------------------

TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1,-150,1,-35)
TabContainer.Position = UDim2.new(0,150,0,35)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

-------------------------------------------------
-- DRAG
-------------------------------------------------

Top.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 then

dragging = true
dragStart = input.Position
startPos = MainFrame.Position

input.Changed:Connect(function()

if input.UserInputState == Enum.UserInputState.End then
dragging = false
end

end)

end

end)

Top.InputChanged:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseMovement then
dragInput = input
end

end)

UIS.InputChanged:Connect(function(input)

if input == dragInput and dragging then
update(input)
end

end)

-------------------------------------------------
-- TOGGLE KEY
-------------------------------------------------

UIS.InputBegan:Connect(function(input,gp)

if gp then return end

if input.KeyCode == ToggleKey then

Visible = not Visible
ScreenGui.Enabled = Visible

end

end)

end

-------------------------------------------------
-- CREATE TAB
-------------------------------------------------

function UI:CreateTab(name)

local TabButton = Instance.new("TextButton")
TabButton.Size = UDim2.new(1,0,0,40)
TabButton.Text = name
TabButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
TabButton.TextColor3 = Color3.new(1,1,1)
TabButton.Parent = TabButtons

local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1,0,1,0)
TabFrame.BackgroundTransparency = 1
TabFrame.Visible = false
TabFrame.Parent = TabContainer

local Layout = Instance.new("UIListLayout")
Layout.Parent = TabFrame

Tabs[name] = TabFrame

TabButton.MouseButton1Click:Connect(function()

for i,v in pairs(Tabs) do
v.Visible = false
end

TabFrame.Visible = true

end)

-------------------------------------------------
-- TAB OBJECT
-------------------------------------------------

local Tab = {}

-------------------------------------------------
-- BUTTON
-------------------------------------------------

function Tab:CreateButton(text,callback)

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1,-10,0,35)
Button.Text = text
Button.BackgroundColor3 = Color3.fromRGB(60,60,60)
Button.TextColor3 = Color3.new(1,1,1)
Button.Parent = TabFrame

Button.MouseButton1Click:Connect(function()

if callback then
callback()
end

end)

end

-------------------------------------------------
-- TOGGLE
-------------------------------------------------

function Tab:CreateToggle(text,callback)

local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(1,-10,0,35)
Toggle.Text = text.." : OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.Parent = TabFrame

local state = false

Toggle.MouseButton1Click:Connect(function()

state = not state

Toggle.Text = text.." : "..(state and "ON" or "OFF")

if callback then
callback(state)
end

end)

end

-------------------------------------------------
-- SLIDER
-------------------------------------------------

function Tab:CreateSlider(text,min,max,callback)

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1,-10,0,40)
Frame.BackgroundColor3 = Color3.fromRGB(60,60,60)
Frame.Parent = TabFrame

local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1,0,0,20)
Label.Text = text
Label.BackgroundTransparency = 1
Label.TextColor3 = Color3.new(1,1,1)
Label.Parent = Frame

local Slider = Instance.new("TextButton")
Slider.Size = UDim2.new(1,0,0,20)
Slider.Position = UDim2.new(0,0,0,20)
Slider.Text = ""
Slider.BackgroundColor3 = Color3.fromRGB(80,80,80)
Slider.Parent = Frame

local value = min

Slider.MouseButton1Click:Connect(function()

value = value + 1

if value > max then
value = min
end

Label.Text = text.." : "..value

if callback then
callback(value)
end

end)

end

-------------------------------------------------
-- DROPDOWN
-------------------------------------------------

function Tab:CreateDropdown(text,list,callback)

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1,-10,0,35)
Button.Text = text
Button.BackgroundColor3 = Color3.fromRGB(60,60,60)
Button.TextColor3 = Color3.new(1,1,1)
Button.Parent = TabFrame

Button.MouseButton1Click:Connect(function()

local choice = list[math.random(1,#list)]

Button.Text = text.." : "..choice

if callback then
callback(choice)
end

end)

end

return Tab

end

return UI
