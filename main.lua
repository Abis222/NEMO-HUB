-- NEMO HUB | Secure Loader + Server Auth

-- تشفير الرابط
local function decode(b)
    local b64='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    b = string.gsub(b, '[^'..b64..'=]', '')
    return (b:gsub('.', function(x)
        if x == '=' then return '' end
        local r,f='',(b64:find(x)-1)
        for i=6,1,-1 do
            r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0')
        end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if #x ~= 8 then return '' end
        local c=0
        for i=1,8 do
            c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0)
        end
        return string.char(c)
    end))
end

-- روابط مشفرة
local SCRIPT_URL = decode("aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0FiaXMyMjIvTkVNTy1IVUIvbWFpbi9tYWluLmx1YQ==")
local KEY_URL = "https://pastebin.com/eqqcjTxN" -- 🔥 حط رابطك هنا

-- Anti Spam
if getgenv().NEMO then return end
getgenv().NEMO = true

-- طلب مفتاح
local key = game:GetService("Players").LocalPlayer:Kick("Enter Key in Executor Console")

-- تحقق من المفتاح
local valid = false

local success, data = pcall(function()
    return game:HttpGet(KEY_URL)
end)

if success and data then
    if string.find(data, key) then
        valid = true
    end
end

if not valid then
    return warn("Invalid Key ❌")
end

-- تحميل السكربت
local ok, script = pcall(function()
    return game:HttpGet(SCRIPT_URL)
end)

if ok then
    loadstring(script)()
    print("NEMO HUB Loaded 🔥")
else
    warn("Failed to Load Script ❌")
end
