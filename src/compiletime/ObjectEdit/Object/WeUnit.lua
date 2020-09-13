--=========
-- Include
--=========


local Class = require(Lib.Class)

---@type WeObjectClass
local WeObject = require('compiletime.ObjectEdit.WeObject')
---@type WeFieldClass
local WeField = require('compiletime.ObjectEdit.WeField')
---@type WeFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeFile')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeUnit = Class.new('WeUnit', WeObject)
---@class WeUnit : WeObject
local public = WeUnit.public
---@class WeUnitClass : WeObjectClass
local static = WeUnit.static
---@type WeUnitClass
local override = WeUnit.override
local private = {}

--========
-- Static
--========

---@param id string | number
---@param base_id string | number
---@param name string
---@param child WeUnit | nil
---@return WeUnit
function override.new(id, base_id, name, child)
    local instance = child or Class.allocate(WeUnit)
    instance = WeObject.new(id, base_id, name, instance)

    if not private.we_file then
        private.we_file = WeObjectFile.new(private.file_dst)
    end
    private.we_file:addObject(instance)

    return instance
end

static.Field = {}
static.Field.AIPlacementRadius = WeField.new("uabr", 'real', "AIPlacementRadius")
static.Field.AIPlacementType = WeField.new("uabt", 'string', "AIPlacementType")
static.Field.AllowCustomTeamColor = WeField.new("utcc", 'bool', "AllowCustomTeamColor")
static.Field.AnimationBlendTimeseconds = WeField.new("uble", 'real', "AnimationBlendTimeseconds")
static.Field.AnimationCastBackswing = WeField.new("ucbs", 'real', "AnimationCastBackswing")
static.Field.AnimationCastPoint = WeField.new("ucpt", 'real', "AnimationCastPoint")
static.Field.AnimationRunSpeed = WeField.new("urun", 'real', "AnimationRunSpeed")
static.Field.AnimationWalkSpeed = WeField.new("uwal", 'real', "AnimationWalkSpeed")
--- 'Ethereal', 'Flesh', 'Wood', 'Stone', 'Metal'
static.Field.ArmorSoundType = WeField.new("uarm", 'string', "ArmorSoundType", function(field, data) return WeField.compareWithList(field, data, private.ArmorSoundsTypes) end)
--- 'normal', 'small', 'medium', 'large', 'fort', 'hero', 'divine', 'none'
static.Field.ArmorType = WeField.new("udty", 'string', "ArmorType", function(field, data) return WeField.compareWithList(field, data, private.checkArmorType) end)
static.Field.ArtSpecial = WeField.new("uspa", 'string', "ArtSpecial")
static.Field.ArtTarget = WeField.new("utaa", 'string', "ArtTarget")
static.Field.Attack1AnimationBackswingPoint = WeField.new("ubs1", 'real', "Attack1AnimationBackswingPoint")
static.Field.Attack1AnimationDamagePoint = WeField.new("udp1", 'real', "Attack1AnimationDamagePoint")
static.Field.Attack1AreaofEffectFullDamage = WeField.new("ua1f", 'int', "Attack1AreaofEffectFullDamage")
static.Field.Attack1AreaofEffectMediumDamage = WeField.new("ua1h", 'int', "Attack1AreaofEffectMediumDamage")
static.Field.Attack1AreaofEffectSmallDamage = WeField.new("ua1q", 'int', "Attack1AreaofEffectSmallDamage")
static.Field.Attack1AreaofEffectTargets = WeField.new("ua1p", 'string', "Attack1AreaofEffectTargets")
--- 'unknown', 'normal', 'pierce', 'siege', 'spells', 'chaos', 'magic', 'hero'
static.Field.Attack1AttackType = WeField.new("ua1t", 'string', "Attack1AttackType", function(field, data) return WeField.compareWithList(field, data, private.AttackType) end)
static.Field.Attack1CooldownTime = WeField.new("ua1c", 'real', "Attack1CooldownTime")
static.Field.Attack1DamageBase = WeField.new("ua1b", 'int', "Attack1DamageBase")
static.Field.Attack1DamageFactorMedium = WeField.new("uhd1", 'real', "Attack1DamageFactorMedium")
static.Field.Attack1DamageFactorSmall = WeField.new("uqd1", 'real', "Attack1DamageFactorSmall")
static.Field.Attack1DamageLossFactor = WeField.new("udl1", 'real', "Attack1DamageLossFactor")
static.Field.Attack1DamageSidesperDie = WeField.new("ua1s", 'int', "Attack1DamageSidesperDie")
static.Field.Attack1DamageSpillDistance = WeField.new("usd1", 'real', "Attack1DamageSpillDistance")
static.Field.Attack1DamageSpillRadius = WeField.new("usr1", 'real', "Attack1DamageSpillRadius")
static.Field.Attack1DamageUpgradeAmount = WeField.new("udu1", 'int', "Attack1DamageUpgradeAmount")
static.Field.Attack1DamagebooleanofDice = WeField.new("ua1d", 'int', "Attack1DamagebooleanofDice")
static.Field.Attack1MaximumbooleanofTargets = WeField.new("utc1", 'int', "Attack1MaximumbooleanofTargets")
static.Field.Attack1ProjectileArc = WeField.new("uma1", 'real', "Attack1ProjectileArc")
static.Field.Attack1ProjectileArt = WeField.new("ua1m", 'string', "Attack1ProjectileArt")
static.Field.Attack1ProjectileHomingEnabled = WeField.new("umh1", 'bool', "Attack1ProjectileHomingEnabled")
static.Field.Attack1ProjectileSpeed = WeField.new("ua1z", 'int', "Attack1ProjectileSpeed")
static.Field.Attack1Range = WeField.new("ua1r", 'int', "Attack1Range")
static.Field.Attack1RangeMotionBuffer = WeField.new("urb1", 'real', "Attack1RangeMotionBuffer")
static.Field.Attack1ShowUI = WeField.new("uwu1", 'bool', "Attack1ShowUI")
--- 'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration', 'enemies', 'friend', 'ground', 'hero',
--- 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient', 'none', 'nonhero', 'nonsapper', 'notself',
--- 'organic', 'player', 'playerunits', 'sapper', 'self', 'structure', 'terrain', 'tree', 'vulnerable', 'wall'
static.Field.Attack1TargetsAllowed = WeField.new("ua1g", 'string', "Attack1TargetsAllowed", function(field, data) return WeField.compareWithList(field, data, private.AttackTargetsAllowed) end)
--- 'Nothing', 'AxeMediumChop', 'MetalHeavyBash', 'MetalHeavyChop',
--- 'MetalHeavySlice', 'MetalLightChop', 'MetalLightSlice', 'MetalMediumBash', 'MetalMediumChop',
--- 'MetalMediumSlice', 'RockHeavyBash', 'WoodHeavyBash', 'WoodLightBash', 'WoodMediumBash'
static.Field.Attack1WeaponSound = WeField.new("ucs1", 'string', "Attack1WeaponSound", function(field, data) return WeField.compareWithList(field, data, private.AttackWeaponSound) end)
--- 'normal', 'instant', 'artillery', 'aline', 'missile', 'msplash', 'mbounce', 'mline'
static.Field.Attack1WeaponType = WeField.new("ua1w", 'string', "Attack1WeaponType", function(field, data) return WeField.compareWithList(field, data, private.AttackWeaponType) end)
static.Field.Attack2AnimationBackswingPoint = WeField.new("ubs2", 'real', "Attack2AnimationBackswingPoint")
static.Field.Attack2AnimationDamagePoint = WeField.new("udp2", 'real', "Attack2AnimationDamagePoint")
static.Field.Attack2AreaofEffectFullDamage = WeField.new("ua2f", 'int', "Attack2AreaofEffectFullDamage")
static.Field.Attack2AreaofEffectMediumDamage = WeField.new("ua2h", 'int', "Attack2AreaofEffectMediumDamage")
static.Field.Attack2AreaofEffectSmallDamage = WeField.new("ua2q", 'int', "Attack2AreaofEffectSmallDamage")
static.Field.Attack2AreaofEffectTargets = WeField.new("ua2p", 'string', "Attack2AreaofEffectTargets")
--- 'unknown', 'normal', 'pierce', 'siege', 'spells', 'chaos', 'magic', 'hero'
static.Field.Attack2AttackType = WeField.new("ua2t", 'string', "Attack2AttackType", function(field, data) return WeField.compareWithList(field, data, private.AttackType) end)
static.Field.Attack2CooldownTime = WeField.new("ua2c", 'real', "Attack2CooldownTime")
static.Field.Attack2DamageBase = WeField.new("ua2b", 'int', "Attack2DamageBase")
static.Field.Attack2DamageFactorMedium = WeField.new("uhd2", 'real', "Attack2DamageFactorMedium")
static.Field.Attack2DamageFactorSmall = WeField.new("uqd2", 'real', "Attack2DamageFactorSmall")
static.Field.Attack2DamageLossFactor = WeField.new("udl2", 'real', "Attack2DamageLossFactor")
static.Field.Attack2DamageSidesperDie = WeField.new("ua2s", 'int', "Attack2DamageSidesperDie")
static.Field.Attack2DamageSpillDistance = WeField.new("usd2", 'real', "Attack2DamageSpillDistance")
static.Field.Attack2DamageSpillRadius = WeField.new("usr2", 'real', "Attack2DamageSpillRadius")
static.Field.Attack2DamageUpgradeAmount = WeField.new("udu2", 'int', "Attack2DamageUpgradeAmount")
static.Field.Attack2DamagebooleanofDice = WeField.new("ua2d", 'int', "Attack2DamagebooleanofDice")
static.Field.Attack2MaximumbooleanofTargets = WeField.new("utc2", 'int', "Attack2MaximumbooleanofTargets")
static.Field.Attack2ProjectileArc = WeField.new("uma2", 'real', "Attack2ProjectileArc")
static.Field.Attack2ProjectileArt = WeField.new("ua2m", 'string', "Attack2ProjectileArt")
static.Field.Attack2ProjectileHomingEnabled = WeField.new("umh2", 'bool', "Attack2ProjectileHomingEnabled")
static.Field.Attack2ProjectileSpeed = WeField.new("ua2z", 'int', "Attack2ProjectileSpeed")
static.Field.Attack2Range = WeField.new("ua2r", 'int', "Attack2Range")
static.Field.Attack2RangeMotionBuffer = WeField.new("urb2", 'real', "Attack2RangeMotionBuffer")
static.Field.Attack2ShowUI = WeField.new("uwu2", 'bool', "Attack2ShowUI")
--- 'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration', 'enemies', 'friend', 'ground', 'hero',
--- 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient', 'none', 'nonhero', 'nonsapper', 'notself',
--- 'organic', 'player', 'playerunits', 'sapper', 'self', 'structure', 'terrain', 'tree', 'vulnerable', 'wall'
static.Field.Attack2TargetsAllowed = WeField.new("ua2g", 'string', "Attack2TargetsAllowed", function(field, data) return WeField.compareWithList(field, data, private.AttackTargetsAllowed) end)
--- 'Nothing', 'AxeMediumChop', 'MetalHeavyBash', 'MetalHeavyChop',
--- 'MetalHeavySlice', 'MetalLightChop', 'MetalLightSlice', 'MetalMediumBash', 'MetalMediumChop',
--- 'MetalMediumSlice', 'RockHeavyBash', 'WoodHeavyBash', 'WoodLightBash', 'WoodMediumBash'
static.Field.Attack2WeaponSound = WeField.new("ucs2", 'string', "Attack2WeaponSound", function(field, data) return WeField.compareWithList(field, data, private.AttackWeaponSound) end)
--- 'unknown', 'normal', 'pierce', 'siege', 'spells', 'chaos', 'magic', 'hero'
static.Field.Attack2WeaponType = WeField.new("ua2w", 'string', "Attack2WeaponType", function(field, data) return WeField.compareWithList(field, data, private.AttackWeaponType) end)
static.Field.AttacksEnabled = WeField.new("uaen", 'int', "AttacksEnabled")
static.Field.BuildTime = WeField.new("ubld", 'int', "BuildTime")
static.Field.ButtonPositionX = WeField.new("ubpx", 'int', "ButtonPositionX")
static.Field.ButtonPositionY = WeField.new("ubpy", 'int', "ButtonPositionY")
static.Field.CanDropItemsOnDeath = WeField.new("udro", 'bool', "CanDropItemsOnDeath")
static.Field.CanFlee = WeField.new("ufle", 'bool', "CanFlee")
static.Field.CategorizationCampaign = WeField.new("ucam", 'bool', "CategorizationCampaign")
static.Field.CategorizationSpecial = WeField.new("uspe", 'bool', "CategorizationSpecial")
static.Field.CollisionSize = WeField.new("ucol", 'real', "CollisionSize")
static.Field.DeathTimeseconds = WeField.new("udtm", 'real', "DeathTimeseconds")
static.Field.DeathType = WeField.new("udea", 'int', "DeathType")
static.Field.DefaultActiveAbility = WeField.new("udaa", 'string', "DefaultActiveAbility")
static.Field.DefenseBase = WeField.new("udef", 'int', "DefenseBase")
static.Field.DefenseUpgradeBonus = WeField.new("udup", 'int', "DefenseUpgradeBonus")
static.Field.DependencyEquivalents = WeField.new("udep", 'string', "DependencyEquivalents")
static.Field.Description = WeField.new("ides", 'string', "Description")
static.Field.DisplayasNeutralHostile = WeField.new("uhos", 'bool', "DisplayasNeutralHostile")
static.Field.ElevationSamplePoints = WeField.new("uept", 'int', "ElevationSamplePoints")
static.Field.ElevationSampleRadius = WeField.new("uerd", 'real', "ElevationSampleRadius")
static.Field.FogOfWarSampleRadius = WeField.new("ufrd", 'real', "FogOfWarSampleRadius")
static.Field.FoodCost = WeField.new("ufoo", 'int', "FoodCost")
static.Field.FoodProduced = WeField.new("ufma", 'int', "FoodProduced")
static.Field.GoldBountyAwardedBase = WeField.new("ubba", 'int', "GoldBountyAwardedBase")
static.Field.GoldBountyAwardedSidesperDie = WeField.new("ubsi", 'int', "GoldBountyAwardedSidesperDie")
static.Field.GoldBountyAwardedbooleanofDice = WeField.new("ubdi", 'int', "GoldBountyAwardedbooleanofDice")
static.Field.GoldCost = WeField.new("ugol", 'int', "GoldCost")
static.Field.HasTilesetSpecificData = WeField.new("utss", 'bool', "HasTilesetSpecificData")
static.Field.HasWaterShadow = WeField.new("ushr", 'bool', "HasWaterShadow")
static.Field.HideMinimapDisplay = WeField.new("uhom", 'bool', "HideMinimapDisplay")
static.Field.HitPointsMaximumBase = WeField.new("uhpm", 'int', "HitPointsMaximumBase")
static.Field.HitPointsRegenerationRate = WeField.new("uhpr", 'real', "HitPointsRegenerationRate")
static.Field.HitPointsRegenerationType = WeField.new("uhrt", 'string', "HitPointsRegenerationType")
static.Field.Hotkey = WeField.new("uhot", 'string', "Hotkey")
static.Field.IconGameInterface = WeField.new("uico", 'string', "IconGameInterface")
static.Field.IconScoreScreen = WeField.new("ussi", 'string', "IconScoreScreen")
static.Field.IsaBuilding = WeField.new("ubdg", 'bool', "IsaBuilding")
static.Field.ItemsSold = WeField.new("usei", 'string', "ItemsSold")
static.Field.LumberBountyAwardedBase = WeField.new("ulba", 'int', "LumberBountyAwardedBase")
static.Field.LumberBountyAwardedSidesperDie = WeField.new("ulbs", 'int', "LumberBountyAwardedSidesperDie")
static.Field.LumberBountyAwardedbooleanofDice = WeField.new("ulbd", 'int', "LumberBountyAwardedbooleanofDice")
static.Field.LumberCost = WeField.new("ulum", 'int', "LumberCost")
static.Field.ManaInitialAmount = WeField.new("umpi", 'int', "ManaInitialAmount")
static.Field.ManaMaximum = WeField.new("umpm", 'int', "ManaMaximum")
static.Field.ManaRegeneration = WeField.new("umpr", 'real', "ManaRegeneration")
static.Field.MaximumPitchAngledegrees = WeField.new("umxp", 'real', "MaximumPitchAngledegrees")
static.Field.MaximumRollAngledegrees = WeField.new("umxr", 'real', "MaximumRollAngledegrees")
static.Field.MinimumAttackRange = WeField.new("uamn", 'int', "MinimumAttackRange")
static.Field.ModelFile = WeField.new("umdl", 'string', "ModelFile")
static.Field.ModelFileExtraVersions = WeField.new("uver", 'string', "ModelFileExtraVersions")
static.Field.MovementHeight = WeField.new("umvh", 'real', "MovementHeight")
static.Field.MovementHeightMinimum = WeField.new("umvf", 'real', "MovementHeightMinimum")
static.Field.MovementSound = WeField.new("umsl", 'string', "MovementSound")
--- 'horse', 'fly', 'hover', 'float', 'amph'
static.Field.MovementType = WeField.new("umvt", 'string', "MovementType", function(field, data) return WeField.compareWithList(field, data, private.MovementType) end)
static.Field.Name = WeField.new("unam", 'string', "Name")
static.Field.NameEditorSuffix = WeField.new("unsf", 'string', "NameEditorSuffix")
static.Field.NormalAbilities = WeField.new("uabi", 'string', "NormalAbilities")
static.Field.OccluderHeight = WeField.new("uocc", 'real', "OccluderHeight")
static.Field.OrientationInterpolation = WeField.new("uori", 'int', "OrientationInterpolation")
static.Field.PlaceableInEditor = WeField.new("uine", 'bool', "PlaceableInEditor")
static.Field.PointValue = WeField.new("upoi", 'int', "PointValue")
static.Field.Priority = WeField.new("upri", 'int', "Priority")
static.Field.ProjectileImpactZ = WeField.new("uimz", 'real', "ProjectileImpactZ")
static.Field.ProjectileImpactZSwimming = WeField.new("uisz", 'real', "ProjectileImpactZSwimming")
static.Field.ProjectileLaunchX = WeField.new("ulpx", 'real', "ProjectileLaunchX")
static.Field.ProjectileLaunchY = WeField.new("ulpy", 'real', "ProjectileLaunchY")
static.Field.ProjectileLaunchZ = WeField.new("ulpz", 'real', "ProjectileLaunchZ")
static.Field.ProjectileLaunchZSwimming = WeField.new("ulsz", 'real', "ProjectileLaunchZSwimming")
static.Field.PropulsionWindowdegrees = WeField.new("uprw", 'real', "PropulsionWindowdegrees")
--- 'commoner', 'creeps', 'critters', 'demon', 'human', 'naga', 'nightelf', 'orc', 'other', 'undead', 'unknown'
static.Field.Race = WeField.new("urac", 'string', "Race", function(field, data) return WeField.compareWithList(field, data, private.checkRace) end)
static.Field.RandomSound = WeField.new("ursl", 'string', "RandomSound")
static.Field.RepairGoldCost = WeField.new("ugor", 'int', "RepairGoldCost")
static.Field.RepairLumberCost = WeField.new("ulur", 'int', "RepairLumberCost")
static.Field.RepairTime = WeField.new("urtm", 'int', "RepairTime")
static.Field.RequiredAnimationNames = WeField.new("uani", 'string', "RequiredAnimationNames")
static.Field.RequiredAnimationNamesAttachments = WeField.new("uaap", 'string', "RequiredAnimationNamesAttachments")
static.Field.RequiredAttachmentLinkNames = WeField.new("ualp", 'string', "RequiredAttachmentLinkNames")
static.Field.RequiredBoneNames = WeField.new("ubpr", 'string', "RequiredBoneNames")
static.Field.Requirements = WeField.new("ureq", 'string', "Requirements")
static.Field.RequirementsLevels = WeField.new("urqa", 'string', "RequirementsLevels")
static.Field.ScaleProjectiles = WeField.new("uscb", 'bool', "ScaleProjectiles")
static.Field.ModelScale = WeField.new("usca", 'real', "ScalingValue")
static.Field.SelectionCircleHeight = WeField.new("uslz", 'real', "SelectionCircleHeight")
static.Field.SelectionCircleOnWater = WeField.new("usew", 'bool', "SelectionCircleOnWater")
static.Field.SelectionScale = WeField.new("ussc", 'real', "SelectionScale")
static.Field.ShadowImageCenterX = WeField.new("ushx", 'real', "ShadowImageCenterX")
static.Field.ShadowImageCenterY = WeField.new("ushy", 'real', "ShadowImageCenterY")
static.Field.ShadowImageHeight = WeField.new("ushh", 'real', "ShadowImageHeight")
static.Field.ShadowImageUnit = WeField.new("ushu", 'string', "ShadowImageUnit")
static.Field.ShadowImageWidth = WeField.new("ushw", 'real', "ShadowImageWidth")
static.Field.ShadowTextureBuilding = WeField.new("ushb", 'string', "ShadowTextureBuilding")
static.Field.SightRadiusDay = WeField.new("usid", 'int', "SightRadiusDay")
static.Field.SightRadiusNight = WeField.new("usin", 'int', "SightRadiusNight")
static.Field.Sleeps = WeField.new("usle", 'bool', "Sleeps")
static.Field.SoundLoopingFadeInRate = WeField.new("ulfi", 'int', "SoundLoopingFadeInRate")
static.Field.SoundLoopingFadeOutRate = WeField.new("ulfo", 'int', "SoundLoopingFadeOutRate")
static.Field.MovementSpeedBase = WeField.new("umvs", 'int', "SpeedBase")
static.Field.MovementSpeedMaximum = WeField.new("umas", 'int', "SpeedMaximum")
static.Field.MovementSpeedMinimum = WeField.new("umis", 'int', "SpeedMinimum")
static.Field.StockMaximum = WeField.new("usma", 'int', "StockMaximum")
static.Field.StockReplenishInterval = WeField.new("usrg", 'int', "StockReplenishInterval")
static.Field.StockStartDelay = WeField.new("usst", 'int', "StockStartDelay")
static.Field.TargetedAs = WeField.new("utar", 'string', "TargetedAs")
static.Field.TeamColor = WeField.new("utco", 'int', "TeamColor")
static.Field.Tilesets = WeField.new("util", 'string', "Tilesets")
static.Field.TintingColorBlue = WeField.new("uclb", 'int', "TintingColorBlue")
static.Field.TintingColorGreen = WeField.new("uclg", 'int', "TintingColorGreen")
static.Field.TintingColorRed = WeField.new("uclr", 'int', "TintingColorRed")
static.Field.TooltipBasic = WeField.new("utip", 'string', "TooltipBasic")
static.Field.TooltipExtended = WeField.new("utub", "string", "TooltipExtended")
static.Field.TurnRate = WeField.new("umvr", 'real', "TurnRate")
static.Field.UnitClassification = WeField.new("utyp", 'string', "UnitClassification")
static.Field.UnitSoundSet = WeField.new("usnd", 'string', "UnitSoundSet")
static.Field.UnitsSold = WeField.new("useu", 'string', "UnitsSold")
static.Field.UpgradesUsed = WeField.new("upgr", 'string', "UpgradesUsed")
static.Field.UseClickHelper = WeField.new("uuch", 'bool', "UseClickHelper")
static.Field.UseExtendedLineofSight = WeField.new("ulos", 'bool', "UseExtendedLineofSight")

--=============
-- Hero fields
--=============
static.Field.Hero_AgilityPerLevel = WeField.new("uagp", 'real', "AgilityPerLevel")
static.Field.Hero_ConstructionSound = WeField.new("ubsl", 'string', "ConstructionSound")
static.Field.Hero_FormationRank = WeField.new("ufor", 'int', "FormationRank")
static.Field.Hero_GroundTexture = WeField.new("uubs", 'string', "GroundTexture")
static.Field.Hero_GroupSeparationEnabled = WeField.new("urpo", 'bool', "GroupSeparationEnabled")
static.Field.Hero_GroupSeparationGroupNumber = WeField.new("urpg", 'int', "GroupSeparationGroupNumber")
static.Field.Hero_GroupSeparationParameter = WeField.new("urpp", 'int', "GroupSeparationParameter")
static.Field.Hero_GroupSeparationPriority = WeField.new("urpr", 'int', "GroupSeparationPriority")
static.Field.Hero_HeroAbilities = WeField.new("uhab", 'string', "HeroAbilities")
static.Field.Hero_HeroRevivalLocations = WeField.new("urva", 'string', "HeroRevivalLocations")
static.Field.Hero_HideHeroDeathMsg = WeField.new("uhhd", 'bool', "HideHeroDeathMsg")
static.Field.Hero_HideHeroInterfaceIcon = WeField.new("uhhb", 'bool', "HideHeroInterfaceIcon")
static.Field.Hero_HideHeroMinimapDisplay = WeField.new("uhhm", 'bool', "HideHeroMinimapDisplay")
static.Field.Hero_IntelligencePerLevel = WeField.new("uinp", 'real', "IntelligencePerLevel")
static.Field.Hero_Level = WeField.new("ulev", 'int', "Level")
static.Field.Hero_PrimaryAttribute = WeField.new("upra", 'string', "PrimaryAttribute")
static.Field.Hero_ProperNames = WeField.new("upro", 'string', "ProperNames")
static.Field.Hero_ProperNamesUsed = WeField.new("upru", 'int', "ProperNamesUsed")
static.Field.Hero_RequierementsForTier1 = WeField.new("urq0", 'string', "RequierementsForTier1")
static.Field.Hero_RequierementsForTier2 = WeField.new("urq1", 'string', "RequierementsForTier2")
static.Field.Hero_RequierementsForTier3 = WeField.new("urq2", 'string', "RequierementsForTier3")
static.Field.Hero_RequierementsForTier4 = WeField.new("urq3", 'string', "RequierementsForTier4")
static.Field.Hero_RequierementsForTier5 = WeField.new("urq4", 'string', "RequierementsForTier5")
static.Field.Hero_RequierementsForTier6 = WeField.new("urq5", 'string', "RequierementsForTier6")
static.Field.Hero_RequierementsForTier7 = WeField.new("urq6", 'string', "RequierementsForTier7")
static.Field.Hero_RequierementsForTier8 = WeField.new("urq7", 'string', "RequierementsForTier8")
static.Field.Hero_RequierementsForTier9 = WeField.new("urq8", 'string', "RequierementsForTier9")
static.Field.Hero_StartingAgility = WeField.new("uagi", 'int', "StartingAgility")
static.Field.Hero_StartingIntelligence = WeField.new("uint", 'int', "StartingIntelligence")
static.Field.Hero_StartingStrength = WeField.new("ustr", 'int', "StartingStrength")
static.Field.Hero_StrengthPerLevel = WeField.new("ustp", 'real', "StrengthPerLevel")
static.Field.Hero_StructuresBuilt = WeField.new("ubui", 'string', "StructuresBuilt")
static.Field.Hero_TooltipAwaken = WeField.new("uawt", 'string', "TooltipAwaken")
static.Field.Hero_TooltipRevive = WeField.new("utpr", 'string', "TooltipRevive")
static.Field.Hero_TransportedSize = WeField.new("ucar", 'int', "TransportedSize")

--=================
-- Building fields
--=================
static.Field.AgilityPerLevel = WeField.new("uagp", 'real', "AgilityPerLevel")
static.Field.ConstructionSound = WeField.new("ubsl", 'string', "ConstructionSound")
static.Field.GroundTexture = WeField.new("uubs", 'string', "GroundTexture")
static.Field.ItemsMade = WeField.new("umki", 'string', "ItemsMade")
static.Field.NeutralBuildingShowsMinimapIcon = WeField.new("unbm", 'bool', "NeutralBuildingShowsMinimapIcon")
static.Field.NeutralBuildingValidAsRandomBuilding = WeField.new("unbr", 'bool', "NeutralBuildingValidAsRandomBuilding")
static.Field.PathingMap = WeField.new("upat", 'string', "PathingMap")
static.Field.PlacementPreventedBy = WeField.new("upar", 'string', "PlacementPreventedBy")
static.Field.PlacementRequires = WeField.new("upap", 'string', "PlacementRequires")
static.Field.PlacementRequiresWaterRadius = WeField.new("upaw", 'real', "PlacementRequiresWaterRadius")
static.Field.ResearchesAvailable = WeField.new("ures", 'string', "ResearchesAvailable")
static.Field.RevivesDeadHeros = WeField.new("urev", 'bool', "RevivesDeadHeros")
static.Field.UnitsTrained = WeField.new("utra", 'string', "UnitsTrained")
static.Field.UpgradesTo = WeField.new("uupt", 'string', "UpgradesTo")

--=========
-- Private
--=========

private.path_sep = package.config:sub(1,1)
private.file_src = GetSrcDir()..private.path_sep..'war3map.w3u'
private.file_dst = GetDstDir()..private.path_sep..'war3map.w3u'

private.ArmorSoundsTypes = {'Ethereal', 'Flesh', 'Wood', 'Stone', 'Metal'}

private.ArmorTypes = {'normal', 'small', 'medium', 'large', 'fort', 'hero', 'divine', 'none'}

private.AttackTypes = {'unknown', 'normal', 'pierce', 'siege', 'spells', 'chaos', 'magic', 'hero'}

private.AttackTargetsAllowed = {'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration',
'enemies', 'friend', 'ground', 'hero', 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient',
'none', 'nonhero', 'nonsapper', 'notself', 'organic', 'player', 'playerunits', 'sapper', 'self',
'structure', 'terrain', 'tree', 'vulnerable', 'wall'}

private.AttackWeaponSounds = {'Nothing', 'AxeMediumChop', 'MetalHeavyBash', 'MetalHeavyChop',
'MetalHeavySlice', 'MetalLightChop', 'MetalLightSlice', 'MetalMediumBash', 'MetalMediumChop',
'MetalMediumSlice', 'RockHeavyBash', 'WoodHeavyBash', 'WoodLightBash', 'WoodMediumBash'}

private.AttackWeaponTypes = {'normal', 'instant', 'artillery', 'aline', 'missile',
'msplash', 'mbounce', 'mline'}

private.MovementTypes = {'horse', 'fly', 'hover', 'float', 'amph'}

private.Races = {'commoner', 'creeps', 'critters', 'demon', 'human', 'naga', 'nightelf', 'orc', 'other', 'undead', 'unknown'}

return WeUnit.static