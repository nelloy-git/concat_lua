--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkType = UtilsLib.Functions.checkType

---@type BinaryFileClass
local BinaryFile = require(lib_modname..'.File')
---@type BinaryDataClass
local BinaryData = require(lib_modname..'.Data')
local BinaryDataPublic = Class.getPublic(BinaryData)
--endregion

--=======
-- Class
--=======

local BinaryDataUnit = Class.new('BinaryDataUnit', BinaryData)
--region Class
---@class BinaryDataUnit : BinaryData
local public = BinaryDataUnit.public
---@class BinaryDataUnitClass : BinaryDataClass
local static = BinaryDataUnit.static
---@type BinaryDataUnitClass
local override = BinaryDataUnit.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param id number
---@param base_id number
---@param name string | nil
---@param child_instance BinaryDataUnit | nil
---@return BinaryDataUnit
function override.new(id, base_id, name, child_instance)
    checkType(id, 'number', 'id')
    checkType(base_id, 'number', 'base_id')
    if name then checkType(name, 'string', 'name') end
    if child_instance then checkType(child_instance, BinaryDataUnit, 'child_instance') end

    local instance = child_instance or Class.allocate(BinaryDataUnit)
    instance = BinaryData.new(id, base_id, name, instance)

    private.file:add(instance)

    return instance
end

--========
-- Public
--========

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
local sep = Compiletime(package.config:sub(1,1))
private.file = BinaryFile.new((GetDstDir and GetDstDir() or '')..sep..'war3map.w3u')
CompileFinal(function() private.file:save() end)

return static