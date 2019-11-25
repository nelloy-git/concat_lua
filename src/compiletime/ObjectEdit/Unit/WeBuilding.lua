--=========
-- Include
--=========

---@type WeFieldClass
local WeField = require('compiletime.ObjectEdit.WeField')
---@type WeUnitClass
local WeUnit = require('compiletime.ObjectEdit.Unit.WeUnit')

--=======
-- Class
--=======

---@type WeBuildingClass
local WeBuilding = newClass('WeBuilding', WeUnit)

---@class WeBuilding : WeUnit
local public = WeBuilding.public
---@class WeBuildingClass : WeUnitClass
local static = WeBuilding.static
---@type WeBuildingClass
local override = WeBuilding.override
---@type table(WeBuilding, table)
local private = {}

--=========
-- Methods
--=========

---@return WeBuilding
function override.new(id, base_id, name, instance_data)
    local instance = instance_data or newInstanceData(WeBuilding)
    instance = WeUnit.new(id, base_id, name, instance)

    return instance
end

static.AgilityPerLevel = WeField.new("uagp", 'real', "AgilityPerLevel")
static.ConstructionSound = WeField.new("ubsl", 'string', "ConstructionSound")
static.ConstructionSound = WeField.new("ubsl", 'string', "ConstructionSound")
static.GroundTexture = WeField.new("uubs", 'string', "GroundTexture")
static.GroundTexture = WeField.new("uubs", 'string', "GroundTexture")
static.HeroAbilities = WeField.new("uhab", 'string', "HeroAbilities")
static.HeroRevivalLocations = WeField.new("urva", 'string', "HeroRevivalLocations")
static.IntelligencePerLevel = WeField.new("uinp", 'real', "IntelligencePerLevel")
static.ItemsMade = WeField.new("umki", 'string', "ItemsMade")
static.ItemsMade = WeField.new("umki", 'string', "ItemsMade")
static.NeutralBuildingShowsMinimapIcon = WeField.new("unbm", 'bool', "NeutralBuildingShowsMinimapIcon")
static.NeutralBuildingShowsMinimapIcon = WeField.new("unbm", 'bool', "NeutralBuildingShowsMinimapIcon")
static.NeutralBuildingValidAsRandomBuilding = WeField.new("unbr", 'bool', "NeutralBuildingValidAsRandomBuilding")
static.NeutralBuildingValidAsRandomBuilding = WeField.new("unbr", 'bool', "NeutralBuildingValidAsRandomBuilding")
static.PathingMap = WeField.new("upat", 'string', "PathingMap")
static.PathingMap = WeField.new("upat", 'string', "PathingMap")
static.PlacementPreventedBy = WeField.new("upar", 'string', "PlacementPreventedBy")
static.PlacementPreventedBy = WeField.new("upar", 'string', "PlacementPreventedBy")
static.PlacementRequires = WeField.new("upap", 'string', "PlacementRequires")
static.PlacementRequires = WeField.new("upap", 'string', "PlacementRequires")
static.PlacementRequiresWaterRadius = WeField.new("upaw", 'real', "PlacementRequiresWaterRadius")
static.PlacementRequiresWaterRadius = WeField.new("upaw", 'real', "PlacementRequiresWaterRadius")
static.PrimaryAttribute = WeField.new("upra", 'string', "PrimaryAttribute")
static.ProperNames = WeField.new("upro", 'string', "ProperNames")
static.ProperNamesUsed = WeField.new("upru", 'int', "ProperNamesUsed")
static.ResearchesAvailable = WeField.new("ures", 'string', "ResearchesAvailable")
static.ResearchesAvailable = WeField.new("ures", 'string', "ResearchesAvailable")
static.RevivesDeadHeros = WeField.new("urev", 'bool', "RevivesDeadHeros")
static.RevivesDeadHeros = WeField.new("urev", 'bool', "RevivesDeadHeros")
static.StartingAgility = WeField.new("uagi", 'int', "StartingAgility")
static.StartingIntelligence = WeField.new("uint", 'int', "StartingIntelligence")
static.StartingStrength = WeField.new("ustr", 'int', "StartingStrength")
static.StrengthPerLevel = WeField.new("ustp", 'real', "StrengthPerLevel")
static.TooltipAwaken = WeField.new("uawt", 'string', "TooltipAwaken")
static.TooltipRevive = WeField.new("utpr", 'string', "TooltipRevive")
static.UnitsTrained = WeField.new("utra", 'string', "UnitsTrained")
static.UnitsTrained = WeField.new("utra", 'string', "UnitsTrained")
static.UpgradesTo = WeField.new("uupt", 'string', "UpgradesTo")
static.UpgradesTo = WeField.new("uupt", 'string', "UpgradesTo")

return WeBuilding