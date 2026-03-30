-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "NEMO_HUB"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 600, 0, 350)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.BorderSizePixel = 0

-- Sidebar
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15,15,15)

-- Title
local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "NEMO HUB"
Title.Size = UDim2.new(1,0,0,50)
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1

-- Buttons
local function CreateTab(name, posY)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, posY)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    btn.TextColor3 = Color3.new(1,1,1)
    return btn
end

local MainBtn = CreateTab("Main", 60)
local FarmBtn = CreateTab("Auto Farm", 100)
local TeleportBtn = CreateTab("Teleport", 140)

-- Right Panel
local Content = Instance.new("Frame", MainFrame)
Content.Position = UDim2.new(0, 150, 0, 0)
Content.Size = UDim2.new(1, -150, 1, 0)
Content.BackgroundTransparency = 1

-- Toggle مثال
local Toggle = Instance.new("TextButton", Content)
Toggle.Size = UDim2.new(0, 120, 0, 40)
Toggle.Position = UDim2.new(0, 20, 0, 50)
Toggle.Text = "Auto Farm: OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)

local farming = false

Toggle.MouseButton1Click:Connect(function()
    farming = not farming
    Toggle.Text = farming and "Auto Farm: ON" or "Auto Farm: OFF"
    Toggle.BackgroundColor3 = farming and Color3.fromRGB(0,170,0) or Color3.fromRGB(50,50,50)
end)

-- زر إخفاء
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
