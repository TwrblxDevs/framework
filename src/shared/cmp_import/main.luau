local super = require(game.ReplicatedStorage.Shared["@special"].component)

local import = {
    data = {
        ['loaded_packages'] = {},
        ['package_load_directory'] = game.ReplicatedStorage,
        ['using_default_load_dir'] = true,
    }
}
import.__index = import

function import.set_load_directory(dir: Folder)
    import.data.package_load_directory = dir

    import.data.using_default_load_dir = false
end

function import.get(package: string): {}
    local mod: ModuleScript = import.data.package_load_directory:FindFirstChild(package)

    if mod == nil then 
        return
    end

end

setmetatable(import, super)

return import