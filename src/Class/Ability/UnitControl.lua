local UnitControl = {}

local disable_move_buff_id = Compiletime(function()
    ---@type ObjectEdit
    local ObjEdit = require('compiletime.ObjectEdit')
    local Icons = require('compiletime.Icon')
    local WeBuff = ObjEdit.Buff
    local id = ObjEdit:getBuffId()
    local buff_type = WeBuff.new(id, 'Bfae', 'DisableMovement')
    buff_type:setField(WeBuff.Field.TooltipNormal, 'Ability casting')
    buff_type:setField(WeBuff.Field.TooltipNormalExtended, 'Unit can not move while casting an ability.')
    buff_type:setField(WeBuff.Field.IconNormal, Icons.BTNBrilliance)
    return id
end)
local disable_move_id = Compiletime(function()
    ---@type ObjectEdit
    local ObjEdit = require('compiletime.ObjectEdit')
    local WeAbility = ObjEdit.Ability
    local id = ObjEdit:getAbilityId()
    local abil_type = WeAbility.new(id, 'Aasl', 'DisableMovement')
    abil_type:setField(WeAbility.Field.Aasl_MovementSpeedFactor, 1, -100)
    abil_type:setField(WeAbility.Field.TargetsAllowed, 1, "self")
    abil_type:setField(WeAbility.Field.Buffs, 1, disable_move_buff_id)
    return id
end)
local disable_attack_id = ID('Abun')

function UnitControl.enableAttack(unit)
    UnitAddAbility(unit, disable_attack_id)
end

function UnitControl.disableAttack(unit)
    UnitRemoveAbility(unit, disable_attack_id)
end

function UnitControl.enableMove(unit)
    UnitRemoveAbility(unitX, disable_move_id)
    UnitRemoveAbility(unitX, disable_move_buff_id)
end

function UnitControl.disableMove(unit)
    UnitAddAbility(unit, disable_move_id)
end

return UnitControl