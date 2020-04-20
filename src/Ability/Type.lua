local AbilityTypeAPI = {}

-- Action templates.

---@type fun(self:AbilityType, caster:unit, target:any, abil_lvl:number)
local targetingTemp = function(self, caster, target, abil_lvl) end
---@type fun(self:AbilityType, caster:unit, target:any, abil_lvl:number):boolean
local startTemp = function(self, caster, target, abil_lvl) return true end
---@type fun(self:AbilityType, caster:unit, target:any, abil_lvl:number)
local castingTemp = function(self, caster, target, abil_lvl) end
---@type fun(self:AbilityType, caster:unit, target:any, abil_lvl:number)
local cancelTemp = function(self, caster, target, abil_lvl) end
---@type fun(self:AbilityType, caster:unit, target:any, abil_lvl:number)
local interruptTemp = function(self, caster, target, abil_lvl) end
---@type fun(self:AbilityType, caster:unit, target:any, abil_lvl:number)
local finishTemp = function(self, caster, target, abil_lvl) end

-- Data templates.

---@type fun(self:AbilityType, owner:unit, abil_lvl:number):string
local getNameTemp = function(self, owner, abil_lvl) return 'Noname' end
---@type fun(self:AbilityType, owner:unit, abil_lvl:number):string
local getIconTemp = function(self, owner, abil_lvl) return '' end
---@type fun(self:AbilityType, owner:unit, abil_lvl:number):string
local getDescriptionTemp = function(self, owner, abil_lvl) return 'Empty description' end
---@type fun(self:AbilityType, owner:unit, abil_lvl:number):number
local getCastingTimeTemp = function(self, owner, abil_lvl) return 1 end
---@type fun(self:AbilityType, owner:unit, abil_lvl:number):number
local getMaxChargesTemp = function(self, owner, abil_lvl) return 1 end
---@type fun(self:AbilityType, owner:unit, abil_lvl:number):number
local getCooldownTemp = function(self, owner, abil_lvl) return 1 end
---@type fun(self:AbilityType, owner:unit, abil_lvl:number):number
local getChargesCostTemp = function(self, owner, abil_lvl) return 1 end
---@type fun(self:AbilityType, owner:unit, abil_lvl:number):number
local getManaCostTemp = function(self, owner, abil_lvl) return 1 end
---@type fun(self:AbilityType, owner:unit, abil_lvl:number):number
local getRangeTemp = function(self, owner, abil_lvl) return 1 end


---@return AbilityType
function AbilityTypeAPI.new()
    ---@class AbilityType
    local AbilityType = {
        -- Action callbacks.
        targeting = targetingTemp,
        start = startTemp,
        casting = castingTemp,
        cancel = cancelTemp,
        interrupt = interruptTemp,
        finish = finishTemp,

        -- Data callbacks.
        getName = getNameTemp,
        getIcon = getIconTemp,
        getDescription = getDescriptionTemp,
        getCastingTime = getCastingTimeTemp,
        getMaxCharges = getMaxChargesTemp,
        getCooldown = getCooldownTemp,
        getChargesCost = getChargesCostTemp,
        getManaCost = getManaCostTemp,
        getRange = getRangeTemp,
    }

    return AbilityType
end

return AbilityTypeAPI