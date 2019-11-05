local Class = {}

local rawset = rawset
local rawget = rawget

local function newRealClass(name)
    local class = {
        static = {},
        public = {}
    }

    return class
end

local function realClassMeta()
    local meta = {
        __newindex = function(self, key)
            Debug("Class error: can not add field or method directly to class. Use public, protected or private fields.")
            return nil
        end
    }
end

local function getInstance(class)
    local instance = {
    }
end

return Class