local RunService = game:GetService("RunService")
local err = require(script.Parent.err)
local g_globals = require(script.Parent.globals)

local Tools = {

	["Connection"] = {},

	["Signal"] = {},

	["Macros"] = {},

	["Object"] = {},

	["Warn"] = {},
}

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

function Tools.Macros.PrintTrace(trace_str: string,use_warn: boolean?)
    local write = nil
    if use_warn then
        write = warn
    else
        write = print
    end
    
    local trace = Tools.Macros.TracebackToTable(trace_str)
    write(`  trace: [`)
    for _,v in trace do
        write(`      {v}`)
    end
    write(` ]`)
end

function Tools.Macros.StudioOnlyBlock(fn: () -> (), __debug_is_studio: boolean?): {}

	if RunService:IsStudio() and __debug_is_studio == true or __debug_is_studio == nil then
		fn()
		return Tools.Macros
	end

	err.throw(0x0003)
	return Tools.Macros
end

return Tools
