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

---@type WeHeroClass
local WeHero = newClass('WeHero', WeUnit)

---@class WeHero : WeUnit
local public = WeHero.public
---@class WeHeroClass : WeUnitClass
local static = WeHero.static
---@type WeHeroClass
local override = WeHero.override
---@type table(WeHero, table)
local private = {}

--=========
-- Methods
--=========

---@return WeHero
function override.new(id, base_id, name, instance_data)
    local instance = instance_data or newInstanceData(WeHero)
    instance = WeUnit.new(id, base_id, name, instance)

    return instance
end

static.AgilityPerLevel = WeField.new("uagp", 'real', "AgilityPerLevel")
static.AgilityPerLevel = WeField.new("uagp", 'real', "AgilityPerLevel")
static.ConstructionSound = WeField.new("ubsl", 'string', "ConstructionSound")
static.FormationRank = WeField.new("ufor", 'int', "FormationRank")
static.GroundTexture = WeField.new("uubs", 'string', "GroundTexture")
static.GroupSeparationEnabled = WeField.new("urpo", 'bool', "GroupSeparationEnabled")
static.GroupSeparationGroupNumber = WeField.new("urpg", 'int', "GroupSeparationGroupNumber")
static.GroupSeparationParameter = WeField.new("urpp", 'int', "GroupSeparationParameter")
static.GroupSeparationPriority = WeField.new("urpr", 'int', "GroupSeparationPriority")
static.HeroAbilities = WeField.new("uhab", 'string', "HeroAbilities")
static.HeroAbilities = WeField.new("uhab", 'string', "HeroAbilities")
static.HeroRevivalLocations = WeField.new("urva", 'string', "HeroRevivalLocations")
static.HeroRevivalLocations = WeField.new("urva", 'string', "HeroRevivalLocations")
static.HideHeroDeathMsg = WeField.new("uhhd", 'bool', "HideHeroDeathMsg")
static.HideHeroInterfaceIcon = WeField.new("uhhb", 'bool', "HideHeroInterfaceIcon")
static.HideHeroMinimapDisplay = WeField.new("uhhm", 'bool', "HideHeroMinimapDisplay")
static.IntelligencePerLevel = WeField.new("uinp", 'real', "IntelligencePerLevel")
static.IntelligencePerLevel = WeField.new("uinp", 'real', "IntelligencePerLevel")
static.ItemsMade = WeField.new("umki", 'string', "ItemsMade")
static.Level = WeField.new("ulev", 'int', "Level")
static.NeutralBuildingShowsMinimapIcon = WeField.new("unbm", 'bool', "NeutralBuildingShowsMinimapIcon")
static.NeutralBuildingValidAsRandomBuilding = WeField.new("unbr", 'bool', "NeutralBuildingValidAsRandomBuilding")
static.PathingMap = WeField.new("upat", 'string', "PathingMap")
static.PlacementPreventedBy = WeField.new("upar", 'string', "PlacementPreventedBy")
static.PlacementRequires = WeField.new("upap", 'string', "PlacementRequires")
static.PlacementRequiresWaterRadius = WeField.new("upaw", 'real', "PlacementRequiresWaterRadius")
static.PrimaryAttribute = WeField.new("upra", 'string', "PrimaryAttribute")
static.PrimaryAttribute = WeField.new("upra", 'string', "PrimaryAttribute")
static.ProperNames = WeField.new("upro", 'string', "ProperNames")
static.ProperNames = WeField.new("upro", 'string', "ProperNames")
static.ProperNamesUsed = WeField.new("upru", 'int', "ProperNamesUsed")
static.ProperNamesUsed = WeField.new("upru", 'int', "ProperNamesUsed")
static.RequierementsForTier1 = WeField.new("urq0", 'string', "RequierementsForTier1")
static.RequierementsForTier2 = WeField.new("urq1", 'string', "RequierementsForTier2")
static.RequierementsForTier3 = WeField.new("urq2", 'string', "RequierementsForTier3")
static.RequierementsForTier4 = WeField.new("urq3", 'string', "RequierementsForTier4")
static.RequierementsForTier5 = WeField.new("urq4", 'string', "RequierementsForTier5")
static.RequierementsForTier6 = WeField.new("urq5", 'string', "RequierementsForTier6")
static.RequierementsForTier7 = WeField.new("urq6", 'string', "RequierementsForTier7")
static.RequierementsForTier8 = WeField.new("urq7", 'string', "RequierementsForTier8")
static.RequierementsForTier9 = WeField.new("urq8", 'string', "RequierementsForTier9")
static.ResearchesAvailable = WeField.new("ures", 'string', "ResearchesAvailable")
static.RevivesDeadHeros = WeField.new("urev", 'bool', "RevivesDeadHeros")
static.StartingAgility = WeField.new("uagi", 'int', "StartingAgility")
static.StartingAgility = WeField.new("uagi", 'int', "StartingAgility")
static.StartingIntelligence = WeField.new("uint", 'int', "StartingIntelligence")
static.StartingIntelligence = WeField.new("uint", 'int', "StartingIntelligence")
static.StartingStrength = WeField.new("ustr", 'int', "StartingStrength")
static.StartingStrength = WeField.new("ustr", 'int', "StartingStrength")
static.StrengthPerLevel = WeField.new("ustp", 'real', "StrengthPerLevel")
static.StrengthPerLevel = WeField.new("ustp", 'real', "StrengthPerLevel")
static.StructuresBuilt = WeField.new("ubui", 'string', "StructuresBuilt")
static.TooltipAwaken = WeField.new("uawt", 'string', "TooltipAwaken")
static.TooltipAwaken = WeField.new("uawt", 'string', "TooltipAwaken")
static.TooltipRevive = WeField.new("utpr", 'string', "TooltipRevive")
static.TooltipRevive = WeField.new("utpr", 'string', "TooltipRevive")
static.TransportedSize = WeField.new("ucar", 'int', "TransportedSize")
static.UnitsTrained = WeField.new("utra", 'string', "UnitsTrained")
static.UpgradesTo = WeField.new("uupt", 'string', "UpgradesTo")

return WeHero