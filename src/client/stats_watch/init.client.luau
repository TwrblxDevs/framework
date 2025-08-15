local ReplicatedStorage = game:GetService("ReplicatedStorage")
local log = require(ReplicatedStorage.rift_framework.log)
local g_types = require(ReplicatedStorage.rift_framework.types)

local logger = log.Logger.New(script.Name)

local config = {
    ["check_interval"] = 0.5,
    ["spike_threshold"] = 50
}
local last_ping: number = nil
local current_ping: number = nil

function send_ping_spike_alert(new: number)
    logger:EnterFunc("send_alert")

    local diff = current_ping - last_ping
    logger:Info(`Ping spike! old={last_ping} ms, new={new} ms, diff={diff} ms`)

    logger:ExitFunc()
end

while true do
    task.wait(config.check_interval)
    if ping
end