--// SERVICES
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

--// CONFIG FILE
local configFile = "NEMO_HUB_Config.json"

local function saveConfig(data)
	if writefile then
		writefile(configFile, HttpService:JSONEncode(data))
	end
end

local function loadConfig()
	if readfile and isfile and isfile(configFile) then
		return HttpService:JSONDecode(readfile(configFile))
	end
	return {AutoFarm = false}
end

local config = loadConfig()

--// KEY SYSTEM
local KEY = "NEMO-123"

local KeyUI = Instance.new("ScreenGui")
KeyUI.Parent = CoreGui

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0,300,0,180)
KeyFrame.Position = UDim2.new(0.35,0,0.35,0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
KeyFrame.Parent = KeyUI

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8,0,0,40)
KeyBox.Position = UDim2.new(0.1,0,0.3,0)
KeyBox.PlaceholderText = "Enter Key..."
KeyBox.Parent = KeyFrame

local Enter = Instance.new("TextButton")
Enter.Size = UDim2.new(0.8,0,0,40)
Enter.Position = UDim2.new(0.1,0,0.6,0)
Enter.Text = "Unlock"
Enter.Parent = KeyFrame

--// MAIN HUB (hidden until key)
local gui = Instance.new("ScreenGui")
gui.Parent = CoreGui
gui.Name = "NEMO_HUB"
gui.Enabled = false

--// MAIN FRAME
local Main = Instance.new("Frame")
Main.Parent = gui
Main.Size = UDim2.new(0,0,0,320)
Main.Position = UDim2.new(0.3,0,0.25,0)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.ClipsDescendants = true

--// TOP BAR
local Top = Instance.new("Frame")
Top.Size = UDim2.new(1,0,0,35)
Top.BackgroundColor3 = Color3.fromRGB(30,30,30)
Top.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,1,0)
Title.Text = "⚡ NEMO HUB"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.BackgroundTransparency = 1
Title.Parent = Top

--// SIDEBAR
local Side = Instance.new("Frame")
Side.Size = UDim2.new(0,120,1,-35)
Side.Position = UDim2.new(0,0,0,35)
Side.BackgroundColor3 = Color3.fromRGB(25,25,25)
Side.Parent = Main

--// CONTENT
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-120,1,-35)
Content.Position = UDim2.new(0,120,0,35)
Content.BackgroundTransparency = 1
Content.Parent = Main

--// OPEN ANIMATION
local function openUI()
	gui.Enabled = true
	TweenService:Create(Main, TweenInfo.new(0.35), {
		Size = UDim2.new(0,420,0,320)
	}):Play()
end

--// KEY CHECK
Enter.MouseButton1Click:Connect(function()
	if KeyBox.Text == KEY then
		KeyUI:Destroy()
		openUI()
	else
		KeyBox.Text = "Wrong Key!"
	end
end)

--// TAB SYSTEM
local current

local function createTab(icon, name, y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1,0,0,45)
	b.Position = UDim2.new(0,0,0,y)
	b.Text = icon.." "..name
	b.TextColor3 = Color3.fromRGB(200,200,200)
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.BorderSizePixel = 0
	b.Parent = Side
	return b
end

local function select(btn)
	if current then
		current.BackgroundColor3 = Color3.fromRGB(35,35,35)
	end
	current = btn
	btn.BackgroundColor3 = Color3.fromRGB(0,170,255)
end

--// TABS
local MainTab = createTab("🏠", "Main", 10)
local CombatTab = createTab("⚔", "Combat", 60)
local SettingsTab = createTab("⚙", "Settings", 110)

MainTab.MouseButton1Click:Connect(function() select(MainTab) end)
CombatTab.MouseButton1Click:Connect(function() select(CombatTab) end)
SettingsTab.MouseButton1Click:Connect(function() select(SettingsTab) end)

--// MAIN PAGE - AUTO FARM
local AutoFarm = config.AutoFarm

local AutoBtn = Instance.new("TextButton")
AutoBtn.Parent = Content
AutoBtn.Size = UDim2.new(0,220,0,45)
AutoBtn.Position = UDim2.new(0,20,0,20)
AutoBtn.Text = AutoFarm and "Auto Farm: ON" or "Auto Farm: OFF"
AutoBtn.BackgroundColor3 = AutoFarm and Color3.fromRGB(0,200,100) or Color3.fromRGB(60,60,60)

AutoBtn.MouseButton1Click:Connect(function()
	AutoFarm = not AutoFarm
	config.AutoFarm = AutoFarm

	AutoBtn.Text = AutoFarm and "Auto Farm: ON" or "Auto Farm: OFF"
	AutoBtn.BackgroundColor3 = AutoFarm and Color3.fromRGB(0,200,100) or Color3.fromRGB(60,60,60)

	saveConfig(config)
end)

--// APPLY SAVED STATE
if config.AutoFarm then
	AutoFarm = true
end
