local Net = {}
function Net:Bypass()
    _G.GenesisV50_Key = true -- Tự động xác thực không cần Key
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        if getnamecallmethod() == "Kick" then return nil end -- Chặn Anti-cheat đá Duy
        return old(self, ...)
    end)
    setreadonly(mt, true)
end
function Net:Init() _G.Genesis:Register("Network", self) self:Bypass() end
return Net
