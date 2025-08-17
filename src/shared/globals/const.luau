local HttpService = game:GetService("HttpService")

local Const = {
	["bl_loaded"] = false,
	["sz_version"] = "INDEV",
	["sz_current_game"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or game.Name,
	["dw_current_game_version"] = game.PlaceVersion,
	["dw_latest_game_version"] = game:GetService("InsertService"):GetLatestAssetVersionAsync(game.PlaceId),

	["bl_enable_external_log"] = true,
	["Http"] = {
		["bl_enabled"] = true, -- Enable HTTP requests
		["safe_urls"] = {
			"https://roblox.com",
			"http://localhost",
		},
	},

	["Github"] = {
		["sz_organization"] = "Rift-Creations-Inc",
		["sz_repo"] = "framework",
		["sz_url"] = "https://github.com/Rift-Creations-Inc/framework/",
	},

	["Permissions"] = {
		["bl_enable_permissions"] = true, -- Enable permissions system
		["flags"] = {
			{ "isTester", "isAdmin", "isModerator" }, -- Example flag set
		},
	},

	["Globals"] = {
		["bl_enable_globals"] = true, -- Enable global variables
	},

	["HttpService"] = HttpService,
}

return table.freeze(Const)
