--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr

---@type BinaryFileClass
local BinaryFile = require(lib_modname..'.File')
---@type BinaryDataClass
local BinaryData = require(lib_modname..'.Data')
---@type BinaryDataUnitDB
local UnitDB = require(lib_modname..'.UnitValuesDB')
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

---@param new_id number
---@param base_id number
---@param name string | nil
---@param child_instance BinaryDataUnit | nil
---@return BinaryDataUnit
function override.new(new_id, base_id, name, child_instance)
    checkTypeErr(new_id, 'number', 'new_id')
    checkTypeErr(base_id, 'number', 'base_id')
    if name then checkTypeErr(name, 'string', 'name') end
    if child_instance then checkTypeErr(child_instance, BinaryDataUnit, 'child_instance') end

    local instance = child_instance or Class.allocate(BinaryDataUnit)
    instance = BinaryData.new(new_id, base_id, name, instance)

    private.file:add(instance)

    return instance
end

--========
-- Public
--========

---@param name string
function public:setName(name)
    local db_data = UnitDB.Name
    self:setValue(db_data.value_id, db_data.value_type, name)
end

---@param icon string
function public:setIconGameInterface(icon)
    local db_data = UnitDB.IconGameInterface
    self:setValue(db_data.value_id, db_data.value_type, icon)
end

---@param model string
function public:setModelFile(model)
    local db_data = UnitDB.ModelFile
    self:setValue(db_data.value_id, db_data.value_type, model)
end

---@param id_list table
function public:setNormalAbilities(id_list)
    local abil_list = ''
    for i = 1, #id_list do
        abil_list = abil_list..id_list[i]..','
    end
    if #id_list > 0 then
        abil_list = abil_list:sub(1, abil_list:len() - 1)
    end

    local db_data = UnitDB.NormalAbilities
    self:setValue(db_data.value_id, db_data.value_type, abil_list)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
local sep = Compiletime(package.config:sub(1,1))
private.file = BinaryFile.new((GetDstDir and GetDstDir() or '')..sep..'war3map.w3u')
CompileFinal(function() private.file:save() end)

return static