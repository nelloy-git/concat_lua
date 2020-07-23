---@type AbilityLib
local AbilityLib = require(LibList.AbilityLib)
---@type BinaryLib
local BinaryLib = require(LibList.BinaryLib)
---@type BuffLib
local BuffLib = require(LibList.BuffLib)
---@type ParameterLib
local ParameterLib = require(LibList.ParameterLib)
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)

local FullUnit = {}

local unit_base_id = FourCC('hfoo')
---@param name string
---@param icon string
---@param model string
---@return number
function FullUnit.newType(name, icon, model)
    local unit_id = FourCC(BinaryLib.getUnitId())

    local unit_t = BinaryLib.Unit.new(unit_id, unit_base_id, name)
    unit_t:setName(name)
    unit_t:setModelFile(model)
    unit_t:setIconGameInterface(icon)
    unit_t:setNormalAbilities({})

    return unit_id
end

---@param id number
---@param x number
---@param y number
---@param owner player
function FullUnit.newUnit(id, x, y, owner)
    local u = UtilsLib.Handle.Unit.new(id, x, y, owner)

    local params = ParameterLib.Container.new(u)
    params:addBase(ParameterLib.PhysicalDamage, 5)
    params:addBase(ParameterLib.Defence, 0)
    params:addBase(ParameterLib.Health, 1000)

    local abils = AbilityLib.Container.new(u)
    local buffs = BuffLib.Container.new(u)

    return u
end

return FullUnit