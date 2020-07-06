--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType
local Log = UtilsLib.DefaultLogger
---@type FdfFileClass
local FdfFile = require(lib_modname..'.FdfEdit.File')

--=======
-- Class
--=======

local FdfString = Class.new('FdfString')
---@class FdfString
local public = FdfString.public
---@class FdfStringClass
local static = FdfString.static
---@type FdfStringClass
local override = FdfString.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param child_instance FdfString | nil
---@return FdfString
function override.new(name, child_instance)
    checkType(name, 'string', 'name')
    if child_instance then checkType(child_instance, FdfString, 'child_instance') end

    local instance = child_instance or Class.allocate(FdfString)
    private.newData(instance, name)

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private.data[self].name
end

---@param parameter string
---@param value string
function public:setParameter(parameter, value)
    checkType(parameter, 'string', parameter)
    checkType(value, 'string', value)

    local priv = private.data[self]
    priv.params[parameter] = value
end

---@return string
function public:getParameter(parameter)
    return private.data[self].params[parameter]
end

---@return string
function public:serialize()
    local priv = private.data[self]

    local res = string.format("String \"%s\" {\n", priv.name)
    for param, value in pairs(priv.params) do
        res = res..'    '..param..' '..value..',\n'
    end
    return res.."}"
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self FdfString
---@return FdfStringPrivate
function private.newData(self, name)
    ---@class FdfStringPrivate
    local priv = {
        name = name,
        params = {},
    }
    private.data[self] = priv
end

return static