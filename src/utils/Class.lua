local Class = {}

function Class.new(name)
    local static = {__type = name..'Class'}
    local instance = {__type = name}
    local static_meta = {__index = static}
    local instance_mata = {__index = instance}

    local class = {}


end

function Class:__newindex(key, value)
    
end

return Class