---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type AnyWeAbility
local AnyWeAbility = require('compiletime.objEdit.objects.ability.anyWeAbility')

---@class RunedBracersWeAbility : AnyWeAbility
local RunedBracers = {}
setmetatable(RunedBracers, {__index = AnyWeAbility})

---@param id string
---@return RunedBracersWeAbility
function RunedBracers.new(id)
    local we_ability = AnyWeAbility.new(id, 'AIsr')
    setmetatable(we_ability, {__index = RunedBracers})
    return we_ability
end

---@param data number
---@param lvl integer
function RunedBracers:setDamageBonus(data, lvl) self:addField(WeField.new("isr1", 'unrealm', lvl, 1, data)) end
---@param data number
---@param lvl integer
function RunedBracers:setDamageReduction(data, lvl) self:addField(WeField.new("isr2", 'unreal', lvl, 2, data)) end

return RunedBracers
