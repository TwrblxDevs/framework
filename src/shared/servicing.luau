local ReplicatedStorage = game:GetService("ReplicatedStorage")
local g_enum = require(ReplicatedStorage.rift_framework.globals.enum)
local g_types = require(ReplicatedStorage.rift_framework.types)
local g_err = require(ReplicatedStorage.rift_framework.err)

local Servicing = {
    ['Service'] = {},

    ['Signal'] = {},
}

function Servicing.Service.Stop(self: g_types.Service)
    print(`[servicing] stop the service!`)
    return self
end

function Servicing.Service.Start(self: g_types.Service)
    -- find the entry point of the ModuleScript
    --      should be named "entry"

    if self.__service_internal['entry'] == nil then
        g_err.throw(0x0004)
        return
    end

    self.__service_internal['entry'](self)

    return self
end

function Servicing.Service.SetStatus(self: g_types.Service,new: number)
    print(`[servicing] new status for {self.service_name} - {new}`)
    self.service_status = new

    return self
end

local function sig_to_string(sig: number)
    local sigs = g_enum.SIGNALS

    for k,v in pairs(sigs) do
        if sig == v then return k end
    end

    return ""
end

function Servicing.Signal.SetSignalHandler(self: g_types.ServiceSignal, sig: number, 
                                           handler: g_types.SignalHandlerFunction
)

    self.__internal[sig_to_string(sig)] = handler

    return self
end

function Servicing.Service.new(name: string,mod: Instance,tbl: {}): g_types.Service
    local _signal_: g_types.ServiceSignal = {
        
    }

    local self: g_types.Service = {
        service_name = name,
        service_status = g_enum.SERVICESTATUS.NONE,
        service_runner = mod :: ModuleScript,
        service_id = math.random(),
        
        Stop = Servicing.Service.Stop,
        Start = Servicing.Service.Start,
        SetStatus = Servicing.Service.SetStatus,
        
        __service_internal = tbl
    }

    return self
end

return Servicing
