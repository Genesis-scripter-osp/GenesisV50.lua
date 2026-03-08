-- [[ GENESIS V50 - SUPREME EDITION BY DUY THU ]]
_G.Genesis = {
    Modules = {},
    -- ĐÃ SỬA ĐÚNG ĐƯỜNG DẪN RAW THEO REPO GenesisV50.lua (Ảnh 13)
    BaseUrl = "https://raw.githubusercontent.com/Genesis-scripter-osp/GenesisV50.lua/main/",
    BootPriority = {
        "network/manager.lua", -- Đã có (Ảnh 19)
        "systems/combat.lua",  -- Đã có (Ảnh 18)
        "ui/window.lua",       -- Đã có (Ảnh 20)
        "core/engine.lua"      -- Đã có (Ảnh 17)
    }
}

function _G.Genesis:Register(name, module) self.Modules[name] = module end
function _G.Genesis:Get(name) return self.Modules[name] end

for _, path in ipairs(_G.Genesis.BootPriority) do
    local success, result = pcall(function()
        return loadstring(game:HttpGet(_G.Genesis.BaseUrl .. path))()
    end)
    if success and result then
        if result.Init then pcall(function() result:Init() end) end
    else
        warn("⚠️ Lỗi không tìm thấy file: " .. path)
    end
end
print("👑 GENESIS V50 ONLINE - LOADED BY DUY THU")
