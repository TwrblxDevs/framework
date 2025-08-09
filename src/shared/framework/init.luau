local g_globals = require(script.globals)
local g_commit = g_globals.Const.Github.LastCommit
local log = require(script.log)
local Framework = {}

function Framework.runTests()
    local logger = log.Logger.New("Framework::runTests")

    logger:Info("latest commit")
    logger
        :Info("     author="..g_commit.sz_author)
        :Info("     message=\""..g_commit.sz_message)
        :Info("     date="..g_commit.sz_commit_date)
        :Info("     sha="..g_commit.sz_sha)
end

return Framework