_G.AutoFarm = false

task.spawn(function()
    while true do
        task.wait()
        if _G.AutoFarm then
            print("Farming...")
        end
    end
end)
