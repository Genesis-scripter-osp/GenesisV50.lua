-- [[ GENESIS V50 - SUPREME LOADER BY DUY THU ]]
_G.Genesis = {
    Modules = {},
    -- ĐƯỜNG DẪN ĐẾN KHO CODE CỦA DUY
    BaseUrl = "https://raw.githubusercontent.com/Genesis-scripter-osp/GenesisV50.lua/main/",
    -- THỨ TỰ CHẠY FILE (ĐÃ THÊM AUTO FARM)
    BootPriority = {
        "network/manager.lua",
        "systems/combat.lua",
        "systems/auto_farm.lua", 
        "ui/window.lua",
        "core/engine.lua"
    }
}

-- Hàm đăng ký module
function _G.Genesis:Register(name, module) 
    self.Modules[name] = module 
end

-- Hàm lấy module đã nạp
function _G.Genesis:Get(name) 
    return self.Modules[name] 
end

print("🔄 Genesis V50: Đang khởi tạo hệ thống...")

-- Vòng lặp nạp code từ GitHub
for _, path in ipairs(_G.Genesis.BootPriority) do
    local success, result = pcall(function()
        -- Thêm os.time() để tránh bị lưu cache code cũ
        local url = _G.Genesis.BaseUrl .. path .. "?t=" .. os.time()
        return loadstring(game:HttpGet(url))()
    end)
    
    if not success then
        warn("⚠️ Không thể nạp file: " .. path .. " | Lỗi: " .. tostring(result))
    end
end

print("👑 GENESIS V50 ĐÃ NẠP THÀNH CÔNG!")
