local Globals = {
	["Const"] = {
		["bl_loaded"] = false,
		["sz_version"] = "INDEV",
		["sz_current_game"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or game.Name,

		["bl_enable_external_log"] = true,
		["Http"] = {
			["bl_enabled"] = true, -- Enable HTTP requests
			["bl_debug"] = false, -- Enable HTTP debug logging
			["safe_urls"] = {
				"https://roblox.com",
				"http://localhost",
			},
			["misc"] = {
				["max_retries"] = 3, -- Maximum number of retries for failed requests
				["retry_delay"] = 1, -- Delay between retries in seconds
			},
		},
	},
	["Dynamic"] = {
		["sc_connections"] = {}, -- RBXScriptConnection --
		["ss_signals"] = {}, -- RBXScriptSignal     --
	},

	["Enum"] = {
		["LOGLEVEL"] = {
			["DEBUG"] = 0,
			["INFO"] = 1,
			["WARNING"] = 2,
			["ERROR"] = 3,
			["NONE"] = 4,
		},
	},

	["Misc"] = {
		["ll_log_level"] = 0, -- Globals.Enum.LOGLEVEL.DEBUG --
	},
}

table.freeze(Globals.Const)

return Globals
