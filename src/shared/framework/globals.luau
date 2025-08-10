local HttpService = game:GetService("HttpService")

local Globals = {
	["Const"] = {
		["bl_loaded"] = false,
		["sz_version"] = "INDEV",
		["sz_current_game"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or game.Name,
		["dw_current_game_version"] = game.PlaceVersion,
		['dw_latest_game_version'] = game:GetService('InsertService'):GetLatestAssetVersionAsync(game.PlaceId),

		["bl_enable_external_log"] = true,
		["Http"] = {
			["bl_enabled"] = true, -- Enable HTTP requests
			["safe_urls"] = {
				"https://roblox.com",
				"http://localhost",
				"http://api.emgkwc.com"
			},
		},

		['Github'] = {
			['sz_organization'] = "Rift-Creations-Inc",
			['sz_repo'] = "framework",
			['sz_url'] = "https://github.com/Rift-Creations-Inc/framework/",

			['Branches'] = {

				['main'] = {

					['LatestCommit'] = {
						['sz_sha'] = "",
						['sz_message'] = "",
						['sz_author'] = "",
						['sz_commit_date'] = "",
					}
				},

				['development'] = {

					['LatestCommit'] = {
						['sz_sha'] = "",
						['sz_message'] = "",
						['sz_author'] = "",
						['sz_commit_date'] = "",
					}
				},

			},
		},
	},

	["Dynamic"] = {
		["sc_connections"] = {}, -- RBXScriptConnection --
		["ss_signals"] = {}, -- RBXScriptSignal     --
	},

	['Analytics'] = {
		['Http'] = {
			['dw_get_cnt'] = 0,
			['dw_post_cnt'] = 0,
			['dw_put_cnt'] = 0,
		},
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


-- init some Globals before we freeze...
--		ts worked first  try :)
local devel_url = `https://api.github.com/repos/{Globals.Const.Github.sz_organization}/{Globals.Const.Github.sz_repo}/commits?sha=development&per_page=1`
local main_url = `https://api.github.com/repos/{Globals.Const.Github.sz_organization}/{Globals.Const.Github.sz_repo}/commits`
local ok, response

-- framework:main
ok, response = pcall(function()
	return HttpService:GetAsync(main_url)
end)

if ok then
	if response then
		local commits = HttpService:JSONDecode(response)

		if commits and #commits > 0 then
			local latest = commits[1]
			local commit_data = Globals.Const.Github.Branches.main.LatestCommit

			commit_data.sz_sha = latest.sha
			commit_data.sz_message = latest.commit.message
			commit_data.sz_author = latest.commit.author.name
			commit_data.sz_commit_date = latest.commit.author.date

		else
			warn(response)
		end
	end
	warn(response)
else
	warn("error fetching github api: "..response)
end
--
-- framework:development
ok, response = pcall(function()
	return HttpService:GetAsync(devel_url)
end)

if ok then
	if response then
		local commits = HttpService:JSONDecode(response)

		if commits and #commits > 0 then
			local latest = commits[1]
			local commit_data = Globals.Const.Github.Branches.development.LatestCommit

			commit_data.sz_sha = latest.sha
			commit_data.sz_message = latest.commit.message
			commit_data.sz_author = latest.commit.author.name
			commit_data.sz_commit_date = latest.commit.author.date

		else
			warn(response)
		end
	end
	warn(response)
else
	warn("error fetching github api: "..response)
end
--

table.freeze(Globals.Const)

return Globals
