local g_globals = require(script.Parent.globals)

local Tools = {

    ['Connection'] = {},

    ['Signal'] = {},

    ['Macros'] = {},
}

function Tools.Connection.Add(connection: RBXScriptConnection): never
    table.insert(g_globals.Dynamic.sc_connections,connection)
end

function Tools.Signal.Add(signal: RBXScriptSignal): never
    table.insert(g_globals.Dynamic.ss_signals,signal)
end

function Tools.Macros.PlayerInfo(plr: Player): string
    local disp_name = `{plr.DisplayName}`
    local name = `@{plr.Name}`
    local userid = `userid={plr.UserId}`

    return `{disp_name} {name} {userid}`
end


return Tools