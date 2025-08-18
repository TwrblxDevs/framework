local ReplicatedStorage = game:GetService("ReplicatedStorage")
local err = require(script.Parent.err)
local log = require(ReplicatedStorage.rift_framework.log).Logger.New(script.Name)

local g_globals = require(ReplicatedStorage.rift_framework.globals.const)

local permissions = {}
local loadedFlags = {}

local function logWarn(msg)
    log:Warn(msg)
end

local function isEnabled()
    return g_globals.Permissions.bl_enable_permissions
end

local function requireEnabled()
    if not isEnabled() then
        err.throw(0xA)
        return false
    end
    return true
end

function permissions.Init(name, flagNames)
    log:EnterFunc("Init")
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
    log:Info("Permissions initialized with flags for " .. name)
    log:ExitFunc()
    return flags
end

function permissions.GetFlags(name)
    log:EnterFunc("GetFlags")
    if not requireEnabled() then
        return nil
    end

    local flags = loadedFlags[name]
    if not flags then
        logWarn("No loaded flag set found with name: " .. tostring(name))
        err.throw(0x0008)
    end
    log:ExitFunc()
    return flags
end

function permissions.Add(flagsValue, flagsTable, flagName)
    log:EnterFunc("Add")
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

    log:ExitFunc()
    return bit32.bor(flagsValue, flag)
end

function permissions.Remove(flagsValue, flagsTable, flagName)
    if not requireEnabled() then
        return flagsValue
    end
    log:EnterFunc("Remove")

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

    log:ExitFunc()
    return bit32.band(flagsValue, bit32.bnot(flag))
end

function permissions.Has(flagsValue, flagsTable, flagName)
    if not requireEnabled() then
        return false
    end
    log:EnterFunc("Has")

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

    log:ExitFunc()
    return bit32.band(flagsValue, flag) ~= 0
end

function permissions.GetValue(flagsTable, flagName)
    if not requireEnabled() then
        return nil
    end
    log:EnterFunc("GetValue")

    local flag = flagsTable[flagName]
    if type(flag) ~= "number" then
        logWarn("Invalid flag name: " .. tostring(flagName))
        err.throw(0x0009)
        log:ExitFunc()
        return nil
    end
    log:ExitFunc()
    return flag
end

function permissions.Combine(...)
    if not requireEnabled() then
        return 0
    end
    log:EnterFunc("Combine")

    local result = 0
    for i, flagsValue in ipairs({ ... }) do
        if type(flagsValue) ~= "number" then
            logWarn(("Combine argument #%d is not a number (got %s)"):format(i, typeof(flagsValue)))
            err.throw(0x0002)
            flagsValue = 0
        end
        result = bit32.bor(result, flagsValue)
    end
    log:ExitFunc()
    return result
end

permissions.LoadedFlags = loadedFlags

return permissions
