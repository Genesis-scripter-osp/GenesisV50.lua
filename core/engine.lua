-- [[ GENESIS V50 - ENGINE CHUẨN ]]
local Engine = {}
_G.Genesis_Loaded = _G.Genesis_Loaded or false -- Biến kiểm tra để không nạp trùng

function Engine:Init()
    if _G.Genesis_Loaded then return end -- Nếu đã nạp rồi thì thoát luôn
    
    print("🚀 Đang khởi động các hệ thống...")
    
    -- Chỉ nạp UI và các hệ thống 1 lần duy nhất
    local UI = _G.Genesis:Get("UI")
    if UI and UI.Init then UI:Init() end
    
    local Combat = _G.Genesis:Get("Combat")
    if Combat and Combat.Init then Combat:Init() end
    
    _G.Genesis_Loaded = true -- Đánh dấu đã nạp thành công
end

return Engine
