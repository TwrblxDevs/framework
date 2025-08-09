local g_globals = require(script.Parent.globals)
local g_tools = require(script.Parent.tools)
local g_enum = g_globals.Enum

local Log = {
    ['Etc'] = {},

    ['data'] = {
        ['bl_created_sink_signal'] = false,
        ['real_sink_event'] = nil
    },

    -- only for better organization
    ['Logger'] = {},
}

function Log.Etc.ConnectToLogSink(fn: (msg: string, source: string, lvl: number) -> never)
    if Log.data.bl_created_sink_signal == false then
        Log.data.real_sink_event = Instance.new("BindableEvent")
        g_tools.Signal.Add(Log.data.real_sink_event.Event)

        Log.data.bl_created_sink_signal = true
    end

    local sc = Log.data.real_sink_event.Event:Connect(fn)
    g_tools.Connection.Add(sc)
end

function write(source: string,message: string,lvl: number,bypass: boolean?): never
    if lvl == g_enum.LOGLEVEL.NONE and bypass ~= true then return end

    if Log.data.bl_created_sink_signal then
        Log.data.real_sink_event:Fire(message,source,lvl)
    end

    if lvl == g_enum.LOGLEVEL.INFO then
        print(`[{source}/INF] {message}`)

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
    if g_globals.Misc.ll_log_level >= n then
        return false
    end

    return true
end

function Log.Info(msg: string,source: string): never
    if not checkLevel(g_enum.LOGLEVEL.INFO) then return end

    write(source, msg, g_enum.LOGLEVEL.INFO)

    return
end

function Log.Warn(msg: string,source: string): never
    if not checkLevel(g_enum.LOGLEVEL.WARNING) then return end

    write(source, msg, g_enum.LOGLEVEL.WARNING)

    return
end

function Log.Error(msg: string,source: string): never
    if not checkLevel(g_enum.LOGLEVEL.ERROR) then return end

    write(source, msg, g_enum.LOGLEVEL.ERROR)

    return
end

function Log.Debug(msg: string,source: string): never
    if not checkLevel(g_enum.LOGLEVEL.DEBUG) then return end

    write(source, msg, g_enum.LOGLEVEL.DEBUG)

    return
end

export type Logger = {
    Info  :(string) -> never,
    Warn  :(string) -> never,
    Error :(string) -> never,
    Debug :(string) -> never,

    __source :string,
}

function Log.Logger.New(source: string): Logger
    local ret :Logger = {
        __source = source
    }

    local function _info(self :Logger, msg :string)
        Log.Info(msg, self.__source)
    end

    local function _warn(self :Logger, msg :string)
        Log.Warn(msg, self.__source)
    end

    local function _error(self :Logger, msg :string)
        Log.Error(msg, self.__source)
    end

    local function _debug(self :Logger, msg :string)
        Log.Debug(msg, self.__source)
    end

    ret.Debug = _debug
    ret.Info = _info
    ret.Warn = _warn
    ret.Error = _error

    return ret
end

return Log