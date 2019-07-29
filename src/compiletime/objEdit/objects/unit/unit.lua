---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type AnyWeUnit
local AnyWeUnit = require(CurrentLib..'.objects.unit.every')

---@class WeUnit
local WeUnit = {}
setmetatable(WeUnit, {__index = AnyWeUnit})

---@param id string
---@param base_id string
---@return WeUnit
function WeUnit.new(id, base_id)
    local we_unit = AnyWeUnit.new(id, base_id)
    setmetatable(we_unit, {__index = WeUnit})
    return we_unit
end

---@param data integer
function WeUnit:setTransportedSize(data)
    self:addField(WeField.new("ucar", 'int', nil, nil, data))
end

---@param data integer
function WeUnit:setLevel(data)
    self:addField(WeField.new("ulev", 'int', nil, nil, data))
end

---@param data integer
function WeUnit:setGroupSeparationPriority(data)
    self:addField(WeField.new("urpr", 'int', nil, nil, data))
end

---@param data integer
function WeUnit:setGroupSeparationParameter(data)
    self:addField(WeField.new("urpp", 'int', nil, nil, data))
end

---@param data integer
function WeUnit:setGroupSeparationGroupNumber(data)
    self:addField(WeField.new("urpg", 'int', nil, nil, data))
end

---@param data boolean
function WeUnit:setGroupSeparationEnabled(data)
    self:addField(WeField.new("urpo", 'bool', nil, nil, data))
end

---@param data integer
function WeUnit:setFormationRank(data)
    self:addField(WeField.new("ufor", 'int', nil, nil, data))
end

---@param data string
function WeUnit:setStructuresBuilt(data)
    self:addField(WeField.new("ubui", 'string', nil, nil, data))
end

---@param data string
function WeUnit:setCasterUpgradeTips(data)
    self:addField(WeField.new("ucut", 'string', nil, nil, data))
end

---@param data string
function WeUnit:setCasterUpgradeNames(data)
    self:addField(WeField.new("ucun", 'string', nil, nil, data))
end

---@param data string
function WeUnit:setCasterUpgradeArt(data)
    self:addField(WeField.new("ucua", 'string', nil, nil, data))
end

return WeUnit