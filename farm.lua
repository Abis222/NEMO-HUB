local Farm = {}

Farm.running = false

function Farm:start()
    if self.running then return end
    self.running = true

    print("Auto Farm Started")

    while self.running do
        task.wait(0.3) -- أسرع وأخف

        -- 🔥 هنا تحط عمل الفارم الحقيقي
        -- مثال: ضرب / جمع / انتقال

        pcall(function()
            print("Farming Tick...")
        end)
    end
end

function Farm:stop()
    self.running = false
    print("Auto Farm Stopped")
end

return Farm
