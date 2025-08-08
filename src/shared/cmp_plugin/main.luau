local super = require(game.ReplicatedStorage.Shared["@special"].component)

local plugin = {
    data = {
        ['exposed_functions'] = {},
    }
}
plugin.__index = plugin
setmetatable(plugin, super)

function plugin.expose_function(name: string,fn)
    local exposed = {
        name = name,
        func = fn
    }

    table.insert(plugin.data.exposed_functions,exposed)
end

function plugin.get_function()

end

return plugin