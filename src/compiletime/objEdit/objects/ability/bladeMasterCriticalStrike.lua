---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type AnyWeAbility
local AnyWeAbility = require('compiletime.objEdit.objects.ability.every')

---@class BladeMasterCriticalStrikeWeAbility : AnyWeAbility
local BladeMasterCriticalStrike = {}
setmetatable(BladeMasterCriticalStrike, {__index = AnyWeAbility})

---@param id string
---@return BladeMasterCriticalStrikeWeAbility
function BladeMasterCriticalStrike.new(id)
    local we_ability = AnyWeAbility.new(id, 'AOcr')
    setmetatable(we_ability, {__index = BladeMasterCriticalStrike})
    return we_ability
end

---@param data number
---@param lvl integer
function BladeMasterCriticalStrike:setDamageMultiplier(data, lvl) self:addField(WeField.new("Ocr2", 'unreal', lvl, 2, data)) end
---@param data number
---@param lvl integer
function BladeMasterCriticalStrike:setChancetoCriticalStrike(data, lvl) self:addField(WeField.new("Ocr1", 'unreal', lvl, 1, data)) end
---@param data number
---@param lvl integer
function BladeMasterCriticalStrike:setDamageBonus(data, lvl) self:addField(WeField.new("Ocr3", 'unreal', lvl, 3, data)) end
---@param data number
---@param lvl integer
function BladeMasterCriticalStrike:setChancetoEvade(data, lvl) self:addField(WeField.new("Ocr4", 'unreal', lvl, 4, data)) end
---@param data number
---@param lvl integer
function BladeMasterCriticalStrike:setNeverMiss(data, lvl) self:addField(WeField.new("Ocr5", 'bool', lvl, 5, data)) end

return BladeMasterCriticalStrike