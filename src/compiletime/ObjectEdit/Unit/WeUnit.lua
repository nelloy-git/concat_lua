--=========
-- Include
--=========

---@type WeFieldClass
local WeField = require('compiletime.ObjectEdit.WeField')
---@type WeObjectClass
local WeObject = require('compiletime.ObjectEdit.WeObject')
---@type WeObjectFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeObjectFile')

--=======
-- Class
--=======

---@type WeUnitClass
local WeUnit = newClass('WeUnit', WeObject)

---@class WeUnit : WeObject
local public = WeUnit.public
---@class WeUnitClass : WeObjectClass
local static = WeUnit.static
---@type WeUnitClass
local override = WeUnit.override
---@type table(WeUnit, table)
local private = {}

private.path_sep = package.config:sub(1,1)
private.file_src = _G._src_dir..private.path_sep..'war3map.w3u'
private.file_dst = _G._dst_dir..private.path_sep..'war3map.w3u'

--=========
-- Methods
--=========

---@return WeUnit
function override.new(id, base_id, name, instance_data)
    local instance = instance_data or newInstanceData(WeUnit)
    instance = WeObject.new(id, base_id, name, instance)

    if not private.we_file then
        private.we_file = WeObjectFile.new(private.file_src, private.file_dst)
    end
    private.we_file:addObject(instance)

    return instance
end

function static.save()
    if private.we_file then
        private.we_file:update()
    end
end

function public:free()
    WeObject.free(self)
end

static.AIPlacementRadius = WeField.new("uabr", 'real', "AIPlacementRadius")
static.AIPlacementType = WeField.new("uabt", 'string', "AIPlacementType")
static.AllowCustomTeamColor = WeField.new("utcc", 'bool', "AllowCustomTeamColor")
static.AnimationBlendTimeseconds = WeField.new("uble", 'real', "AnimationBlendTimeseconds")
static.AnimationCastBackswing = WeField.new("ucbs", 'real', "AnimationCastBackswing")
static.AnimationCastPoint = WeField.new("ucpt", 'real', "AnimationCastPoint")
static.AnimationRunSpeed = WeField.new("urun", 'real', "AnimationRunSpeed")
static.AnimationWalkSpeed = WeField.new("uwal", 'real', "AnimationWalkSpeed")
---Possible data: 'Ethereal'|'Flesh'|'Wood'|'Stone'|'Metal'
static.ArmorSoundType = WeField.new("uarm", 'string', "ArmorSoundType")
---Possible data: "normal"|"small"|"medium"|"large"|"fort"|"hero"|"divine"|"none"
static.ArmorType = WeField.new("udty", 'string', "ArmorType")
static.ArtSpecial = WeField.new("uspa", 'string', "ArtSpecial")
static.ArtTarget = WeField.new("utaa", 'string', "ArtTarget")
static.Attack1AnimationBackswingPoint = WeField.new("ubs1", 'real', "Attack1AnimationBackswingPoint")
static.Attack1AnimationDamagePoint = WeField.new("udp1", 'real', "Attack1AnimationDamagePoint")
static.Attack1AreaofEffectFullDamage = WeField.new("ua1f", 'int', "Attack1AreaofEffectFullDamage")
static.Attack1AreaofEffectMediumDamage = WeField.new("ua1h", 'int', "Attack1AreaofEffectMediumDamage")
static.Attack1AreaofEffectSmallDamage = WeField.new("ua1q", 'int', "Attack1AreaofEffectSmallDamage")
static.Attack1AreaofEffectTargets = WeField.new("ua1p", 'string', "Attack1AreaofEffectTargets")
---Possible data: 'unknown'|'normal'|'pierce'|'siege'|'spells'|'chaos'|'magic'|'hero'
static.Attack1AttackType = WeField.new("ua1t", 'string', "Attack1AttackType")
static.Attack1CooldownTime = WeField.new("ua1c", 'real', "Attack1CooldownTime")
static.Attack1DamageBase = WeField.new("ua1b", 'int', "Attack1DamageBase")
static.Attack1DamageFactorMedium = WeField.new("uhd1", 'real', "Attack1DamageFactorMedium")
static.Attack1DamageFactorSmall = WeField.new("uqd1", 'real', "Attack1DamageFactorSmall")
static.Attack1DamageLossFactor = WeField.new("udl1", 'real', "Attack1DamageLossFactor")
static.Attack1DamageSidesperDie = WeField.new("ua1s", 'int', "Attack1DamageSidesperDie")
static.Attack1DamageSpillDistance = WeField.new("usd1", 'real', "Attack1DamageSpillDistance")
static.Attack1DamageSpillRadius = WeField.new("usr1", 'real', "Attack1DamageSpillRadius")
static.Attack1DamageUpgradeAmount = WeField.new("udu1", 'int', "Attack1DamageUpgradeAmount")
static.Attack1DamagebooleanofDice = WeField.new("ua1d", 'int', "Attack1DamagebooleanofDice")
static.Attack1MaximumbooleanofTargets = WeField.new("utc1", 'int', "Attack1MaximumbooleanofTargets")
static.Attack1ProjectileArc = WeField.new("uma1", 'real', "Attack1ProjectileArc")
static.Attack1ProjectileArt = WeField.new("ua1m", 'string', "Attack1ProjectileArt")
static.Attack1ProjectileHomingEnabled = WeField.new("umh1", 'bool', "Attack1ProjectileHomingEnabled")
static.Attack1ProjectileSpeed = WeField.new("ua1z", 'int', "Attack1ProjectileSpeed")
static.Attack1Range = WeField.new("ua1r", 'int', "Attack1Range")
static.Attack1RangeMotionBuffer = WeField.new("urb1", 'real', "Attack1RangeMotionBuffer")
static.Attack1ShowUI = WeField.new("uwu1", 'bool', "Attack1ShowUI")
static.Attack1TargetsAllowed = WeField.new("ua1g", 'string', "Attack1TargetsAllowed")
---Possible data: 'Nothing'|'AxeMediumChop'|'MetalHeavyBash'|'MetalHeavyChop'|'MetalHeavySlice'|'MetalLightChop'|'MetalLightSlice'|'MetalMediumBash'|'MetalMediumChop'|'MetalMediumSlice'|'RockHeavyBash'|'WoodHeavyBash'|'WoodLightBash'|'WoodMediumBash'
static.Attack1WeaponSound = WeField.new("ucs1", 'string', "Attack1WeaponSound")
---Possible data: 'normal'|'instant'|'artillery'|'aline'|'missile'|'msplash'|'mbounce'|'mline'
static.Attack1WeaponType = WeField.new("ua1w", 'string', "Attack1WeaponType")
static.Attack2AnimationBackswingPoint = WeField.new("ubs2", 'real', "Attack2AnimationBackswingPoint")
static.Attack2AnimationDamagePoint = WeField.new("udp2", 'real', "Attack2AnimationDamagePoint")
static.Attack2AreaofEffectFullDamage = WeField.new("ua2f", 'int', "Attack2AreaofEffectFullDamage")
static.Attack2AreaofEffectMediumDamage = WeField.new("ua2h", 'int', "Attack2AreaofEffectMediumDamage")
static.Attack2AreaofEffectSmallDamage = WeField.new("ua2q", 'int', "Attack2AreaofEffectSmallDamage")
static.Attack2AreaofEffectTargets = WeField.new("ua2p", 'string', "Attack2AreaofEffectTargets")
---Possible data: 'unknown'|'normal'|'pierce'|'siege'|'spells'|'chaos'|'magic'|'hero'
static.Attack2AttackType = WeField.new("ua2t", 'string', "Attack2AttackType")
static.Attack2CooldownTime = WeField.new("ua2c", 'real', "Attack2CooldownTime")
static.Attack2DamageBase = WeField.new("ua2b", 'int', "Attack2DamageBase")
static.Attack2DamageFactorMedium = WeField.new("uhd2", 'real', "Attack2DamageFactorMedium")
static.Attack2DamageFactorSmall = WeField.new("uqd2", 'real', "Attack2DamageFactorSmall")
static.Attack2DamageLossFactor = WeField.new("udl2", 'real', "Attack2DamageLossFactor")
static.Attack2DamageSidesperDie = WeField.new("ua2s", 'int', "Attack2DamageSidesperDie")
static.Attack2DamageSpillDistance = WeField.new("usd2", 'real', "Attack2DamageSpillDistance")
static.Attack2DamageSpillRadius = WeField.new("usr2", 'real', "Attack2DamageSpillRadius")
static.Attack2DamageUpgradeAmount = WeField.new("udu2", 'int', "Attack2DamageUpgradeAmount")
static.Attack2DamagebooleanofDice = WeField.new("ua2d", 'int', "Attack2DamagebooleanofDice")
static.Attack2MaximumbooleanofTargets = WeField.new("utc2", 'int', "Attack2MaximumbooleanofTargets")
static.Attack2ProjectileArc = WeField.new("uma2", 'real', "Attack2ProjectileArc")
static.Attack2ProjectileArt = WeField.new("ua2m", 'string', "Attack2ProjectileArt")
static.Attack2ProjectileHomingEnabled = WeField.new("umh2", 'bool', "Attack2ProjectileHomingEnabled")
static.Attack2ProjectileSpeed = WeField.new("ua2z", 'int', "Attack2ProjectileSpeed")
static.Attack2Range = WeField.new("ua2r", 'int', "Attack2Range")
static.Attack2RangeMotionBuffer = WeField.new("urb2", 'real', "Attack2RangeMotionBuffer")
static.Attack2ShowUI = WeField.new("uwu2", 'bool', "Attack2ShowUI")
static.Attack2TargetsAllowed = WeField.new("ua2g", 'string', "Attack2TargetsAllowed")
---Possible data: "Nothing"|"AxeMediumChop"|"MetalHeavyBash"|"MetalHeavyChop"|"MetalHeavySlice"|"MetalLightChop"|"MetalLightSlice"|"MetalMediumBash"|"MetalMediumChop"|"MetalMediumSlice"|"RockHeavyBash"|WoodHeavyBash"|"WoodLightBash"|"WoodMediumBash"
static.Attack2WeaponSound = WeField.new("ucs2", 'string', "Attack2WeaponSound")
---Possible data: 'normal'|'instant'|'artillery'|'aline'|'missile'|'msplash'|'mbounce'|'mline'
static.Attack2WeaponType = WeField.new("ua2w", 'string', "Attack2WeaponType")
static.AttacksEnabled = WeField.new("uaen", 'int', "AttacksEnabled")
static.BuildTime = WeField.new("ubld", 'int', "BuildTime")
static.ButtonPositionX = WeField.new("ubpx", 'int', "ButtonPositionX")
static.ButtonPositionY = WeField.new("ubpy", 'int', "ButtonPositionY")
static.CanDropItemsOnDeath = WeField.new("udro", 'bool', "CanDropItemsOnDeath")
static.CanFlee = WeField.new("ufle", 'bool', "CanFlee")
static.CategorizationCampaign = WeField.new("ucam", 'bool', "CategorizationCampaign")
static.CategorizationSpecial = WeField.new("uspe", 'bool', "CategorizationSpecial")
static.CollisionSize = WeField.new("ucol", 'real', "CollisionSize")
static.DeathTimeseconds = WeField.new("udtm", 'real', "DeathTimeseconds")
static.DeathType = WeField.new("udea", 'int', "DeathType")
static.DefaultActiveAbility = WeField.new("udaa", 'string', "DefaultActiveAbility")
static.DefenseBase = WeField.new("udef", 'int', "DefenseBase")
static.DefenseUpgradeBonus = WeField.new("udup", 'int', "DefenseUpgradeBonus")
static.DependencyEquivalents = WeField.new("udep", 'string', "DependencyEquivalents")
static.Description = WeField.new("ides", 'string', "Description")
static.DisplayasNeutralHostile = WeField.new("uhos", 'bool', "DisplayasNeutralHostile")
static.ElevationSamplePoints = WeField.new("uept", 'int', "ElevationSamplePoints")
static.ElevationSampleRadius = WeField.new("uerd", 'real', "ElevationSampleRadius")
static.FogOfWarSampleRadius = WeField.new("ufrd", 'real', "FogOfWarSampleRadius")
static.FoodCost = WeField.new("ufoo", 'int', "FoodCost")
static.FoodProduced = WeField.new("ufma", 'int', "FoodProduced")
static.GoldBountyAwardedBase = WeField.new("ubba", 'int', "GoldBountyAwardedBase")
static.GoldBountyAwardedSidesperDie = WeField.new("ubsi", 'int', "GoldBountyAwardedSidesperDie")
static.GoldBountyAwardedbooleanofDice = WeField.new("ubdi", 'int', "GoldBountyAwardedbooleanofDice")
static.GoldCost = WeField.new("ugol", 'int', "GoldCost")
static.HasTilesetSpecificData = WeField.new("utss", 'bool', "HasTilesetSpecificData")
static.HasWaterShadow = WeField.new("ushr", 'bool', "HasWaterShadow")
static.HideMinimapDisplay = WeField.new("uhom", 'bool', "HideMinimapDisplay")
static.HitPointsMaximumBase = WeField.new("uhpm", 'int', "HitPointsMaximumBase")
static.HitPointsRegenerationRate = WeField.new("uhpr", 'real', "HitPointsRegenerationRate")
static.HitPointsRegenerationType = WeField.new("uhrt", 'string', "HitPointsRegenerationType")
static.Hotkey = WeField.new("uhot", 'string', "Hotkey")
static.IconGameInterface = WeField.new("uico", 'string', "IconGameInterface")
static.IconScoreScreen = WeField.new("ussi", 'string', "IconScoreScreen")
static.IsaBuilding = WeField.new("ubdg", 'bool', "IsaBuilding")
static.ItemsSold = WeField.new("usei", 'string', "ItemsSold")
static.LumberBountyAwardedBase = WeField.new("ulba", 'int', "LumberBountyAwardedBase")
static.LumberBountyAwardedSidesperDie = WeField.new("ulbs", 'int', "LumberBountyAwardedSidesperDie")
static.LumberBountyAwardedbooleanofDice = WeField.new("ulbd", 'int', "LumberBountyAwardedbooleanofDice")
static.LumberCost = WeField.new("ulum", 'int', "LumberCost")
static.ManaInitialAmount = WeField.new("umpi", 'int', "ManaInitialAmount")
static.ManaMaximum = WeField.new("umpm", 'int', "ManaMaximum")
static.ManaRegeneration = WeField.new("umpr", 'real', "ManaRegeneration")
static.MaximumPitchAngledegrees = WeField.new("umxp", 'real', "MaximumPitchAngledegrees")
static.MaximumRollAngledegrees = WeField.new("umxr", 'real', "MaximumRollAngledegrees")
static.MinimumAttackRange = WeField.new("uamn", 'int', "MinimumAttackRange")
static.ModelFile = WeField.new("umdl", 'string', "ModelFile")
static.ModelFileExtraVersions = WeField.new("uver", 'string', "ModelFileExtraVersions")
static.MovementHeight = WeField.new("umvh", 'real', "MovementHeight")
static.MovementHeightMinimum = WeField.new("umvf", 'real', "MovementHeightMinimum")
static.MovementSound = WeField.new("umsl", 'string', "MovementSound")
---Possible data: 'horse'|'fly'|'hover'|'float'|'amph'
static.MovementType = WeField.new("umvt", 'string', "MovementType")
static.Name = WeField.new("unam", 'string', "Name")
static.NameEditorSuffix = WeField.new("unsf", 'string', "NameEditorSuffix")
static.NormalAbilities = WeField.new("uabi", 'string', "NormalAbilities")
static.OccluderHeight = WeField.new("uocc", 'real', "OccluderHeight")
static.OrientationInterpolation = WeField.new("uori", 'int', "OrientationInterpolation")
static.PlaceableInEditor = WeField.new("uine", 'bool', "PlaceableInEditor")
static.PointValue = WeField.new("upoi", 'int', "PointValue")
static.Priority = WeField.new("upri", 'int', "Priority")
static.ProjectileImpactZ = WeField.new("uimz", 'real', "ProjectileImpactZ")
static.ProjectileImpactZSwimming = WeField.new("uisz", 'real', "ProjectileImpactZSwimming")
static.ProjectileLaunchX = WeField.new("ulpx", 'real', "ProjectileLaunchX")
static.ProjectileLaunchY = WeField.new("ulpy", 'real', "ProjectileLaunchY")
static.ProjectileLaunchZ = WeField.new("ulpz", 'real', "ProjectileLaunchZ")
static.ProjectileLaunchZSwimming = WeField.new("ulsz", 'real', "ProjectileLaunchZSwimming")
static.PropulsionWindowdegrees = WeField.new("uprw", 'real', "PropulsionWindowdegrees")
---Possible data 'commoner'|'creeps'|'critters'|'demon'|'human'|'naga'|'nightelf'|'orc'|'other'|'undead'|'unknown'
static.Race = WeField.new("urac", 'string', "Race")
static.RandomSound = WeField.new("ursl", 'string', "RandomSound")
static.RepairGoldCost = WeField.new("ugor", 'int', "RepairGoldCost")
static.RepairLumberCost = WeField.new("ulur", 'int', "RepairLumberCost")
static.RepairTime = WeField.new("urtm", 'int', "RepairTime")
static.RequiredAnimationNames = WeField.new("uani", 'string', "RequiredAnimationNames")
static.RequiredAnimationNamesAttachments = WeField.new("uaap", 'string', "RequiredAnimationNamesAttachments")
static.RequiredAttachmentLinkNames = WeField.new("ualp", 'string', "RequiredAttachmentLinkNames")
static.RequiredBoneNames = WeField.new("ubpr", 'string', "RequiredBoneNames")
static.Requirements = WeField.new("ureq", 'string', "Requirements")
static.RequirementsLevels = WeField.new("urqa", 'string', "RequirementsLevels")
static.ScaleProjectiles = WeField.new("uscb", 'bool', "ScaleProjectiles")
static.ScalingValue = WeField.new("usca", 'real', "ScalingValue")
static.SelectionCircleHeight = WeField.new("uslz", 'real', "SelectionCircleHeight")
static.SelectionCircleOnWater = WeField.new("usew", 'bool', "SelectionCircleOnWater")
static.SelectionScale = WeField.new("ussc", 'real', "SelectionScale")
static.ShadowImageCenterX = WeField.new("ushx", 'real', "ShadowImageCenterX")
static.ShadowImageCenterY = WeField.new("ushy", 'real', "ShadowImageCenterY")
static.ShadowImageHeight = WeField.new("ushh", 'real', "ShadowImageHeight")
static.ShadowImageUnit = WeField.new("ushu", 'string', "ShadowImageUnit")
static.ShadowImageWidth = WeField.new("ushw", 'real', "ShadowImageWidth")
static.ShadowTextureBuilding = WeField.new("ushb", 'string', "ShadowTextureBuilding")
static.SightRadiusDay = WeField.new("usid", 'int', "SightRadiusDay")
static.SightRadiusNight = WeField.new("usin", 'int', "SightRadiusNight")
static.Sleeps = WeField.new("usle", 'bool', "Sleeps")
static.SoundLoopingFadeInRate = WeField.new("ulfi", 'int', "SoundLoopingFadeInRate")
static.SoundLoopingFadeOutRate = WeField.new("ulfo", 'int', "SoundLoopingFadeOutRate")
static.SpeedBase = WeField.new("umvs", 'int', "SpeedBase")
static.SpeedMaximum = WeField.new("umas", 'int', "SpeedMaximum")
static.SpeedMinimum = WeField.new("umis", 'int', "SpeedMinimum")
static.StockMaximum = WeField.new("usma", 'int', "StockMaximum")
static.StockReplenishInterval = WeField.new("usrg", 'int', "StockReplenishInterval")
static.StockStartDelay = WeField.new("usst", 'int', "StockStartDelay")
static.TargetedAs = WeField.new("utar", 'string', "TargetedAs")
static.TeamColor = WeField.new("utco", 'int', "TeamColor")
static.Tilesets = WeField.new("util", 'string', "Tilesets")
static.TintingColorBlue = WeField.new("uclb", 'int', "TintingColorBlue")
static.TintingColorGreen = WeField.new("uclg", 'int', "TintingColorGreen")
static.TintingColorRed = WeField.new("uclr", 'int', "TintingColorRed")
static.TooltipBasic = WeField.new("utip", 'string', "TooltipBasic")
static.TooltipExtended = WeField.new("utub", "string", "TooltipExtended")
static.TurnRate = WeField.new("umvr", 'real', "TurnRate")
static.UnitClassification = WeField.new("utyp", 'string', "UnitClassification")
static.UnitSoundSet = WeField.new("usnd", 'string', "UnitSoundSet")
static.UnitsSold = WeField.new("useu", 'string', "UnitsSold")
static.UpgradesUsed = WeField.new("upgr", 'string', "UpgradesUsed")
static.UseClickHelper = WeField.new("uuch", 'bool', "UseClickHelper")
static.UseExtendedLineofSight = WeField.new("ulos", 'bool', "UseExtendedLineofSight")

return WeUnit