local UI = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local ScreenGui
local Main
local TabsFrame
local PagesFrame
local NotifFrame

local Tabs = {}
local CurrentPage

------------------------------------------------
-- Tween helper
------------------------------------------------

local function tween(obj,props,time)

    TweenService:Create(
        obj,
        TweenInfo.new(time or 0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
        props
    ):Play()

end

------------------------------------------------
-- Ripple Effect
------------------------------------------------

local function ripple(button)

    button.ClipsDescendants = true

    button.MouseButton1Down:Connect(function(x,y)

        local circle = Instance.new("Frame")
        circle.BackgroundTransparency = 0.5
        circle.BackgroundColor3 = Color3.new(1,1,1)
        circle.AnchorPoint = Vector2.new(0.5,0.5)
        circle.Position = UDim2.new(0,x-button.AbsolutePosition.X,0,y-button.AbsolutePosition.Y)
        circle.Size = UDim2.new(0,0,0,0)
        circle.Parent = button

        local corner = Instance.new("UICorner",circle)
        corner.CornerRadius = UDim.new(1,0)

        tween(circle,{Size=UDim2.new(0,200,0,200),BackgroundTransparency=1},0.4)

        task.delay(0.4,function()
            circle:Destroy()
        end)

    end)

end

------------------------------------------------
-- Notification
------------------------------------------------

function UI:Notify(text)

    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0,250,0,50)
    notif.BackgroundColor3 = Color3.fromRGB(30,30,30)
    notif.Position = UDim2.new(1,260,1,-60)
    notif.Parent = NotifFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1,1,1)
    label.Parent = notif

    tween(notif,{Position=UDim2.new(1,-260,1,-60)},0.3)

    task.delay(3,function()
        tween(notif,{Position=UDim2.new(1,260,1,-60)},0.3)
        task.wait(0.3)
        notif:Destroy()
    end)

end

------------------------------------------------
-- INIT
------------------------------------------------

function UI:Init()

    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    ------------------------------------------------

    Main = Instance.new("Frame")
    Main.Size = UDim2.new(0,650,0,420)
    Main.Position = UDim2.new(0.5,-325,0.5,-210)
    Main.BackgroundColor3 = Color3.fromRGB(22,22,22)
    Main.Parent = ScreenGui

    local corner = Instance.new("UICorner",Main)
    corner.CornerRadius = UDim.new(0,8)

    ------------------------------------------------

    local Top = Instance.new("Frame")
    Top.Size = UDim2.new(1,0,0,40)
    Top.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Top.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Text = "Genesis Hub"
    Title.Size = UDim2.new(1,0,1,0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1,1,1)
    Title.TextSize = 20
    Title.Parent = Top

    ------------------------------------------------
    -- Drag window
    ------------------------------------------------

    local dragging
    local dragStart
    local startPos

    Top.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end

    end)

    UIS.InputChanged:Connect(function(input)

        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

            local delta = input.Position - dragStart

            Main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )

        end

    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    ------------------------------------------------
    -- Tabs
    ------------------------------------------------

    TabsFrame = Instance.new("Frame")
    TabsFrame.Size = UDim2.new(0,170,1,-40)
    TabsFrame.Position = UDim2.new(0,0,0,40)
    TabsFrame.BackgroundColor3 = Color3.fromRGB(26,26,26)
    TabsFrame.Parent = Main

    local layout = Instance.new("UIListLayout",TabsFrame)
    layout.Padding = UDim.new(0,5)

    ------------------------------------------------
    -- Pages
    ------------------------------------------------

    PagesFrame = Instance.new("Frame")
    PagesFrame.Size = UDim2.new(1,-170,1,-40)
    PagesFrame.Position = UDim2.new(0,170,0,40)
    PagesFrame.BackgroundTransparency = 1
    PagesFrame.Parent = Main

    ------------------------------------------------
    -- Notification holder
    ------------------------------------------------

    NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(1,0,1,0)
    NotifFrame.BackgroundTransparency = 1
    NotifFrame.Parent = ScreenGui

end

------------------------------------------------
-- TAB
------------------------------------------------

function UI:CreateTab(name,icon)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,0,0,40)
    Button.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Button.Text = name
    Button.TextColor3 = Color3.new(1,1,1)
    Button.Parent = TabsFrame

    ripple(Button)

    ------------------------------------------------

    local Page = Instance.new("Frame")
    Page.Size = UDim2.new(1,0,1,0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = PagesFrame

    local layout = Instance.new("UIListLayout",Page)
    layout.Padding = UDim.new(0,6)

    Tabs[name] = Page

    if not CurrentPage then
        CurrentPage = Page
        Page.Visible = true
    end

    Button.MouseButton1Click:Connect(function()

        if CurrentPage then
            CurrentPage.Visible = false
        end

        Page.Visible = true
        CurrentPage = Page

    end)

    return Page

end

------------------------------------------------
-- BUTTON
------------------------------------------------

function UI:CreateButton(tab,text,callback)

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,-10,0,40)
    button.BackgroundColor3 = Color3.fromRGB(40,40,40)
    button.Text = text
    button.TextColor3 = Color3.new(1,1,1)
    button.Parent = tab

    ripple(button)

    button.MouseButton1Click:Connect(function()

        if callback then
            callback()
        end

    end)

end

------------------------------------------------
-- TOGGLE
------------------------------------------------

function UI:CreateToggle(tab,text,callback)

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-10,0,40)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.Parent = tab

    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0.7,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.3,0,1,0)
    button.Position = UDim2.new(0.7,0,0,0)
    button.Text = "OFF"
    button.BackgroundColor3 = Color3.fromRGB(60,60,60)
    button.TextColor3 = Color3.new(1,1,1)
    button.Parent = frame

    local state = false

    ripple(button)

    button.MouseButton1Click:Connect(function()

        state = not state

        if state then
            button.Text = "ON"
            tween(button,{BackgroundColor3=Color3.fromRGB(0,170,0)},0.2)
        else
            button.Text = "OFF"
            tween(button,{BackgroundColor3=Color3.fromRGB(60,60,60)},0.2)
        end

        if callback then
            callback(state)
        end

    end)

end

------------------------------------------------
-- SLIDER
------------------------------------------------

function UI:CreateSlider(tab,text,min,max,callback)

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-10,0,50)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.Parent = tab

    local label = Instance.new("TextLabel")
    label.Text = text.." : "..min
    label.Size = UDim2.new(1,0,0,20)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1,-20,0,6)
    bar.Position = UDim2.new(0,10,0,30)
    bar.BackgroundColor3 = Color3.fromRGB(60,60,60)
    bar.Parent = frame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0,0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
    fill.Parent = bar

    bar.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1 then

            local pos = (input.Position.X - bar.AbsolutePosition.X)/bar.AbsoluteSize.X
            pos = math.clamp(pos,0,1)

            fill.Size = UDim2.new(pos,0,1,0)

            local value = math.floor(min + (max-min)*pos)

            label.Text = text.." : "..value

            if callback then
                callback(value)
            end

        end

    end)

end

------------------------------------------------
-- DROPDOWN
------------------------------------------------

function UI:CreateDropdown(tab,text,list,callback)

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-10,0,40)
    frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    frame.Parent = tab

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,0,1,0)
    button.Text = text
    button.BackgroundTransparency = 1
    button.TextColor3 = Color3.new(1,1,1)
    button.Parent = frame

    local drop = Instance.new("Frame")
    drop.Size = UDim2.new(1,0,0,0)
    drop.Position = UDim2.new(0,0,1,0)
    drop.BackgroundColor3 = Color3.fromRGB(35,35,35)
    drop.ClipsDescendants = true
    drop.Parent = frame

    local layout = Instance.new("UIListLayout",drop)

    local opened = false

    ripple(button)

    button.MouseButton1Click:Connect(function()

        opened = not opened

        if opened then
            tween(drop,{Size=UDim2.new(1,0,0,#list*30)},0.25)
        else
            tween(drop,{Size=UDim2.new(1,0,0,0)},0.25)
        end

    end)

    for _,v in pairs(list) do

        local opt = Instance.new("TextButton")
        opt.Size = UDim2.new(1,0,0,30)
        opt.Text = v
        opt.BackgroundTransparency = 1
        opt.TextColor3 = Color3.new(1,1,1)
        opt.Parent = drop

        opt.MouseButton1Click:Connect(function()

            button.Text = text.." : "..v
            opened = false
            tween(drop,{Size=UDim2.new(1,0,0,0)},0.25)

            if callback then
                callback(v)
            end

        end)

    end

end

------------------------------------------------

return UI
