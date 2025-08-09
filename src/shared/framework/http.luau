local g_globals = require(script.Parent.globals)
local g_http = game:GetService("HttpService")
local Logger = require(game.ReplicatedStorage.rift_framework.framework.log).Logger.New(script.Name)

local Http = {}

local function _isHttpAllowed()
	if not g_globals.Const.Http.bl_enabled then
		Logger:Warn("HTTP requests are disabled.")
		return false
	end

	return true
end

local function _isUrlSafe(url: string)
	for _, safeUrl in g_globals.Const.Http.safe_urls do
		if url:sub(1, #safeUrl) == safeUrl then
			return true
		end
	end

	Logger:Warn("URL is not safe: " .. url)
	return false
end

function Http.Post(url: string, data: any)
	if not _isHttpAllowed() then
		Logger:Warn("HTTP request blocked: " .. url)
		return nil
	end

	if not _isUrlSafe(url) then
		Logger:Warn("Unsafe URL blocked: " .. url)
		return nil
	end

	local success, response = pcall(function()
		return g_http:PostAsync(url, g_http:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
	end)

	if not success then
		Logger:Error("HTTP POST request failed: " .. response)
		return nil
	end

	Logger:Info("HTTP POST request successful: " .. url)
	return response
end

function Http.Get(url: string)
	if not _isHttpAllowed() then
		Logger:Warn("HTTP request blocked: " .. url)
		return nil
	end

	if not _isUrlSafe(url) then
		Logger:Warn("Unsafe URL blocked: " .. url)
		return nil
	end

	local success, response = pcall(function()
		return g_http:GetAsync(url)
	end)

	if not success then
		Logger:Error("HTTP GET request failed: " .. response)
		return nil
	end

	Logger:Info("HTTP GET request successful: " .. url)
	return response
end

return Http
