local log = require(script.log)
local Framework = {}

function Framework.runTests()
    local Logger = log.Logger.New("Framework::runTests")

    Logger:Info("hey")
    Logger:Debug("hey")
    Logger:Warn("hey")
    Logger:Error("hey")
end

return Framework