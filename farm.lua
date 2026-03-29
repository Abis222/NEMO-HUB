local Farm = {}

Farm.running = false

function Farm:start()
    self.running = true
    print("Farm started")

    -- هنا تحط كود الفارم حقك
    while self.running do
        wait(1)
        print("Farming...")
    end
end

function Farm:stop()
    self.running = false
    print("Farm stopped")
end

return Farm
