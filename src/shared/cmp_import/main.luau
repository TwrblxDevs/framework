local super = require(game.ReplicatedStorage.Shared["@special"].component)

local import = {}
import.__index = import
setmetatable(import, super)
return import