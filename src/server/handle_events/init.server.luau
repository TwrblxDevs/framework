local ReplicatedStorage = game:GetService("ReplicatedStorage")
local g_globals = require(ReplicatedStorage.rift_framework.globals)

function on_panic(msg: string)
    warn(`[panic] {msg}`)
end

g_globals.Events.panic_event.bind.Event:Connect(on_panic)
g_globals.Events.panic_event.remote.OnServerEvent:Connect(on_panic)