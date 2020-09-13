--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')
---@type FdfFileClass
local FdfFile = require(lib_path..'Fdf.File') or error('')

--=======
-- Class
--=======

local FdfBase = Class.new('FdfBase')
---@class FdfBase
local public = FdfBase.public
---@class FdfBaseClass
local static = FdfBase.static
---@type FdfBaseClass
local override = FdfBase.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param base_type string
---@param is_simple boolean
---@param child FdfBase | nil
---@return FdfBase
function override.new(name, base_type, is_simple, child)
    isTypeErr(name, 'string', 'name')
    isTypeErr(base_type, 'string', 'base_type')
    isTypeErr(is_simple, 'boolean', 'is_simple')
    if child then isTypeErr(child, FdfBase, 'child') end

    if private.name[name] then
        Log:err('Frame with the same name already exists.', 2)
    end

    local instance = child or Class.allocate(FdfBase)
    private.newData(instance, name, base_type, is_simple)

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

---@return boolean
function public:isSimple()
    return private.data[self].is_simple
end

---@param fdf_frame FdfBase | nil
function public:setInheritance(fdf_frame)
    if fdf_frame then isTypeErr(fdf_frame, FdfBase, 'fdf_frame') end
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
    isTypeErr(parameter, 'string', parameter)
    if value then isTypeErr(value, 'string', value) end

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
    isTypeErr(parameter, 'string', parameter)

    private.data[self].params[parameter] = nil
end

---@param subframe FdfBase
function public:addSubframe(subframe)
    isTypeErr(subframe, FdfBase, 'subframe')
    local priv = private.data[self]

    if priv.is_simple ~= subframe:isSimple() then
        Log:err('Simple and normal frames can not be combined.', 2)
    end

    priv.subframes[subframe:getName()] = subframe
    private.data[self].fdf_file:remove(subframe)
end

---@param name string
---@return FdfBase | nil
function public:getSubframe(name)
    local priv = private.data[self]
    return priv.subframes[name]
end

---@param name string
---@return FdfBase | nil
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
private.file = FdfFile.init('GeneratedFile')

---@param self FdfBase
---@param name string
---@param is_simple boolean
---@return FdfBasePrivate
function private.newData(self, name, base_type, is_simple)
    ---@class FdfBasePrivate
    local priv = {
        is_simple = is_simple,
        base_type = base_type,
        name = name,
        inheritance = nil,
        params = {},
        subframes = {},

        fdf_file = private.file
    }
    private.data[self] = priv
    private.name[name] = self

    priv.fdf_file:add(self)
end

return static