local UI = {}

function UI.create(Farm)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    local ToggleGuiButton = Instance.new("TextButton")
    ToggleGuiButton.Size = UDim2.new(0, 120, 0, 40)
    ToggleGuiButton.Position = UDim2.new(0, 10, 0.5, 0)
    ToggleGuiButton.Text = "Show / Hide"
    ToggleGuiButton.Parent = ScreenGui

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 200, 0, 120)
    Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
    Frame.Parent = ScreenGui
    Frame.Visible = true

    local ToggleFarmButton = Instance.new("TextButton")
    ToggleFarmButton.Size = UDim2.new(1, 0, 1, 0)
    ToggleFarmButton.Text = "Start Farm"
    ToggleFarmButton.Parent = Frame

    local isRunning = false

    ToggleFarmButton.MouseButton1Click:Connect(function()
        isRunning = not isRunning

        if isRunning then
            ToggleFarmButton.Text = "Stop Farm"
            task.spawn(function()
                Farm:start()
            end)
        else
            ToggleFarmButton.Text = "Start Farm"
            Farm:stop()
        end
    end)

    ToggleGuiButton.MouseButton1Click:Connect(function()
        Frame.Visible = not Frame.Visible
    end)
end

return UI
