local log = require(script.log)
local g_logger = log.Logger.New("Framework")
local Framework = {}

function Framework.runTests()
    local logger = log.Logger.New("Framework::runTests")

    logger
        :Info("uwu")
end

return Framework