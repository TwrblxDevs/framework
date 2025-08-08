--[[
    "Super" class of all components!

    very special
--]]

local component = {
    name = "",

    __already_init = false,
}
component.__index = component

function component:say_hi()
    print("[superclass] hi!")
end



return component