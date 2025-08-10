


export type Logger = {
	Info: 		( self: Logger, mssg: string ) -> Logger,
	Warn: 		( self: Logger, mssg: string ) -> Logger,
	Error: 		( self: Logger, mssg: string ) -> Logger,
	Debug: 		( self: Logger, mssg: string ) -> Logger,
	EnterFunc: 	( self: Logger, name: string ) -> Logger,
	ExitFunc:	( self: Logger				 ) -> Logger,

	data: {
		sz_source: string,
		sz_original_source: string,
		bl_is_inside_function: boolean
	},

    __type_name: "Logger"
}

return {}