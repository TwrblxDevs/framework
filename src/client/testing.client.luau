local Logger = require(game.ReplicatedStorage.rift_framework.framework.log).Logger.New(script.Name)

Logger
    :Info("hi! :)")
    :Debug("debug message here")
    :Warn("don't do that!")
    :Error("oh noes!")