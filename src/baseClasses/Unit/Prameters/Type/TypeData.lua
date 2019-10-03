---@class UnitParameterType
local UnitParameterType = newClass("UnitParameterType")
local UnitParameterType_meta = newMeta(UnitParameterType)

function UnitParameterType.init()
    --UnitParameterType.ATTACK_DAMAGE = UnitParameterType.new()
    --UnitParameterType.ATTACK_COOLDOWN = UnitParameterType.new()
    --UnitParameterType.ARMOR = UnitParameterType.new()
    --UnitParameterType.PHYSICAL_DAMAGE_REDUCTION = UnitParameterType.new()
    --UnitParameterType.SPELL_DAMAGE = UnitParameterType.new()
    --UnitParameterType.CASTING_TIME_REDUCTION = UnitParameterType.new()
    --UnitParameterType.RESISTANCE = UnitParameterType.new()
    --UnitParameterType.MAGICAL_DAMAGE_REDUCTION = UnitParameterType.new()
    --UnitParameterType.DODGE_CHANCE = UnitParameterType.new()
    --UnitParameterType.CRIT_CHANCE = UnitParameterType.new()
    --UnitParameterType.CRIT_DAMAGE = UnitParameterType.new()
    --UnitParameterType.COOLDOWN_REDUCTION = UnitParameterType.new()
    --UnitParameterType.HEALTH = UnitParameterType.new()
    --UnitParameterType.REGENERATION = UnitParameterType.new()
    --UnitParameterType.MANA = UnitParameterType.new()
    --UnitParameterType.RECOVERY = UnitParameterType.new()
    --UnitParameterType.STRENGTH = UnitParameterType.new()
    --UnitParameterType.AGILITY = UnitParameterType.new()
    --UnitParameterType.INTELLIGENCE = UnitParameterType.new()
    --UnitParameterType.MOVE_SPEED = UnitParameterType.new()
end

--- Creates new unit parameter. apply_func:function(unit:unit, value:number)
---@param name string
---@param short_name string
---@param description string
---@param icon string
---@param apply_func fun
---@return UnitParameterType
function UnitParameterType.new(name, short_name, description, icon, apply_func)
    local param_type = {}
    setmetatable(param_type, UnitParameterType_meta)

    return param_type
end

return UnitParameterType