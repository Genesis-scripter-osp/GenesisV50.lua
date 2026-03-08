-- [[ GENESIS V50 - CORE ENGINE BY DUY THU ]]
local Engine = {}
_G.Genesis_Loaded = _G.Genesis_Loaded or false -- Kiểm tra xem script đã chạy chưa

function Engine:Init()
    -- Nếu đã nạp rồi thì không chạy lại nữa để tránh bị lặp Menu
    if _G.Genesis_Loaded then 
        return 
    end 
    
    print("🚀 Genesis V50: Đang nạp các module...")
    
    -- Nạp Giao diện (UI)
    local UI = _G.Genesis:Get("UI")
    if UI and UI.Init then 
        pcall(function() UI:Init() end) 
    end
    
    -- Nạp Hệ thống chiến đấu (Combat)
    local Combat = _G.Genesis:Get("Combat")
    if Combat and Combat.Init then 
        pcall(function() Combat:Init() end) 
    end
    
    _G.Genesis_Loaded = true -- Đánh dấu đã nạp thành công
    print("👑 GENESIS V50 ONLINE!")
end

return Engine
