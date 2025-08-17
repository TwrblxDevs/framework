return {

	[0x0001] = "error_depercated",
	[0x0002] = "error_bad_arg",
	[0x0003] = "error_tried_to_run_studio_only_code",
	[0x0004] = "error_no_entry",
	[0x0005] = "error_permissions_invaild_table",
	[0x0006] = "error_permissions_duplicate_flag",
	[0x0007] = "error_permissions_malformed_or_invaild_string",
	[0x0008] = "error_permissions_no_loaded_flag_set_found",
	[0x0009] = "error_permissions_invalid_flag_name",
	[0xA] = "error_permissions_disabled",

	["explanations"] = {
		[0x0001] = "attempted to execute a depercated function...",
		[0x0002] = "a bad argument was passed...",
		[0x0003] = "attempted to run a studio only code block...",
		[0x0004] = "did you forget to implement 'entry'?",
		[0x0005] = "the table you passed is not valid...",
		[0x0006] = "you tried to set a permission flag that already exists...",
		[0x0007] = "the string you passed is malformed or invalid...",
		[0x0008] = "no loaded flag set found with the name you provided...",
		[0x0009] = "the flag name you provided is invalid or does not exist...",
		[0xA] = "permissions are disabled, but you tried to use them...",
	},
}
