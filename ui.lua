local UI = {}

function UI.create(Farm)
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")

    local player = Players.LocalPlayer

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    -- زر إظهار / إخفاء
    local ToggleGuiButton = Instance.new("TextButton")
    ToggleGuiButton.Size = UDim2.new(0, 130, 0, 40)
    ToggleGuiButton.Position = UDim2.new(0, 10, 0.5, 0)
    ToggleGuiButton.Text = "Open / Close"
    ToggleGuiButton.Parent = ScreenGui

    -- الفريم الرئيسي
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 220, 0, 140)
    Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.Parent = ScreenGui

    -- شكل احترافي
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Frame

    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 2
    Stroke.Color = Color3.fromRGB(0, 170, 255)
    Stroke.Parent = Frame

    -- زر Start/Stop
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0.5, 0)
    Button.Position = UDim2.new(0.05, 0, 0.25, 0)
    Button.Text = "Start Farm"
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Parent = Frame

    Instance.new("UICorner", Button)

    -- أنيميشن فتح/إغلاق
    local open = true

    local function animateFrame(scale)
        TweenService:Create(
            Frame,
            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = scale}
        ):Play()
    end

    -- تشغيل/إيقاف الفارم
    local running = false

    Button.MouseButton1Click:Connect(function()
        running = not running

        if running then
            Button.Text = "Stop Farm"
            task.spawn(function()
                Farm:start()
            end)
        else
            Button.Text = "Start Farm"
            Farm:stop()
        end
    end)

    -- فتح / إغلاق GUI
    ToggleGuiButton.MouseButton1Click:Connect(function()
        open = not open

        if open then
            Frame.Visible = true
            animateFrame(UDim2.new(0, 220, 0, 140))
        else
            animateFrame(UDim2.new(0, 0, 0, 0))
            task.wait(0.2)
            Frame.Visible = false
        end
    end)
end

return UI
