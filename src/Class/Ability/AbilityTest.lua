--[[
    Ability for testing AbilityCastingClass
]]--

---@type AbilityTypeClass
local AbilityType = require('Class.Ability.AbilityType')
---@type AbilityCastingClass
local AbilityCasting = require('Class.Ability.AbilityCasting')

local TestAbilityType = compiletime(
    function()
        local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
        WeAbility = WeObjEdit.Ability
        local abil = WeAbility.new(WeObjEdit.getAbilityId(), 'ANcl', 'Test ability')

        abil:setField(WeAbility.TooltipNormal, 1, 'Test Ability')
        abil:setField(WeAbility.CastingTime, 1, 0)
        abil:setField(WeAbility.Cooldown, 1, 2)

        abil:setField(WeAbility.ANcl_TargetType, 1, WeAbility.ANcl_TargetType_Point)
        abil:setField(WeAbility.ANcl_Options, 1, WeAbility.ANcl_Options_Visible)
        abil:setField(WeAbility.ANcl_FollowThroughTime, 1, 0)

        return abil:toRuntime()
    end
)
local TestAbility = AbilityType.new(TestAbilityType.id)

TestAbility:setCastingTime(function()
    return 1
end)

local callbacks = TestAbility.callbacks

callbacks:setStart(function()
    Debug("Casting started")
end)

callbacks:setCasting(function()
    local caster = AbilityCasting.getCaster()
    Debug(string.format("Casting time: %0.2f", AbilityCasting.getCastingTimeLeft(caster)))
end)

callbacks:setFinish(function()
    Debug('Casting finished')
end)

callbacks:setCancel(function()
    Debug('Casting canceled')
end)

return TestAbility