local Object = {}
Object.__index = Object

export type Object<C> = {

    __class: string,
    __this: Object<C>,
}

function Object.init<X>(class: X,name: string): Object<X>
    local self = setmetatable({
        _class = name,
        __this = class,
    }, Object)

    return self
end

return Object