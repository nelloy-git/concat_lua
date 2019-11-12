--=========
-- Include
--=========

---@type DataBaseClass
local DataBase = require('DataBase')
---@type ParameterTypeClass
local ParameterType = require('ParameterType')

--=======
-- Class
--=======

---@type UnitParameterTypeClass
local UnitParameterType = newClass('UnitParameterType')

---@class UnitParameterType
local public = UnitParameterType.public
---@class UnitParameterTypeClass
local static = UnitParameterType.static
---@type table
local override = UnitParameterType.override
---@type table(UnitParameterType, table)
local private = {}

local db = DataBase.new(getClassName(ParameterType), getClassName(UnitParameterType))

--=========
-- Methods
--=========

---@param parameter_type ParameterType
---@param math_func fun(base:number, mult:number, additive:number):number
---@param apply_func fun(base:number, mult:number, additive:number):number
---@param instance_data table | nil
function static.new(parameter_type, math_func, apply_func, instance_data)
    local instance = instance_data or newInstanceData(UnitParameterType)
    local priv = {
        math = math_func,
        apply = apply_func
    }
    private[instance] = priv

    if not db.get(parameter_type) then
        db.set(parameter_type, instance)
    else
        Debug(string.format('%s warning: %s already has math and apply functions.', getClassName(UnitParameterType), parameter_type))
    end
end

function static.get(parameter_type)
    return db.get(parameter_type)
end

local initialized = false
function static.init()
    if initialized then
        return nil
    end
    initialized = true

    ParameterType.init()

    static.PDMG = static.new(ParameterType.PDMG, nil, nil)
    static.ATKS_PER_SEC = static.new(ParameterType.ATKS_PER_SEC, nil, nil)
    static.ARMOR = static.new(ParameterType.ARMOR, nil, nil)
    static.PDMG_REDUC = static.new(ParameterType.PDMG_REDUC, nil, nil)
    static.MDMG = static.new(ParameterType.MDMG, nil, nil)
    static.CAST_TIME_REDUC = static.new(ParameterType.CAST_TIME_REDUC, nil, nil)
    static.RESIST = static.new(ParameterType.RESIST, nil, nil)
    static.MDMG_REDUC = static.new(ParameterType.MDMG_REDUC, nil, nil)
    static.DODGE = static.new(ParameterType.DODGE, nil, nil)
    static.CRIT_CH = static.new(ParameterType.CRIT_CH, nil, nil)
    static.CRIT_DMG = static.new(ParameterType.CRIT_DMG, nil, nil)
    static.CD_REDUC = static.new(ParameterType.CD_REDUC, nil, nil)
    static.HP = static.new(ParameterType.HP, nil, nil)
    static.REGEN = static.new(ParameterType.REGEN, nil, nil)
    static.MP = static.new(ParameterType.MP, nil, nil)
    static.RECOV = static.new(ParameterType.RECOV, nil, nil)
    static.STR = static.new(ParameterType.STR, nil, nil)
    static.AGI = static.new(ParameterType.AGI, nil, nil)
    static.INT = static.new(ParameterType.INT, nil, nil)
    static.MS = static.new(ParameterType.MS, nil, nil)
end

return UnitParameterType