local Logger = {}
local Object = require(script.Parent)

export type Logger = {
	Info: 		( self: Logger, mssg: string ) -> Logger,
	Warn: 		( self: Logger, mssg: string ) -> Logger,
	Error: 		( self: Logger, mssg: string ) -> Logger,
	Debug: 		( self: Logger, mssg: string ) -> Logger,
	EnterFunc: 	( self: Logger, name: string ) -> Logger,
	ExitFunc:	( self: Logger				 ) -> Logger,
	Delete:		( self: Logger				 ) -> never,

	data: {
		sz_source: string,
		sz_original_source: string,
		bl_is_inside_function: boolean
	},
} & Object.Object<Logger>

function Logger.get(): Logger
    local self = Object.init(Logger,"Logger")
    return self
end

return Logger