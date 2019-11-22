---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type AnyWeUnit
local AnyWeUnit = require('compiletime.objEdit.objects.unit.anyWeUnit')

---@class WeBuilding : AnyWeUnit
local WeBuilding = {}
setmetatable(WeBuilding, {__index = AnyWeUnit})

---@param id string
---@param base_id string
---@return WeBuilding
function WeBuilding.new(id, base_id)
    local we_unit = AnyWeUnit.new(id, base_id)
    setmetatable(we_unit, {__index = WeBuilding})
    return we_unit
end

---@param data string
function WeBuilding:setUpgradesTo(data) self:addField(WeField.new("uupt", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setUnitsTrained(data) self:addField(WeField.new("utra", 'string', nil, nil, data)) end
---@param data boolean
function WeBuilding:setRevivesDeadHeros(data) self:addField(WeField.new("urev", 'bool', nil, nil, data)) end
---@param data string
function WeBuilding:setResearchesAvailable(data) self:addField(WeField.new("ures", 'string', nil, nil, data)) end
---@param data number
function WeBuilding:setPlacementRequiresWaterRadius(data) self:addField(WeField.new("upaw", 'real', nil, nil, data)) end
---@param data string
function WeBuilding:setPlacementRequires(data) self:addField(WeField.new("upap", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setPlacementPreventedBy(data) self:addField(WeField.new("upar", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setPathingMap(data) self:addField(WeField.new("upat", 'string', nil, nil, data)) end
---@param data boolean
function WeBuilding:setNeutralBuildingValidAsRandomBuilding(data) self:addField(WeField.new("unbr", 'bool', nil, nil, data)) end
---@param data boolean
function WeBuilding:setNeutralBuildingShowsMinimapIcon(data) self:addField(WeField.new("unbm", 'bool', nil, nil, data)) end
---@param data string
function WeBuilding:setItemsMade(data) self:addField(WeField.new("umki", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setGroundTexture(data) self:addField(WeField.new("uubs", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setConstructionSound(data) self:addField(WeField.new("ubsl", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setUpgradesTo(data) self:addField(WeField.new("uupt", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setUnitsTrained(data) self:addField(WeField.new("utra", 'string', nil, nil, data)) end
---@param data boolean
function WeBuilding:setRevivesDeadHeros(data) self:addField(WeField.new("urev", 'bool', nil, nil, data)) end
---@param data string
function WeBuilding:setResearchesAvailable(data) self:addField(WeField.new("ures", 'string', nil, nil, data)) end
---@param data number
function WeBuilding:setPlacementRequiresWaterRadius(data) self:addField(WeField.new("upaw", 'real', nil, nil, data)) end
---@param data string
function WeBuilding:setPlacementRequires(data) self:addField(WeField.new("upap", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setPlacementPreventedBy(data) self:addField(WeField.new("upar", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setPathingMap(data) self:addField(WeField.new("upat", 'string', nil, nil, data)) end
---@param data boolean
function WeBuilding:setNeutralBuildingValidAsRandomBuilding(data) self:addField(WeField.new("unbr", 'bool', nil, nil, data)) end
---@param data boolean
function WeBuilding:setNeutralBuildingShowsMinimapIcon(data) self:addField(WeField.new("unbm", 'bool', nil, nil, data)) end
---@param data string
function WeBuilding:setItemsMade(data) self:addField(WeField.new("umki", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setGroundTexture(data) self:addField(WeField.new("uubs", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setConstructionSound(data) self:addField(WeField.new("ubsl", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setTooltipRevive(data) self:addField(WeField.new("utpr", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setTooltipAwaken(data) self:addField(WeField.new("uawt", 'string', nil, nil, data)) end
---@param data number
function WeBuilding:setStrengthPerLevel(data) self:addField(WeField.new("ustp", 'real', nil, nil, data)) end
---@param data integer
function WeBuilding:setStartingStrength(data) self:addField(WeField.new("ustr", 'int', nil, nil, data)) end
---@param data integer
function WeBuilding:setStartingIntelligence(data) self:addField(WeField.new("uint", 'int', nil, nil, data)) end
---@param data integer
function WeBuilding:setStartingAgility(data) self:addField(WeField.new("uagi", 'int', nil, nil, data)) end
---@param data integer
function WeBuilding:setProperNamesUsed(data) self:addField(WeField.new("upru", 'int', nil, nil, data)) end
---@param data string
function WeBuilding:setProperNames(data) self:addField(WeField.new("upro", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setPrimaryAttribute(data) self:addField(WeField.new("upra", 'string', nil, nil, data)) end
---@param data number
function WeBuilding:setIntelligencePerLevel(data) self:addField(WeField.new("uinp", 'real', nil, nil, data)) end
---@param data string
function WeBuilding:setHeroRevivalLocations(data) self:addField(WeField.new("urva", 'string', nil, nil, data)) end
---@param data string
function WeBuilding:setHeroAbilities(data) self:addField(WeField.new("uhab", 'string', nil, nil, data)) end
---@param data number
function WeBuilding:setAgilityPerLevel(data) self:addField(WeField.new("uagp", 'real', nil, nil, data)) end

return WeBuilding