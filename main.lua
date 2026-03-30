-- NEMO HUB | By Abbas

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NEMO_HUB"
gui.Parent = game.CoreGui

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 650, 0, 400)
main.Position = UDim2.new(0.5, -325, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BorderSizePixel = 0

-- Sidebar
local side = Instance.new("Frame", main)
side.Size = UDim2.new(0, 180, 1, 0)
side.BackgroundColor3 = Color3.fromRGB(12,12,12)

-- Title
local title = Instance.new("TextLabel", side)
title.Text = "NEMO HUB"
title.Size = UDim2.new(1,0,0,60)
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextScaled = true

-- Tabs
local function Tab(name, y)
    local b = Instance.new("TextButton", side)
    b.Size = UDim2.new(1,-10,0,40)
    b.Position = UDim2.new(0,5,0,y)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(30,30,30)
    b.TextColor3 = Color3.new(1,1,1)
    return b
end

local mainTab = Tab("Main", 70)
local farmTab = Tab("Auto Farm", 120)
local tpTab = Tab("Teleport", 170)

-- Content
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,-180,1,0)
content.Position = UDim2.new(0,180,0,0)
content.BackgroundTransparency = 1

-- Dropdown (Select Tool)
local tool = "Melee"

local dropdown = Instance.new("TextButton", content)
dropdown.Size = UDim2.new(0,200,0,40)
dropdown.Position = UDim2.new(0,20,0,40)
dropdown.Text = "Tool: "..tool
dropdown.BackgroundColor3 = Color3.fromRGB(40,40,40)
dropdown.TextColor3 = Color3.new(1,1,1)

dropdown.MouseButton1Click:Connect(function()
    if tool == "Melee" then
        tool = "Sword"
    elseif tool == "Sword" then
        tool = "Fruit"
    else
        tool = "Melee"
    end
    dropdown.Text = "Tool: "..tool
end)

-- Toggle Auto Farm
local farming = false

local toggle = Instance.new("TextButton", content)
toggle.Size = UDim2.new(0,200,0,40)
toggle.Position = UDim2.new(0,20,0,100)
toggle.Text = "Auto Farm: OFF"
toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
toggle.TextColor3 = Color3.new(1,1,1)

toggle.MouseButton1Click:Connect(function()
    farming = not farming
    toggle.Text = farming and "Auto Farm: ON" or "Auto Farm: OFF"
    toggle.BackgroundColor3 = farming and Color3.fromRGB(0,170,0) or Color3.fromRGB(50,50,50)
end)

-- Toggle GUI (RightShift)
UIS.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.RightShift then
        main.Visible = not main.Visible
    end
end)
