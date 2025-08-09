local g_globals = require(script.Parent.globals)

local Tools = {
    ['Connection'] = {},
    ['Signal'] = {},
}

function Tools.Connection.Add(connection: RBXScriptConnection): never
    table.insert(g_globals.Dynamic.sc_connections,connection)
end

function Tools.Signal.Add(signal: RBXScriptSignal): never
    table.insert(g_globals.Dynamic.ss_signals,signal)
end


return Tools