local http = require(script.http)
local log = require(script.log)
local Framework = {}

function Framework.runTests()
    local Logger = log.Logger.New("Framework::runTests")

    Logger:Info("hey")
    Logger:Debug("hey")
    Logger:Warn("hey")
    Logger:Error("hey")

    http.Get("https://api.emgkwc.com/v1/r2/findAvatar")
end

return Framework