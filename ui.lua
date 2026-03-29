local UI = {}

function UI.create(Farm)

    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    -- زر فتح اللوحة
    local OpenButton = Instance.new("TextButton")
    OpenButton.Size = UDim2.new(0, 140, 0, 40)
    OpenButton.Position = UDim2.new(0, 10, 0.5, 0)
    OpenButton.Text = "Auto Farm"
    OpenButton.Parent = ScreenGui

    -- اللوحة
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 220, 0, 180)
    Frame.Position = UDim2.new(0.4, 0, 0.35, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.Visible = false
    Frame.Parent = ScreenGui

    Instance.new("UICorner", Frame)

    -- زر Melee
    local Melee = Instance.new("TextButton")
    Melee.Size = UDim2.new(1, -20, 0, 40)
    Melee.Position = UDim2.new(0, 10, 0, 10)
    Melee.Text = "🥊 Melee"
    Melee.Parent = Frame

    -- زر Fruit
    local Fruit = Instance.new("TextButton")
    Fruit.Size = UDim2.new(1, -20, 0, 40)
    Fruit.Position = UDim2.new(0, 10, 0, 60)
    Fruit.Text = "🍇 Fruit"
    Fruit.Parent = Frame

    -- زر Sword
    local Sword = Instance.new("TextButton")
    Sword.Size = UDim2.new(1, -20, 0, 40)
    Sword.Position = UDim2.new(0, 10, 0, 110)
    Sword.Text = "⚔️ Sword"
    Sword.Parent = Frame

    local selected = "Melee"
    Farm.combatType = selected

    local function select(typeName)
        selected = typeName
        Farm.combatType = typeName
        print("Selected Combat:", typeName)
    end

    Melee.MouseButton1Click:Connect(function()
        select("Melee")
    end)

    Fruit.MouseButton1Click:Connect(function()
        select("Fruit")
    end)

    Sword.MouseButton1Click:Connect(function()
        select("Sword")
    end)

    OpenButton.MouseButton1Click:Connect(function()
        Frame.Visible = not Frame.Visible
    end)
end

return UI
