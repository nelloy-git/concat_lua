--========
-- Module
--========

---@class DamageDefines
local Defines = {}

---@alias DamageType damagetype
Defines.DamageType = {}
---@type DamageType
Defines.DamageType.PhysicalAttack = DAMAGE_TYPE_NORMAL or 1
---@type DamageType
Defines.DamageType.MagicalAttack = DAMAGE_TYPE_MAGIC or 2
---@type DamageType
Defines.DamageType.ChaosAttack = DAMAGE_TYPE_DEATH or 3
---@type DamageType
Defines.DamageType.PhysicalSpell = DAMAGE_TYPE_FORCE or 4
---@type DamageType
Defines.DamageType.MagicalSpell = DAMAGE_TYPE_MIND or 5
---@type DamageType
Defines.DamageType.ChaosSpell = DAMAGE_TYPE_UNKNOWN or 6

function Defines.isDamageType(val)
    for _, dmg_type in pairs(Defines.DamageType) do
        if val == dmg_type then
            return true
        end
    end
    return false
end

return Defines