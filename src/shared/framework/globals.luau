local Globals = {
	["Const"] = {
		["bl_loaded"] = false,
		["sz_version"] = "INDEV",
		["sz_current_game"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or game.Name,

		["bl_enable_external_log"] = true,
		["Http"] = {
			["bl_enabled"] = true, -- Enable HTTP requests
			["safe_urls"] = {
				"https://roblox.com",
				"http://localhost",
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
