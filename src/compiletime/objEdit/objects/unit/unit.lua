local WeUnit = {}

local WeField = require('compiletime.objEdit.we_field')
local WeObject = require('compiletime.objEdit.objects.we_object')
local WeEveryUnit = require('compiletime.objEdit.objects.unit.every')
setmetatable(WeUnit, {__index = WeEveryUnit})

function WeUnit.new(id, base_id)
    local we_unit = WeObject.new(id, base_id, 'unit')
    setmetatable(we_unit, {__index = WeUnit})
    return we_unit
end

function WeUnit:setTransportedSize(int_data)
    self:addField(WeField.new("ucar", 'int', nil, nil, int_data))
end

function WeUnit:setLevel(int_data)
    self:addField(WeField.new("ulev", 'int', nil, nil, int_data))
end

function WeUnit:setGroupSeparationPriority(int_data)
    self:addField(WeField.new("urpr", 'int', nil, nil, int_data))
end

function WeUnit:setGroupSeparationParameter(int_data)
    self:addField(WeField.new("urpp", 'int', nil, nil, int_data))
end

function WeUnit:setGroupSeparationGroupNumber(int_data)
    self:addField(WeField.new("urpg", 'int', nil, nil, int_data))
end

function WeUnit:setGroupSeparationEnabled(bool_data)
    self:addField(WeField.new("urpo", 'bool', nil, nil, bool_data))
end

function WeUnit:setFormationRank(int_data)
    self:addField(WeField.new("ufor", 'int', nil, nil, int_data))
end

function WeUnit:setStructuresBuilt(string_data)
    self:addField(WeField.new("ubui", 'string', nil, nil, string_data))
end

function WeUnit:setCasterUpgradeTips(string_data)
    self:addField(WeField.new("ucut", 'string', nil, nil, string_data))
end

function WeUnit:setCasterUpgradeNames(string_data)
    self:addField(WeField.new("ucun", 'string', nil, nil, string_data))
end

function WeUnit:setCasterUpgradeArt(string_data)
    self:addField(WeField.new("ucua", 'string', nil, nil, string_data))
end

return WeUnit