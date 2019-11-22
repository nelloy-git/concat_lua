---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type AnyWeAbility
local AnyWeAbility = require('compiletime.objEdit.objects.ability.anyWeAbility')

---@class AuraSlowWeAbility : AnyWeAbility
local WeAuraSlow = {}
setmetatable(WeAuraSlow, {__index = AnyWeAbility})

---@param id string
---@return AuraSlowWeAbility
function WeAuraSlow.new(id)
    local we_ability = AnyWeAbility.new(id, 'Aasl')
    setmetatable(we_ability, {__index = WeAuraSlow})
    return we_ability
end

---@param data number
---@param lvl string
function WeAuraSlow:setMovementSpeedFactor(data, lvl) self:addField(WeField.new("Slo1", 'unreal', lvl, 1, data)) end
---@param data boolean
---@param lvl integer
function WeAuraSlow:setAlwaysAutocast(data, lvl) self:addField(WeField.new("Slo3", 'bool', lvl, 3, data)) end
---@param data number
---@param lvl string
function WeAuraSlow:setAttackSpeedFactor(data, lvl) self:addField(WeField.new("Slo2", 'unreal', lvl, 2, data)) end

return WeAuraSlow
