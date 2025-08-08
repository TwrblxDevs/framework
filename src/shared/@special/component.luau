--[[
    "Super" class of all components!

    very special
--]]

local component_meta = {}

local component = {
    name = "",

    __already_init = false,

    ['get_name'] = function(self): string
        return self.name
    end,
}

function component_meta.get_meta(name: string): {}
    local self = component

    self.name = name


    self.__already_init = true

    return self
end



return component_meta