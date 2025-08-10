local g_globals = require(script.globals)
local g_commit_main = g_globals.Const.Github.Branches.main.LatestCommit
local g_commit_devel = g_globals.Const.Github.Branches.development.LatestCommit
local log = require(script.log)
local Framework = {}

function Framework.runTests()
    local logger = log.Logger.New("Framework::runTests")

    logger
        :Info("Globals.Const.Github.Branches.main.LatestCommit [")
        :Info("     author="..g_commit_main.sz_author)
        :Info("     message=\""..g_commit_main.sz_message.."\"")
        :Info("     date="..g_commit_main.sz_commit_date)
        :Info("     sha="..g_commit_main.sz_sha)
        :Info("]")

    logger
        :Info("Globals.Const.Github.Branches.development.LatestCommit [")
        :Info("     author="..g_commit_devel.sz_author)
        :Info("     message=\""..g_commit_devel.sz_message.."\"")
        :Info("     date="..g_commit_devel.sz_commit_date)
        :Info("     sha="..g_commit_devel.sz_sha)
        :Info("]")
end

return Framework