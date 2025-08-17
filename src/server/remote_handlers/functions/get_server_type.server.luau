local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rift_framework = ReplicatedStorage.rift_framework
local remote = require(rift_framework.events.remote_function).get_server_type

local function getType()
    if game.PrivateServerId ~= "" then
        if game.PrivateServerOwnerId ~= 0 then
            return "vip"
        else
            return "reserved"
        end
    else
        return "standard"
    end
end

remote.OnServerInvoke = function(_plr: Player)
    return getType()
end
