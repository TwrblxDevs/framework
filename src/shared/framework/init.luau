local log = require(script.log)
local Framework = {}

function Framework.runTests()
    local logger = log.Logger.New("Framework::runTests")

    logger
        :Info("E")
end

return Framework