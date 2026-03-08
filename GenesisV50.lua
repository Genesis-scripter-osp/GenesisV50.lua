-- [[ GENESIS V50 - SUPREME EDITION BY DUY THU ]]
_G.Genesis = {
    Modules = {},
    BaseUrl = "https://raw.githubusercontent.com/Genesis-scripter-osp/GenesisV50.lua/main/",
    BootPriority = {
        "network/manager.lua",
        "systems/combat.lua",
        "ui/window.lua",
        "core/engine.lua"
    }
}

function _G.Genesis:Register(name, module) self.Modules[name] = module end
function _G.Genesis:Get(name) return self.Modules[name] end

for _, path in ipairs(_G.Genesis.BootPriority) do
    local success, result = pcall(function()
        -- KHÔNG để dấu () ở cuối loadstring
        return loadstring(game:HttpGet(_G.Genesis.BaseUrl .. path))
    end)
    
    if success and result then
        local moduleFunc = result() -- Chạy file để lấy Table module
        if moduleFunc and type(moduleFunc) == "table" and moduleFunc.Init then
            pcall(function() moduleFunc:Init() end) -- Kích hoạt Init để hiện Menu
        end
    else
        warn("⚠️ Lỗi nạp file: " .. path)
    end
end
print("👑 GENESIS V50 ĐÃ SẴN SÀNG - CHÚC DUY THU CHƠI GAME VUI VẺ!")
