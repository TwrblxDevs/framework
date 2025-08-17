local ReplicatedStorage = game:GetService("ReplicatedStorage")
local err = require(script.Parent.err)
local log = require(ReplicatedStorage.rift_framework.log)

local g_globals = require(ReplicatedStorage.rift_framework.globals.const)

local permissons = {}
local loadedFlags = {}

local function logWarn(msg)
	log:Warn("[BitFlags] " .. msg)
end

local function isEnabled()
	return g_globals.Permissions.bl_enable_permissions
end

local function requireEnabled()
	if not isEnabled() then
		local funcName = debug.info(2, "n") or "Unknown"
		logWarn(funcName .. " called, but permissions are disabled")
		err.throw(0xA)
		return false
	end
	return true
end

function permissons.Init(name, flagNames)
	if not requireEnabled() then
		return nil
	end

	if type(name) ~= "string" then
		logWarn("Init expects a string for name, got " .. typeof(name))
		err.throw(0x0007)
		return nil
	end
	if type(flagNames) ~= "table" then
		logWarn("Init expects a table of flag names, got " .. typeof(flagNames))
		err.throw(0x0002)
		flagNames = {}
	end

	local flags = {}
	for i, flagName in ipairs(flagNames) do
		if type(flagName) ~= "string" then
			logWarn("Flag name at index " .. i .. " is not a string (" .. typeof(flagName) .. ")")
			err.throw(0x0007)
		elseif flags[flagName] then
			logWarn("Duplicate flag name detected: " .. flagName)
			err.throw(0x0006)
		else
			flags[flagName] = 2 ^ (i - 1)
		end
	end

	loadedFlags[name] = flags
	return flags
end

function permissons.GetFlags(name)
	if not requireEnabled() then
		return nil
	end

	local flags = loadedFlags[name]
	if not flags then
		logWarn("No loaded flag set found with name: " .. tostring(name))
		err.throw(0x0008)
	end
	return flags
end

function permissons.Add(flagsValue, flagsTable, flagName)
	if not requireEnabled() then
		return flagsValue
	end

	if type(flagsValue) ~= "number" then
		logWarn("Add expected number for flagsValue, got " .. typeof(flagsValue))
		err.throw(0x0002)
		flagsValue = 0
	end

	local flag = flagsTable[flagName]
	if type(flag) ~= "number" then
		logWarn("Invalid flag name: " .. tostring(flagName))
		err.throw(0x0009)
		flag = 0
	end

	return bit32.bor(flagsValue, flag)
end

function permissons.Remove(flagsValue, flagsTable, flagName)
	if not requireEnabled() then
		return flagsValue
	end

	if type(flagsValue) ~= "number" then
		logWarn("Remove expected number for flagsValue, got " .. typeof(flagsValue))
		err.throw(0x0002)
		flagsValue = 0
	end

	local flag = flagsTable[flagName]
	if type(flag) ~= "number" then
		logWarn("Invalid flag name: " .. tostring(flagName))
		err.throw(0x0009)
		flag = 0
	end

	return bit32.band(flagsValue, bit32.bnot(flag))
end

function permissons.Has(flagsValue, flagsTable, flagName)
	if not requireEnabled() then
		return false
	end

	if type(flagsValue) ~= "number" then
		logWarn("Has expected number for flagsValue, got " .. typeof(flagsValue))
		err.throw(0x0002)
		flagsValue = 0
	end

	local flag = flagsTable[flagName]
	if type(flag) ~= "number" then
		logWarn("Invalid flag name: " .. tostring(flagName))
		err.throw(0x0009)
		flag = 0
	end

	return bit32.band(flagsValue, flag) ~= 0
end

function permissons.GetValue(flagsTable, flagName)
	if not requireEnabled() then
		return nil
	end

	local flag = flagsTable[flagName]
	if type(flag) ~= "number" then
		logWarn("Invalid flag name: " .. tostring(flagName))
		err.throw(0x0009)
		return nil
	end
	return flag
end

function permissons.Combine(...)
	if not requireEnabled() then
		return 0
	end

	local result = 0
	for i, flagsValue in ipairs({ ... }) do
		if type(flagsValue) ~= "number" then
			logWarn(("Combine argument #%d is not a number (got %s)"):format(i, typeof(flagsValue)))
			err.throw(0x0002)
			flagsValue = 0
		end
		result = bit32.bor(result, flagsValue)
	end
	return result
end

permissons.LoadedFlags = loadedFlags

return permissons
