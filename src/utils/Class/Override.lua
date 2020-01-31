local ClassStatic = require('utils.Class.Static')

local ClassOverride = {}

local rawget = rawget
local rawset = rawset
local fmt = string.format

local override2class = {}
setmetatable(override2class, {__mode = 'kv'})
local override2static = {}
setmetatable(override2static, {__mode = 'kv'})

local override_meta = {
    __index = function(self, key)
        rawget(override2static[self], key)
    end,

    __newindex = function(self, key, value)
        rawset(override2static[self], key, value)
    end,

    __tostring = function(self)
        return tostring(override2class[self])
    end
}

function ClassOverride.register(class)
    local override = {}
    setmetatable(override, override_meta)

    override2class[override] = class
    override2static[override] = ClassStatic.getStatic(class)
    return override
end

return ClassOverride