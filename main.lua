--// Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

--// ScreenGui
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.Name = "BloxFruitStyleUI"

--// Blur effect (simulated UI feel)
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = game.Lighting

--// Main Frame
local Main = Instance.new("Frame")
Main.Parent = gui
Main.Size = UDim2.new(0, 0, 0, 260)
Main.Position = UDim2.new(0.08, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

--// Top Bar
local TopBar = Instance.new("Frame")
TopBar.Parent = Main
TopBar.Size = UDim2.new(1,0,0,35)
TopBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
TopBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.Size = UDim2.new(1,0,1,0)
Title.Text = "⚔ Blox Fruits UI"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.BackgroundTransparency = 1

--// Toggle Button
local Toggle = Instance.new("TextButton")
Toggle.Parent = gui
Toggle.Size = UDim2.new(0,120,0,40)
Toggle.Position = UDim2.new(0,10,0.5,0)
Toggle.Text = "MENU"
Toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)

--// Tabs holder
local Body = Instance.new("Frame")
Body.Parent = Main
Body.Size = UDim2.new(1,0,1,-35)
Body.Position = UDim2.new(0,0,0,35)
Body.BackgroundTransparency = 1

--// Open/Close animation
local opened = false

local function openUI()
	blur.Size = 10
	TweenService:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 340,0,260)
	}):Play()
end

local function closeUI()
	blur.Size = 0
	local t = TweenService:Create(Main, TweenInfo.new(0.35), {
		Size = UDim2.new(0,0,0,260)
	})
	t:Play()
	t.Completed:Wait()
end

Toggle.MouseButton1Click:Connect(function()
	opened = not opened
	if opened then openUI() else closeUI() end
end)

--// Drag System
local dragging, dragInput, startPos, startMouse

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		startMouse = input.Position
		startPos = Main.Position
	end
end)

TopBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - startMouse
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

--// Tabs System
local selected

local function createTab(name, y)
	local b = Instance.new("TextButton")
	b.Parent = Body
	b.Size = UDim2.new(0.9,0,0,35)
	b.Position = UDim2.new(0.05,0,0,y)
	b.Text = name
	b.BackgroundColor3 = Color3.fromRGB(45,45,45)
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.BorderSizePixel = 0
	return b
end

local function highlight(btn)
	if selected then
		selected.BackgroundColor3 = Color3.fromRGB(45,45,45)
	end
	selected = btn
	btn.BackgroundColor3 = Color3.fromRGB(0,170,255)
end

--// Tabs
local MainTab = createTab("🏠 Main", 10)
local CombatTab = createTab("⚔ Combat", 55)
local SettingsTab = createTab("⚙ Settings", 100)

MainTab.MouseButton1Click:Connect(function() highlight(MainTab) end)
CombatTab.MouseButton1Click:Connect(function() highlight(CombatTab) end)
SettingsTab.MouseButton1Click:Connect(function() highlight(SettingsTab) end)

--// Auto Farm Toggle (Main Tab)
local AutoFarm = false

local AutoBtn = Instance.new("TextButton")
AutoBtn.Parent = Body
AutoBtn.Size = UDim2.new(0.9,0,0,40)
AutoBtn.Position = UDim2.new(0.05,0,0,150)
AutoBtn.Text = "Auto Farm: OFF"
AutoBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
AutoBtn.BorderSizePixel = 0

AutoBtn.MouseButton1Click:Connect(function()
	AutoFarm = not AutoFarm

	if AutoFarm then
		AutoBtn.Text = "Auto Farm: ON"
		AutoBtn.BackgroundColor3 = Color3.fromRGB(0,200,100)
	else
		AutoBtn.Text = "Auto Farm: OFF"
		AutoBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
	end
end)

--// Start state (animation in)
Main.Size = UDim2.new(0,0,0,260)
