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

		["Branches"] = {
			["main"] = {
				["LatestCommit"] = {
					["sz_sha"] = "",
					["sz_message"] = "",
					["sz_author"] = "",
					["sz_commit_date"] = "",
				},
			},

			["development"] = {
				["LatestCommit"] = {
					["sz_sha"] = "",
					["sz_message"] = "",
					["sz_author"] = "",
					["sz_commit_date"] = "",
				},
			},
		},
	},

	["Permissions"] = {
		["bl_enable_permissions"] = true, -- Enable permissions system
		["flags"] = {
			["isTester"] = true,
		},
	},

	["Globals"] = {
		["bl_enable_globals"] = true, -- Enable global variables
	},

	["HttpService"] = HttpService,
}

----- FREEZE STUFF ------

-- init some Globals before we freeze...
--		ts worked first  try :)
local devel_url =
	`https://api.github.com/repos/{Const.Github.sz_organization}/{Const.Github.sz_repo}/commits?sha=development&per_page=1`
local main_url = `https://api.github.com/repos/{Const.Github.sz_organization}/{Const.Github.sz_repo}/commits`
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
			local commit_data = Const.Github.Branches.main.LatestCommit

			commit_data.sz_sha = latest.sha
			commit_data.sz_message = latest.commit.message
			commit_data.sz_author = latest.commit.author.name
			commit_data.sz_commit_date = latest.commit.author.date
		else
			warn(response)
		end
	end
else
	warn("error fetching github api: " .. response)
end

-- framework:development
ok, response = pcall(function()
	return HttpService:GetAsync(devel_url)
end)

if ok then
	if response then
		local commits = HttpService:JSONDecode(response)

		if commits and #commits > 0 then
			local latest = commits[1]
			local commit_data = Const.Github.Branches.development.LatestCommit

			commit_data.sz_sha = latest.sha
			commit_data.sz_message = latest.commit.message
			commit_data.sz_author = latest.commit.author.name
			commit_data.sz_commit_date = latest.commit.author.date
		else
			warn(response)
		end
	end
else
	warn("error fetching github api: " .. response)
end
--

table.freeze(Const)

return Const
