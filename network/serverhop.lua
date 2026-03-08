local Hop = {}

local HttpService = game:GetService("HttpService")

function Hop:LowPlayer()

    local url =
    "https://games.roblox.com/v1/games/"..
    game.PlaceId..
    "/servers/Public?limit=100"

    local data =
    HttpService:JSONDecode(game:HttpGet(url))

    local best

    for _,server in pairs(data.data) do

        if server.playing < 5 then
            best = server.id
            break
        end

    end

    if best then

        game:GetService("TeleportService")
        :TeleportToPlaceInstance(
            game.PlaceId,
            best,
            game.Players.LocalPlayer
        )

    end

end

return Hop
