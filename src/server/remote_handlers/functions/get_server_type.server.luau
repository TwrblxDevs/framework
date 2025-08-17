local remote = require("@libs/remotes").functions.get_server_type

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

remote.OnServerInvoke:Connect(function(_plr: Player)
    return getType()
end)
