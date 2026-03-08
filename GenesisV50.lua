-- [[ GENESIS V50 - SUPREME EDITION BY DUY THU ]]
_G.Genesis = {
    Modules = {},
    -- ĐƯỜNG DẪN RAW CHUẨN ĐỂ ROBLOX ĐỌC ĐƯỢC CODE
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
        return loadstring(game:HttpGet(_G.Genesis.BaseUrl .. path))()
    end)
    if success and result then
        if result.Init then pcall(function() result:Init() end) end
    else
        warn("⚠️ Lỗi load: " .. path)
    end
end
