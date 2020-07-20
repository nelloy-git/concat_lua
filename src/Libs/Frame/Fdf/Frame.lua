--=========
-- Include
--=========

local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger
---@type FdfFileClass
local FdfFile = require(lib_modname..'.Fdf.File')

--=======
-- Class
--=======

local FdfFrame = Class.new('FdfFrame')
---@class FdfFrame
local public = FdfFrame.public
---@class FdfFrameClass
local static = FdfFrame.static
---@type FdfFrameClass
local override = FdfFrame.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param base_type string
---@param fdf_file FdfFile | nil
---@param child_instance FdfFrame | nil
---@return FdfFrame
function override.new(name, base_type, fdf_file, child_instance)
    checkTypeErr(name, 'string', 'name')
    checkTypeErr(base_type, 'string', 'base_type')
    if fdf_file then checkTypeErr(fdf_file, FdfFile, 'fdf_file') end
    if child_instance then checkTypeErr(child_instance, FdfFrame, 'child_instance') end

    if private.name[name] then
        Log:err('Frame with the same name already exists.', 2)
    end

    local instance = child_instance or Class.allocate(FdfFrame)
    private.newData(instance, name, base_type, fdf_file)

    return instance
end

--========
-- Public
--========

---@return string
function public:getName()
    return private.data[self].name
end

---@return string
function public:getBaseType()
    return private.data[self].base_type
end

---@param base_type string
function public:setBaseType(base_type)
    private.data[self].base_type = base_type
end

---@param fdf_frame FdfFrame | nil
function public:setInheritance(fdf_frame)
    if fdf_frame then checkTypeErr(fdf_frame, FdfFrame, 'fdf_frame') end
    if fdf_frame and self:getBaseType() ~= fdf_frame:getBaseType() then
        Log:err('Can not inherit from different base type.', 2)
    end
    private.data[self].inheritance = fdf_frame
end

---@return FdfFile | nil
function public:getInheritance()
    return private.data[self].inheritance
end

---@return table
function public:getAllParameters()
    local priv = private.data[self]

    local copy = {}
    for param, val in pairs(priv.params) do
        copy[param] = val
    end

    return copy
end

---@param parameter string
---@param value string | nil
function public:setParameter(parameter, value)
    checkTypeErr(parameter, 'string', parameter)
    if value then checkTypeErr(value, 'string', value) end

    local priv = private.data[self]
    if value == nil then value = private.empty_param_value end
    priv.params[parameter] = value
end

---@return string
function public:getParameter(parameter)
    return private.data[self].params[parameter]
end

---@param parameter string
function public:removeParameter(parameter)
    checkTypeErr(parameter, 'string', parameter)
    private.data[self].params[parameter] = nil
end

---@param subframe FdfFrame
function public:addSubframe(subframe)
    local priv = private.data[self]
    priv.subframes[subframe:getName()] = subframe
    private.data[self].fdf_file:remove(subframe)
end

---@param name string
---@return FdfFrame | nil
function public:getSubframe(name)
    local priv = private.data[self]
    return priv.subframes[name]
end

---@param name string
---@return FdfFrame | nil
function public:removeSubframe(name)
    local priv = private.data[self]
    local subframe = priv.subframes[name]
    priv.subframes[name] = nil
    if subframe then
        private.data[self].fdf_file:add(subframe)
    end
    return subframe
end

---@return table
function public:getAllSubframes()
    local priv = private.data[self]
    local copy = {}
    for name, subframe in pairs(priv.subframes) do
        copy[name] = subframe
    end

    return copy
end

--- Do nothing in runtime.
---@return string
function public:serialize()
    local priv = private.data[self]

    local res = string.format('Frame \"%s\" \"%s\"', priv.base_type, priv.name)
    if priv.inheritance then res = res..' INHERITS '..priv.inheritance:getName() end
    res = res..' {\n'
    for param, value in pairs(priv.params) do
        res = res..'    '..param
        if value ~= private.empty_param_value then res = res..' '..value end
        res = res..',\n'
    end
    for _, subframe in pairs(priv.subframes) do
        res = res..'\n    '..subframe:serialize():gsub('\n', '\n    ')..'\n'
    end
    return res.."}"
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.name = setmetatable({}, {__mode = 'k'})

private.empty_param_value = 'NULL'

---@param self FdfFrame
---@return FdfFramePrivate
function private.newData(self, name, base_type, fdf_file)
    ---@class FdfFramePrivate
    local priv = {
        base_type = base_type,
        name = name,
        inheritance = nil,
        params = {},
        subframes = {},

        fdf_file = fdf_file or FdfFile.getDefault()
    }
    private.data[self] = priv
    private.name[name] = self

    priv.fdf_file:add(self)
end

return static