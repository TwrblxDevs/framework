
-- typed version
return {

	 ["LOGLEVEL"] = {
		["DEBUG"] = 0,
	    ["INFO"] = 1,
        ["WARNING"] = 2,
        ["ERROR"] = 3,
        ["NONE"] = 4,
    },

    ["SERVICESTATUS"] = {
        ["STARTING"] = 0,
        ['DEAD'] = 1,
        ['STOPPED'] = 2,
        ['STOPPING'] = 3,
        ['UNKNOWN'] = 4,
    },

    ['SIGNALS'] = {
        ['SIGSTOP'] = 0,
        ['SIGKILL'] = 1,
        ['SIGUSR1'] = 2,
        ['SIGUSR2'] = 3,
        ['SIGURGNT'] = 4,
        ['SIGMSG'] = 5,
    },
}
