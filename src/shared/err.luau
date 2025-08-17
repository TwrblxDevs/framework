local g_codes = require(script.Parent.globals.error_codes)
local err = {}

--[[
    copy of Tools.Macros.TracebackToTable to prevent
    recursive require()
]]
function TracebackToTable(trace: string): {}
	local traceTable = {}
	for line in string.gmatch(trace, "[^\n]+") do
		table.insert(traceTable, line)
	end
	return traceTable
end

--[[
    copy of Tools.Macros.PrintTrace to prevent
    recursive require()
]]
function PrintTrace(trace_str: string,use_warn: boolean?): never
    local write = nil
    if use_warn then
        write = warn
    else
        write = print
    end
    
    local trace = TracebackToTable(trace_str)
    write(`  trace: [`)
    for _,v in trace do
        write(`      {v}`)
    end
    write(` ]`)
end

function err.throw(code: number,explanation: string?): never
    local trace = debug.traceback()

    if explanation == nil then
        -- fallback to default explanation
        explanation = g_codes.explanations[code]
    end

    warn(`[{g_codes[code]}] {explanation}`)
    PrintTrace(trace,true)
end

return err
