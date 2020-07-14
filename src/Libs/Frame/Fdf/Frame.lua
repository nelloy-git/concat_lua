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

---@return string
function public:getParameter(parameter)
    return private.data[self].params[parameter]
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

--- Do nothing in runtime.
---@param parameter string
---@param value string
function public:setParameter(parameter, value)
    checkTypeErr(parameter, 'string', parameter)
    checkTypeErr(value, 'string', value)

    local priv = private.data[self]
    priv.params[parameter] = value
end

--- Do nothing in runtime.
---@param subframe FdfFrame
function public:addSubframe(subframe)
    local priv = private.data[self]
    priv.subframes[subframe:getName()] = subframe
    private.data[self].fdf_file:remove(subframe)
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
        res = res..'    '..param..' '..value..',\n'
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