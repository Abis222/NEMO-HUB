local Farm = {}

Farm.running = false
Farm.combatType = "Melee"

------------------------------------------------
-- 🧠 اختيار أقرب عدو
------------------------------------------------
function Farm:getNearestTarget()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")

    local nearest
    local distMin = math.huge

    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return nil end

    for _, mob in pairs(enemies:GetChildren()) do
        local hrp = mob:FindFirstChild("HumanoidRootPart")
        local hum = mob:FindFirstChild("Humanoid")

        if hrp and hum and hum.Health > 0 then
            local d = (root.Position - hrp.Position).Magnitude
            if d < distMin then
                distMin = d
                nearest = mob
            end
        end
    end

    return nearest
end

------------------------------------------------
-- ⚔️ تنفيذ القتال حسب النوع
------------------------------------------------
function Farm:attack(target)
    if not target then return end

    if self.combatType == "Melee" then
        -- 🥊 ضرب يد (مثال Remote)
        game.ReplicatedStorage:WaitForChild("Combat"):FireServer("Melee", target)

    elseif self.combatType == "Fruit" then
        -- 🍇 فاكهة
        game.ReplicatedStorage:WaitForChild("Combat"):FireServer("Fruit", target)

    elseif self.combatType == "Sword" then
        -- ⚔️ سيف
        game.ReplicatedStorage:WaitForChild("Combat"):FireServer("Sword", target)
    end
end

------------------------------------------------
-- 🤖 Loop الفارم الذكي
------------------------------------------------
function Farm:loop()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")

    while self.running do
        task.wait(0.2)

        local target = self:getNearestTarget()

        if target and target:FindFirstChild("HumanoidRootPart") then
            local tRoot = target.HumanoidRootPart

            -- 📍 يقترب من العدو
            root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 3)

            -- ⚔️ يهاجم حسب النوع المختار
            self:attack(target)
        end
    end
end

------------------------------------------------
-- 🚀 Start
------------------------------------------------
function Farm:start()
    if self.running then return end
    self.running = true

    task.spawn(function()
        self:loop()
    end)
end

------------------------------------------------
-- 🛑 Stop
------------------------------------------------
function Farm:stop()
    self.running = false
end

return Farm
