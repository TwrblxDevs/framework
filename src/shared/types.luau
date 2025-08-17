
export type __internal_LogFunc = (
    self: Logger,
    msg: string
) -> Logger

export type ServiceEntryFunc = (
    service: Service
) -> Logger

export type SignalHandlerFunction = (
    signal: number
) -> never

export type __internal_SelfFunc<T> = (
    self: T
) -> T

export type array<T> = {T}

export type Logger = {
    Info: __internal_LogFunc,
    Warn: __internal_LogFunc,
    Error: __internal_LogFunc,
    Debug: __internal_LogFunc,

    EnterFunc: (
        self: Logger,
        name: string
    ) -> Logger,

    ExitFunc: __internal_SelfFunc<Logger>,

    data: {
        sz_source: string,
        sz_original_source: string,
        bl_is_inside_function: boolean
    },

    __type_name: "Logger"
}

export type ServiceSignal = {
    Send: (
        self: ServiceSignal,
        signal: number -- Globals.Enum.SIGNALS
    ) -> ServiceSignal,

    SetSignalHandler: (
        self: ServiceSignal,
        signal: number, -- Globals.Enum.SIGNALS
        handler: SignalHandlerFunction
    ) -> ServiceSignal,

    __internal: {
        --[[ used to find the handler, if not found fallback to default handler ]]
        ['SIGSTOP']: SignalHandlerFunction,
        ['SIGUSR1']: SignalHandlerFunction,
        ['SIGUSR2']: SignalHandlerFunction,
        ['SIGMSG']: SignalHandlerFunction,
        ['SIGURGNT']: SignalHandlerFunction
    },

    __type_name: "ServiceSignal",
}

export type Service = {
    service_name: string,
    service_status: number, -- Globals.Enum.SERVICESTATUS
    service_runner: Instance,
    service_id: number,
    
    Stop: __internal_SelfFunc<Service>,
    Start: __internal_SelfFunc<Service>,
    
    SetStatus: (
        self: Service,
        new: number --[[Globals.Enum.SERVICESTATUS]]
    ) -> Service,

    Signaling: ServiceSignal,
    
    __service_internal: {},
    __type_name: "Service",
}

return {}
