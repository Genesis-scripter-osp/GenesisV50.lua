-- Trong file engine.lua của Duy cần có đoạn này:
for _, path in pairs(_G.Genesis.BootPriority) do
    local success, result = pcall(function()
        return loadstring(game:HttpGet(_G.Genesis.BaseUrl .. path))()
    end)
    if success and result then
        if result.Init then result:Init() end -- Đây là dòng kích hoạt Init()
    end
end
