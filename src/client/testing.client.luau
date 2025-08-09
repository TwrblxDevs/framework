local ReplicatedStorage = game:GetService("ReplicatedStorage")
local framework = require(ReplicatedStorage.rift_framework.framework)

task.wait(3)
print('***** RUNNING TESTS *****')
framework.runTests()