
-- typed version
return {

	 ["LOGLEVEL"] = {
		["DEBUG"]           = 0,
	    ["INFO"]            = 1,
        ["WARNING"]         = 2,
        ["ERROR"]           = 3,
        ["NONE"]            = 4,
    },

    ["SERVICESTATUS"] = {
<<<<<<< HEAD
        ["STARTING"]        = 0,
        ['DEAD']            = 1,
        ['STOPPED']         = 2,
        ['STOPPING']        = 3,
        ['UNKNOWN']         = 4,
=======
        ["STARTING"] = 0,
        ['DEAD'] = 1,
        ['STOPPED'] = 2,
        ['STOPPING'] = 3,
        ['UNKNOWN'] = 4,
        ['WAITING'] = 5,
        ['NONE'] = 6
>>>>>>> a828c162702ce10c6fd51ffcf2b745b9a5a0da43
    },

    ['SIGNALS'] = {
        ['SIGSTOP']         = 0,
        ['SIGUSR1']         = 1,
        ['SIGUSR2']         = 2,
        ['SIGMSG']          = 3,
        ['SIGURGNT']        = 4,
    },

}
