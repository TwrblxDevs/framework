local RunService = game:GetService("RunService")
local g_globals = require(script.Parent.globals)

local Tools = {

	["Connection"] = {},

	["Signal"] = {},

	["Macros"] = {},

	["Object"] = {},
}

-- DEPERCATED
function llog(_msg: string)
	print("[tools] ".._msg)
	return
end

function Tools.Connection.Add(connection: RBXScriptConnection): never
	table.insert(g_globals.Dynamic.sc_connections, connection)
end

function Tools.Signal.Add(signal: RBXScriptSignal): never
	table.insert(g_globals.Dynamic.ss_signals, signal)
end

function Tools.Macros.PlayerInfo(plr: Player): string
	local disp_name = `{plr.DisplayName}`
	local name = `@{plr.Name}`
	local userid = `userid={plr.UserId}`

	return `{disp_name} {name} {userid}`
end

function Tools.Macros.TracebackToTable(trace: string): {}
	local traceTable = {}
	for line in string.gmatch(trace, "[^\n]+") do
		table.insert(traceTable, line)
	end
	return traceTable
end

function Tools.Macros.StudioOnlyBlock(fn: () -> ()): {}
	local trace = Tools.Macros.TracebackToTable(debug.traceback())
	local source = trace[2]

	if RunService:IsStudio() then
		fn()
		return Tools.Macros
	end

	warn("Tools.Macros.StudioOnlyBlock: attempted to run code but it was blocked...")
	warn("		source: "..source)
	return Tools.Macros
end

return Tools
