-- system/serverhop.lua

local ServerHop = {}

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local PlaceID = game.PlaceId

-------------------------------------------------
-- GET SERVERS
-------------------------------------------------

function ServerHop:GetServers()

    local url =
    "https://games.roblox.com/v1/games/"..
    PlaceID..
    "/servers/Public?sortOrder=Asc&limit=100"

    local response = game:HttpGet(url)

    local data = HttpService:JSONDecode(response)

    return data.data

end

-------------------------------------------------
-- FIND LOW SERVER
-------------------------------------------------

function ServerHop:Find()

    local servers = self:GetServers()

    local best = nil

    for _,server in pairs(servers) do

        if server.playing < server.maxPlayers then

            if not best then
                best = server
            elseif server.playing < best.playing then
                best = server
            end

        end

    end

    return best

end

-------------------------------------------------
-- HOP
-------------------------------------------------

function ServerHop:Hop()

    local server = self:Find()

    if server then

        TeleportService:TeleportToPlaceInstance(
            PlaceID,
            server.id,
            Players.LocalPlayer
        )

    else

        warn("No server found")

    end

end

return ServerHop
