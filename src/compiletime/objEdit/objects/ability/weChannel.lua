---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type AnyWeAbility
local AnyWeAbility = require('compiletime.objEdit.objects.ability.anyWeAbility')

---@class ChannelWeAbility : AnyWeAbility
local WeChannelAbility = {}
setmetatable(WeChannelAbility, {__index = AnyWeAbility})

---@param id string
---@return ChannelWeAbility
function WeChannelAbility.new(id)
    local we_ability = AnyWeAbility.new(id, 'ANcl')
    setmetatable(we_ability, {__index = WeChannelAbility})
    return we_ability
end

---@param data number
---@param lvl integer
function WeChannelAbility:setArtDuration(data, lvl) self:addField(WeField.new("Ncl4", 'unreal', lvl, 4, data)) end
---@param data string
---@param lvl integer
function WeChannelAbility:setBaseOrderID(data, lvl) self:addField(WeField.new("Ncl6", 'string', lvl, 6, data)) end
---@param data integer
---@param lvl integer
function WeChannelAbility:setDisableOtherAbilities(data, lvl) self:addField(WeField.new("Ncl5", 'int', lvl, 5, data)) end
---@param data number
---@param lvl integer
function WeChannelAbility:setFollowThroughTime(data, lvl) self:addField(WeField.new("Ncl1", 'unreal', lvl, 1, data)) end
---@param data integer
---@param lvl integer
function WeChannelAbility:setTargetType(data, lvl) self:addField(WeField.new("Ncl2", 'int', lvl, 2, data)) end
---@param data integer
---@param lvl integer
function WeChannelAbility:setOptions(data, lvl) self:addField(WeField.new("Ncl3", 'int', lvl, 3, data)) end

return WeChannelAbility