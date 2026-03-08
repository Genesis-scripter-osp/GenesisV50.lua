-- network/network.lua

local Network = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

Network.Remotes = {}

-------------------------------------------------
-- FIND REMOTES
-------------------------------------------------

function Network:Scan()

    for _,v in pairs(ReplicatedStorage:GetDescendants()) do

        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            self.Remotes[v.Name] = v
        end

    end

end

-------------------------------------------------
-- GET REMOTE
-------------------------------------------------

function Network:Get(name)

    return self.Remotes[name]

end

-------------------------------------------------
-- FIRE SERVER
-------------------------------------------------

function Network:Fire(name,...)

    local remote = self:Get(name)

    if remote then

        remote:FireServer(...)

    end

end

-------------------------------------------------
-- INVOKE SERVER
-------------------------------------------------

function Network:Invoke(name,...)

    local remote = self:Get(name)

    if remote then

        return remote:InvokeServer(...)

    end

end

-------------------------------------------------
-- SAFE FIRE
-------------------------------------------------

function Network:SafeFire(name,...)

    local success,err = pcall(function()

        self:Fire(name,...)

    end)

    if not success then
        warn("Remote error:",err)
    end

end

-------------------------------------------------
-- INIT
-------------------------------------------------

function Network:Init()

    self:Scan()

    print("Network loaded:",#self.Remotes)

end

return Network
