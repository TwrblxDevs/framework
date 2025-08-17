local g_globals = require(script.globals)
local g_tools = require(script.tools)
local log = require(script.log)
local permissons = require(script.permissions)
local Framework = {}

function Framework.runTests()
    local logger = log.Logger.New("Framework::runTests")

    logger:Info("runTests() called...")
    permissons.Init(g_globals.Const.Permissions.flags)
end

function Framework.test_depercated()
    g_tools.Macros.StudioOnlyBlock(function()
        print("shot not run!")
    end, false)
end

return Framework
