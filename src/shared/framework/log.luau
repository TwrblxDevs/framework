local g_globals = require(script.Parent.globals)
local RunService = game:GetService("RunService")
local g_http = game:GetService("HttpService")
local g_tools = require(script.Parent.tools)
local g_enum = g_globals.Enum

local Log = {
	["Etc"] = {
		['re_log_client'] = Instance.new("RemoteEvent");
	},

	["data"] = {
		["bl_created_sink_signal"] = false,
		["real_sink_event"] = nil,
	},

	-- only for better organization
	["Logger"] = {},
}
g_tools.Signal.Add(Log.Etc.re_log_client.OnServerEvent)

function Log.__doExtendedWrite(source: string, msg: string, lvl: number,area: string)
	if not g_globals.Const.bl_enable_external_log then
		return
	end

	task.spawn(function()
		local payload
		local pData = `{area};{source};{msg};{lvl}`

		payload = {
			Url = "http://localhost:8080/log",
			Method = "POST",
			Body = pData,
		}

		g_http:RequestAsync(payload)
	end)
end

function getClientLogEvent(_: Player,source: string,msg: string,lvl: number): never
	Log.__doExtendedWrite(source, msg, lvl, "CLIENT")
end

if RunService:IsServer() then
    local connection = Log.Etc.re_log_client.OnServerEvent:Connect(getClientLogEvent)
    g_tools.Connection.Add(connection)
end
    

function Log.extendedWrite(source: string,msg: string,lvl: number): never
	if g_globals.Const.bl_enable_external_log == false then return end

	if RunService:IsClient() then
		Log.Etc.re_log_client:FireServer(source,msg,lvl)
	else
		Log.__doExtendedWrite(source, msg, lvl, "SERVER")
	end
end

function Log.Etc.ConnectToLogSink(fn: (msg: string, source: string, lvl: number) -> never)
	if Log.data.bl_created_sink_signal == false then
		Log.data.real_sink_event = Instance.new("BindableEvent")
		g_tools.Signal.Add(Log.data.real_sink_event.Event)

		Log.data.bl_created_sink_signal = true
	end

	local sc = Log.data.real_sink_event.Event:Connect(fn)
	g_tools.Connection.Add(sc)
end

function write(source: string, message: string, lvl: number, bypass: boolean?): never
	if lvl == g_enum.LOGLEVEL.NONE and bypass ~= true then
		return
	end

	if Log.data.bl_created_sink_signal then
		Log.data.real_sink_event:Fire(message, source, lvl)
	end

	Log.extendedWrite(source, message, lvl)

	if lvl == g_enum.LOGLEVEL.INFO then
		print(`[{source}] {message}`)

		return
	end

	if lvl == g_enum.LOGLEVEL.WARNING then
		warn(`[{source}/WRN] {message}`)

		return
	end

	if lvl == g_enum.LOGLEVEL.ERROR then
		warn(`[{source}/ERR] {message}`)

		return
	end

	if lvl == g_enum.LOGLEVEL.DEBUG then
		print(`[{source}/DBG] {message}`)

		return
	end

	return
end

function checkLevel(n: number): boolean
	if g_globals.Misc.ll_log_level > n then
		return false
	end

	return true
end

function Log.Info(msg: string, source: string): {}
	if not checkLevel(g_enum.LOGLEVEL.INFO) then
		return
	end

	write(source, msg, g_enum.LOGLEVEL.INFO)

	return Log
end

function Log.Warn(msg: string, source: string): {}
	if not checkLevel(g_enum.LOGLEVEL.WARNING) then
		return
	end

	write(source, msg, g_enum.LOGLEVEL.WARNING)

	return Log
end

function Log.Error(msg: string, source: string): {}
	if not checkLevel(g_enum.LOGLEVEL.ERROR) then
		return Log
	end

	write(source, msg, g_enum.LOGLEVEL.ERROR)

	return Log
end

function Log.Debug(msg: string, source: string): {}
	if not checkLevel(g_enum.LOGLEVEL.DEBUG) then
		return
	end

	write(source, msg, g_enum.LOGLEVEL.DEBUG)

	return Log
end

export type Logger = {
	Info: (string) -> Logger,
	Warn: (string) -> Logger,
	Error: (string) -> Logger,
	Debug: (string) -> Logger,

	__source: string,
}

function Log.Logger.New(source: string): Logger
	local ret: Logger = {
		__source = source,
	}

	local function _info(self: Logger, msg: string): Logger
		Log.Info(msg, self.__source)

		return self
	end

	local function _warn(self: Logger, msg: string): Logger
		Log.Warn(msg, self.__source)

		return self
	end

	local function _error(self: Logger, msg: string): Logger
		Log.Error(msg, self.__source)

		return self
	end

	local function _debug(self: Logger, msg: string): Logger
		Log.Debug(msg, self.__source)

		return self
	end

	ret.Debug = _debug
	ret.Info = _info
	ret.Warn = _warn
	ret.Error = _error

	return ret
end

return Log
