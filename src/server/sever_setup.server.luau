local ReplicatedStorage = game:GetService("ReplicatedStorage")
local framework = require(ReplicatedStorage.rift_framework.framework)
local log = require(ReplicatedStorage.rift_framework.framework.log)
require(game.ReplicatedStorage.rift_framework.framework)

framework.runTests()