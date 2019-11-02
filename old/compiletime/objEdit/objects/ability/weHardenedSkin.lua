---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type AnyWeAbility
local AnyWeAbility = require('compiletime.objEdit.objects.ability.anyWeAbility')

---@class HardenedSkin : AnyWeAbility
local HardenedSkin = {}
setmetatable(HardenedSkin, {__index = AnyWeAbility})

---@param id string
---@return HardenedSkin
function HardenedSkin.new(id)
    local we_ability = AnyWeAbility.new(id, 'Assk')
    setmetatable(we_ability, {__index = HardenedSkin})
    return we_ability
end

---@param data boolean
---@param lvl integer
function HardenedSkin:setIncludeRangedDamage(data, lvl) self:addField(WeField.new("Ssk4", "boolean", lvl, 4, data)) end

---@param data number
---@param lvl integer
function HardenedSkin:setMinimumDamage(data, lvl) self:addField(WeField.new("Ssk2", "unreal", lvl, 2, data)) end

---@param data number
---@param lvl integer
function HardenedSkin:setIgnoredDamage(data, lvl) self:addField(WeField.new("Ssk3", "unreal", lvl, 3, data)) end

---@param data number
---@param lvl integer
function HardenedSkin:setChancetoReduceDamage(data, lvl) self:addField(WeField.new("Ssk1", "unreal", lvl, 1, data)) end

---@param data boolean
---@param lvl integer
function HardenedSkin:setIncludeMeleeDamage(data, lvl) self:addField(WeField.new("Ssk5", "boolean", lvl, 5, data)) end

return HardenedSkin