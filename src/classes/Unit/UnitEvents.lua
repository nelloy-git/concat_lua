local Unit = require('classes.Unit')
local Trigger = require('utils.trigger.Trigger')

local event_list = {}

---@param event_name UnitEventName
function Unit.getEvent(event_name)
    local event = event_list[event_name]
    if not event then
        event = 
    return UnitEvent.__triggers[event_name]
end

---@alias UnitEventName string
---| '"Unit_Attacked"'
---| '"Unit_Rescued"'
---| '"Unit_Death"'
---| '"Unit_Decay"'
---| '"Unit_Detected"'
---| '"Unit_Hidden"'
---| '"Unit_Selected"'
---| '"Unit_Deselected"'
---| '"Unit_Construct_Start"'
---| '"Unit_Construct_Cancel"'
---| '"Unit_Construct_Finish"'
---| '"Unit_Upgrade_Start"'
---| '"Unit_Upgrade_Cancel"'
---| '"Unit_Upgrade_Finish"'
---| '"Unit_Train_Start"'
---| '"Unit_Train_Cancel"'
---| '"Unit_Train_Finish"'
---| '"Unit_Research_Start"'
---| '"Unit_Research_Cancel"'
---| '"Unit_Research_Finish"'
---| '"Unit_Issued_Order"'
---| '"Unit_Issued_Point_Oeder"'
---| '"Unit_Issued_Target_Order"'
---| '"Unit_Issued_Unit_Order"'
---| '"Hero_Level"'
---| '"Hero_Skill"'
---| '"Hero_Revivable"'
---| '"Hero_Revive_Start"'
---| '"Hero_Revive_Cancel"'
---| '"Hero_Revive_Finish"'
---| '"Unit_Summon"'
---| '"Unit_Drop_Item"'
---| '"Unit_PickUp_Item"'
---| '"Unit_Use_Item"'
---| '"Unit_Loaded"'
---| '"Unit_Damaged"'
---| '"Unit_Damaging"'
---| '"Unit_Sell"'
---| '"Unit_Change_Owner"'
---| '"Unit_Sell_Item"'
---| '"Unit_Spell_Channel"'
---| '"Unit_Spell_Cast"'
---| '"Unit_Spell_Effect"'
---| '"Unit_Spell_Finish"'
---| '"Unit_Spell_EndCast"'
---| '"Unit_Pawn_Item"'

--Unused solo unit events
---| '"StateLimit"'
---| '"AcquiredTarget"'
---| '"TargetInRange"'

return UnitEvent