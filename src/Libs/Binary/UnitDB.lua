---@class BinaryUnitDB
local UnitValueDB = {}

UnitValueDB.AIPlacementRadius = {value_id = "uabr", value_type = 'real'}
UnitValueDB.AIPlacementType = {value_id = "uabt", value_type = 'string'}
UnitValueDB.AllowCustomTeamColor = {value_id = "utcc", value_type = 'bool'}
UnitValueDB.AnimationBlendTimeseconds = {value_id = "uble", value_type = 'real'}
UnitValueDB.AnimationCastBackswing = {value_id = "ucbs", value_type = 'real'}
UnitValueDB.AnimationCastPoint = {value_id = "ucpt", value_type = 'real'}
UnitValueDB.AnimationRunSpeed = {value_id = "urun", value_type = 'real'}
UnitValueDB.AnimationWalkSpeed = {value_id = "uwal", value_type = 'real'}
--- 'Ethereal', 'Flesh', 'Wood', 'Stone', 'Metal'
UnitValueDB.ArmorSoundType = {value_id = "uarm", value_type = 'string'}
--- 'normal', 'small', 'medium', 'large', 'fort', 'hero', 'divine', 'none'
UnitValueDB.ArmorType = {value_id = "udty", value_type = 'string'}
UnitValueDB.ArtSpecial = {value_id = "uspa", value_type = 'string'}
UnitValueDB.ArtTarget = {value_id = "utaa", value_type = 'string'}
UnitValueDB.Attack1 = {}
UnitValueDB.Attack1.AnimationBackswingPoint = {value_id = "ubs1", value_type = 'real'}
UnitValueDB.Attack1.AnimationDamagePoint = {value_id = "udp1", value_type = 'real'}
UnitValueDB.Attack1.AreaofEffectFullDamage = {value_id = "ua1f", value_type = 'int'}
UnitValueDB.Attack1.AreaofEffectMediumDamage = {value_id = "ua1h", value_type = 'int'}
UnitValueDB.Attack1.AreaofEffectSmallDamage = {value_id = "ua1q", value_type = 'int'}
UnitValueDB.Attack1.AreaofEffectTargets = {value_id = "ua1p", value_type = 'string'}
--- 'unknown', 'normal', 'pierce', 'siege', 'spells', 'chaos', 'magic', 'hero'
UnitValueDB.Attack1.AttackType = {value_id = "ua1t", value_type = 'string'}
UnitValueDB.Attack1.CooldownTime = {value_id = "ua1c", value_type = 'real'}
UnitValueDB.Attack1.DamageBase = {value_id = "ua1b", value_type = 'int'}
UnitValueDB.Attack1.DamageFactorMedium = {value_id = "uhd1", value_type = 'real'}
UnitValueDB.Attack1.DamageFactorSmall = {value_id = "uqd1", value_type = 'real'}
UnitValueDB.Attack1.DamageLossFactor = {value_id = "udl1", value_type = 'real'}
UnitValueDB.Attack1.DamageSidesperDie = {value_id = "ua1s", value_type = 'int'}
UnitValueDB.Attack1.DamageSpillDistance = {value_id = "usd1", value_type = 'real'}
UnitValueDB.Attack1.DamageSpillRadius = {value_id = "usr1", value_type = 'real'}
UnitValueDB.Attack1.DamageUpgradeAmount = {value_id = "udu1", value_type = 'int'}
UnitValueDB.Attack1.DamageDice = {value_id = "ua1d", value_type = 'int'}
UnitValueDB.Attack1.MaximumTargets = {value_id = "utc1", value_type = 'int'}
UnitValueDB.Attack1.ProjectileArc = {value_id = "uma1", value_type = 'real'}
UnitValueDB.Attack1.ProjectileArt = {value_id = "ua1m", value_type = 'string'}
UnitValueDB.Attack1.ProjectileHomingEnabled = {value_id = "umh1", value_type = 'bool'}
UnitValueDB.Attack1.ProjectileSpeed = {value_id = "ua1z", value_type = 'int'}
UnitValueDB.Attack1.Range = {value_id = "ua1r", value_type = 'int'}
UnitValueDB.Attack1.RangeMotionBuffer = {value_id = "urb1", value_type = 'real'}
UnitValueDB.Attack1.ShowUI = {value_id = "uwu1", value_type = 'bool'}
--- 'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration', 'enemies', 'friend', 'ground', 'hero',
--- 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient', 'none', 'nonhero', 'nonsapper', 'notself',
--- 'organic', 'player', 'playerunits', 'sapper', 'self', 'structure', 'terrain', 'tree', 'vulnerable', 'wall',
UnitValueDB.Attack1.TargetsAllowed = {value_id = "ua1g", value_type = 'string'}
--- 'Nothing', 'AxeMediumChop', 'MetalHeavyBash', 'MetalHeavyChop',
--- 'MetalHeavySlice', 'MetalLightChop', 'MetalLightSlice', 'MetalMediumBash', 'MetalMediumChop',
--- 'MetalMediumSlice', 'RockHeavyBash', 'WoodHeavyBash', 'WoodLightBash', 'WoodMediumBash'
UnitValueDB.Attack1.WeaponSound = {value_id = "ucs1", value_type = 'string'}
--- 'normal', 'instant', 'artillery', 'aline', 'missile', 'splash', 'bounce', 'line'
UnitValueDB.Attack1.WeaponType = {value_id = "ua1w", value_type = 'string'}
UnitValueDB.Attack2 = {}
UnitValueDB.Attack2.AnimationBackswingPoint = {value_id = "ubs2", value_type = 'real'}
UnitValueDB.Attack2.AnimationDamagePoint = {value_id = "udp2", value_type = 'real'}
UnitValueDB.Attack2.AreaofEffectFullDamage = {value_id = "ua2f", value_type = 'int'}
UnitValueDB.Attack2.AreaofEffectMediumDamage = {value_id = "ua2h", value_type = 'int'}
UnitValueDB.Attack2.AreaofEffectSmallDamage = {value_id = "ua2q", value_type = 'int'}
UnitValueDB.Attack2.AreaofEffectTargets = {value_id = "ua2p", value_type = 'string'}
--- 'unknown', 'normal', 'pierce', 'siege', 'spells', 'chaos', 'magic', 'hero'
UnitValueDB.Attack2.AttackType = {value_id = "ua2t", value_type = 'string'}
UnitValueDB.Attack2.CooldownTime = {value_id = "ua2c", value_type = 'real'}
UnitValueDB.Attack2.DamageBase = {value_id = "ua2b", value_type = 'int'}
UnitValueDB.Attack2.DamageFactorMedium = {value_id = "uhd2", value_type = 'real'}
UnitValueDB.Attack2.DamageFactorSmall = {value_id = "uqd2", value_type = 'real'}
UnitValueDB.Attack2.DamageLossFactor = {value_id = "udl2", value_type = 'real'}
UnitValueDB.Attack2.DamageSidesperDie = {value_id = "ua2s", value_type = 'int'}
UnitValueDB.Attack2.DamageSpillDistance = {value_id = "usd2", value_type = 'real'}
UnitValueDB.Attack2.DamageSpillRadius = {value_id = "usr2", value_type = 'real'}
UnitValueDB.Attack2.DamageUpgradeAmount = {value_id = "udu2", value_type = 'int'}
UnitValueDB.Attack2.DamagebooleanofDice = {value_id = "ua2d", value_type = 'int'}
UnitValueDB.Attack2.MaximumbooleanofTargets = {value_id = "utc2", value_type = 'int'}
UnitValueDB.Attack2.ProjectileArc = {value_id = "uma2", value_type = 'real'}
UnitValueDB.Attack2.ProjectileArt = {value_id = "ua2m", value_type = 'string'}
UnitValueDB.Attack2.ProjectileHomingEnabled = {value_id = "umh2", value_type = 'bool'}
UnitValueDB.Attack2.ProjectileSpeed = {value_id = "ua2z", value_type = 'int'}
UnitValueDB.Attack2.Range = {value_id = "ua2r", value_type = 'int'}
UnitValueDB.Attack2.RangeMotionBuffer = {value_id = "urb2", value_type = 'real'}
UnitValueDB.Attack2.ShowUI = {value_id = "uwu2", value_type = 'bool'}
--- 'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration', 'enemies', 'friend', 'ground', 'hero',
--- 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient', 'none', 'nonhero', 'nonsapper', 'notself',
--- 'organic', 'player', 'playerunits', 'sapper', 'self', 'structure', 'terrain', 'tree', 'vulnerable', 'wall'
UnitValueDB.Attack2.TargetsAllowed = {value_id = "ua2g", value_type = 'string'}
--- 'Nothing', 'AxeMediumChop', 'MetalHeavyBash', 'MetalHeavyChop',
--- 'MetalHeavySlice', 'MetalLightChop', 'MetalLightSlice', 'MetalMediumBash', 'MetalMediumChop',
--- 'MetalMediumSlice', 'RockHeavyBash', 'WoodHeavyBash', 'WoodLightBash', 'WoodMediumBash'
UnitValueDB.Attack2.WeaponSound = {value_id = "ucs2", value_type = 'string'}
--- 'unknown', 'normal', 'pierce', 'siege', 'spells', 'chaos', 'magic', 'hero'
UnitValueDB.Attack2.WeaponType = {value_id = "ua2w", value_type = 'string'}
UnitValueDB.AttacksEnabled = {value_id = "uaen", value_type = 'int'}
UnitValueDB.BuildTime = {value_id = "ubld", value_type = 'int'}
UnitValueDB.ButtonPositionX = {value_id = "ubpx", value_type = 'int'}
UnitValueDB.ButtonPositionY = {value_id = "ubpy", value_type = 'int'}
UnitValueDB.CanDropItemsOnDeath = {value_id = "udro", value_type = 'bool'}
UnitValueDB.CanFlee = {value_id = "ufle", value_type = 'bool'}
UnitValueDB.CategorizationCampaign = {value_id = "ucam", value_type = 'bool'}
UnitValueDB.CategorizationSpecial = {value_id = "uspe", value_type = 'bool'}
UnitValueDB.CollisionSize = {value_id = "ucol", value_type = 'real'}
UnitValueDB.DeathTimeseconds = {value_id = "udtm", value_type = 'real'}
UnitValueDB.DeathType = {value_id = "udea", value_type = 'int'}
UnitValueDB.DefaultActiveAbility = {value_id = "udaa", value_type = 'string'}
UnitValueDB.DefenseBase = {value_id = "udef", value_type = 'int'}
UnitValueDB.DefenseUpgradeBonus = {value_id = "udup", value_type = 'int'}
UnitValueDB.DependencyEquivalents = {value_id = "udep", value_type = 'string'}
UnitValueDB.Description = {value_id = "ides", value_type = 'string'}
UnitValueDB.DisplayasNeutralHostile = {value_id = "uhos", value_type = 'bool'}
UnitValueDB.ElevationSamplePoints = {value_id = "uept", value_type = 'int'}
UnitValueDB.ElevationSampleRadius = {value_id = "uerd", value_type = 'real'}
UnitValueDB.FogOfWarSampleRadius = {value_id = "ufrd", value_type = 'real'}
UnitValueDB.FoodCost = {value_id = "ufoo", value_type = 'int'}
UnitValueDB.FoodProduced = {value_id = "ufma", value_type = 'int'}
UnitValueDB.GoldBountyAwardedBase = {value_id = "ubba", value_type = 'int'}
UnitValueDB.GoldBountyAwardedSidesperDie = {value_id = "ubsi", value_type = 'int'}
UnitValueDB.GoldBountyAwardedbooleanofDice = {value_id = "ubdi", value_type = 'int'}
UnitValueDB.GoldCost = {value_id = "ugol", value_type = 'int'}
UnitValueDB.HasTilesetSpecificData = {value_id = "utss", value_type = 'bool'}
UnitValueDB.HasWaterShadow = {value_id = "ushr", value_type = 'bool'}
UnitValueDB.HideMinimapDisplay = {value_id = "uhom", value_type = 'bool'}
UnitValueDB.HitPointsMaximumBase = {value_id = "uhpm", value_type = 'int'}
UnitValueDB.HitPointsRegenerationRate = {value_id = "uhpr", value_type = 'real'}
UnitValueDB.HitPointsRegenerationType = {value_id = "uhrt", value_type = 'string'}
UnitValueDB.Hotkey = {value_id = "uhot", value_type = 'string'}
UnitValueDB.IconGameInterface = {value_id = "uico", value_type = 'string'}
UnitValueDB.IconScoreScreen = {value_id = "ussi", value_type = 'string'}
UnitValueDB.IsaBuilding = {value_id = "ubdg", value_type = 'bool'}
UnitValueDB.ItemsSold = {value_id = "usei", value_type = 'string'}
UnitValueDB.LumberBountyAwardedBase = {value_id = "ulba", value_type = 'int'}
UnitValueDB.LumberBountyAwardedSidesperDie = {value_id = "ulbs", value_type = 'int'}
UnitValueDB.LumberBountyAwardedbooleanofDice = {value_id = "ulbd", value_type = 'int'}
UnitValueDB.LumberCost = {value_id = "ulum", value_type = 'int'}
UnitValueDB.ManaInitialAmount = {value_id = "umpi", value_type = 'int'}
UnitValueDB.ManaMaximum = {value_id = "umpm", value_type = 'int'}
UnitValueDB.ManaRegeneration = {value_id = "umpr", value_type = 'real'}
UnitValueDB.MaximumPitchAngledegrees = {value_id = "umxp", value_type = 'real'}
UnitValueDB.MaximumRollAngledegrees = {value_id = "umxr", value_type = 'real'}
UnitValueDB.MinimumAttackRange = {value_id = "uamn", value_type = 'int'}
UnitValueDB.ModelFile = {value_id = "umdl", value_type = 'string'}
UnitValueDB.ModelFileExtraVersions = {value_id = "uver", value_type = 'string'}
UnitValueDB.MovementHeight = {value_id = "umvh", value_type = 'real'}
UnitValueDB.MovementHeightMinimum = {value_id = "umvf", value_type = 'real'}
UnitValueDB.MovementSound = {value_id = "umsl", value_type = 'string'}
--- 'horse', 'fly', 'hover', 'float', 'amph'
UnitValueDB.MovementType = {value_id = "umvt", value_type = 'string'}
UnitValueDB.Name = {value_id = "unam", value_type = 'string'}
UnitValueDB.NameEditorSuffix = {value_id = "unsf", value_type = 'string'}
UnitValueDB.NormalAbilities = {value_id = "uabi", value_type = 'string'}
UnitValueDB.OccluderHeight = {value_id = "uocc", value_type = 'real'}
UnitValueDB.OrientationInterpolation = {value_id = "uori", value_type = 'int'}
UnitValueDB.PlaceableInEditor = {value_id = "uine", value_type = 'bool'}
UnitValueDB.PointValue = {value_id = "upoi", value_type = 'int'}
UnitValueDB.Priority = {value_id = "upri", value_type = 'int'}
UnitValueDB.ProjectileImpactZ = {value_id = "uimz", value_type = 'real'}
UnitValueDB.ProjectileImpactZSwimming = {value_id = "uisz", value_type = 'real'}
UnitValueDB.ProjectileLaunchX = {value_id = "ulpx", value_type = 'real'}
UnitValueDB.ProjectileLaunchY = {value_id = "ulpy", value_type = 'real'}
UnitValueDB.ProjectileLaunchZ = {value_id = "ulpz", value_type = 'real'}
UnitValueDB.ProjectileLaunchZSwimming = {value_id = "ulsz", value_type = 'real'}
UnitValueDB.PropulsionWindowdegrees = {value_id = "uprw", value_type = 'real'}
--- 'commoner', 'creeps', 'critters', 'demon', 'human', 'naga', 'nightelf', 'orc', 'other', 'undead', 'unknown'
UnitValueDB.Race = {value_id = "urac", value_type = 'string'}
UnitValueDB.RandomSound = {value_id = "ursl", value_type = 'string'}
UnitValueDB.RepairGoldCost = {value_id = "ugor", value_type = 'int'}
UnitValueDB.RepairLumberCost = {value_id = "ulur", value_type = 'int'}
UnitValueDB.RepairTime = {value_id = "urtm", value_type = 'int'}
UnitValueDB.RequiredAnimationNames = {value_id = "uani", value_type = 'string'}
UnitValueDB.RequiredAnimationNamesAttachments = {value_id = "uaap", value_type = 'string'}
UnitValueDB.RequiredAttachmentLinkNames = {value_id = "ualp", value_type = 'string'}
UnitValueDB.RequiredBoneNames = {value_id = "ubpr", value_type = 'string'}
UnitValueDB.Requirements = {value_id = "ureq", value_type = 'string'}
UnitValueDB.RequirementsLevels = {value_id = "urqa", value_type = 'string'}
UnitValueDB.ScaleProjectiles = {value_id = "uscb", value_type = 'bool'}
UnitValueDB.ModelScale = {value_id = "usca", value_type = 'real'}
UnitValueDB.SelectionCircleHeight = {value_id = "uslz", value_type = 'real'}
UnitValueDB.SelectionCircleOnWater = {value_id = "usew", value_type = 'bool'}
UnitValueDB.SelectionScale = {value_id = "ussc", value_type = 'real'}
UnitValueDB.ShadowImageCenterX = {value_id = "ushx", value_type = 'real'}
UnitValueDB.ShadowImageCenterY = {value_id = "ushy", value_type = 'real'}
UnitValueDB.ShadowImageHeight = {value_id = "ushh", value_type = 'real'}
UnitValueDB.ShadowImageUnit = {value_id = "ushu", value_type = 'string'}
UnitValueDB.ShadowImageWidth = {value_id = "ushw", value_type = 'real'}
UnitValueDB.ShadowTextureBuilding = {value_id = "ushb", value_type = 'string'}
UnitValueDB.SightRadiusDay = {value_id = "usid", value_type = 'int'}
UnitValueDB.SightRadiusNight = {value_id = "usin", value_type = 'int'}
UnitValueDB.Sleeps = {value_id = "usle", value_type = 'bool'}
UnitValueDB.SoundLoopingFadeInRate = {value_id = "ulfi", value_type = 'int'}
UnitValueDB.SoundLoopingFadeOutRate = {value_id = "ulfo", value_type = 'int'}
UnitValueDB.MovementSpeedBase = {value_id = "umvs", value_type = 'int'}
UnitValueDB.MovementSpeedMaximum = {value_id = "umas", value_type = 'int'}
UnitValueDB.MovementSpeedMinimum = {value_id = "umis", value_type = 'int'}
UnitValueDB.StockMaximum = {value_id = "usma", value_type = 'int'}
UnitValueDB.StockReplenishInterval = {value_id = "usrg", value_type = 'int'}
UnitValueDB.StockStartDelay = {value_id = "usst", value_type = 'int'}
UnitValueDB.TargetedAs = {value_id = "utar", value_type = 'string'}
UnitValueDB.TeamColor = {value_id = "utco", value_type = 'int'}
UnitValueDB.Tilesets = {value_id = "util", value_type = 'string'}
UnitValueDB.TintingColorBlue = {value_id = "uclb", value_type = 'int'}
UnitValueDB.TintingColorGreen = {value_id = "uclg", value_type = 'int'}
UnitValueDB.TintingColorRed = {value_id = "uclr", value_type = 'int'}
UnitValueDB.TooltipBasic = {value_id = "utip", value_type = 'string'}
UnitValueDB.TooltipExtended = {value_id = "utub", value_type = "string"}
UnitValueDB.TurnRate = {value_id = "umvr", value_type = 'real'}
UnitValueDB.UnitClassification = {value_id = "utyp", value_type = 'string'}
UnitValueDB.UnitSoundSet = {value_id = "usnd", value_type = 'string'}
UnitValueDB.UnitsSold = {value_id = "useu", value_type = 'string'}
UnitValueDB.UpgradesUsed = {value_id = "upgr", value_type = 'string'}
UnitValueDB.UseClickHelper = {value_id = "uuch", value_type = 'bool'}
UnitValueDB.UseExtendedLineofSight = {value_id = "ulos", value_type = 'bool'}

--=============
-- Hero fields
--=============
UnitValueDB.Hero_AgilityPerLevel = {value_id = "uagp", value_type = 'real'}
UnitValueDB.Hero_ConstructionSound = {value_id = "ubsl", value_type = 'string'}
UnitValueDB.Hero_FormationRank = {value_id = "ufor", value_type = 'int'}
UnitValueDB.Hero_GroundTexture = {value_id = "uubs", value_type = 'string'}
UnitValueDB.Hero_GroupSeparationEnabled = {value_id = "urpo", value_type = 'bool'}
UnitValueDB.Hero_GroupSeparationGroupNumber = {value_id = "urpg", value_type = 'int'}
UnitValueDB.Hero_GroupSeparationParameter = {value_id = "urpp", value_type = 'int'}
UnitValueDB.Hero_GroupSeparationPriority = {value_id = "urpr", value_type = 'int'}
UnitValueDB.Hero_HeroAbilities = {value_id = "uhab", value_type = 'string'}
UnitValueDB.Hero_HeroRevivalLocations = {value_id = "urva", value_type = 'string'}
UnitValueDB.Hero_HideHeroDeathMsg = {value_id = "uhhd", value_type = 'bool'}
UnitValueDB.Hero_HideHeroInterfaceIcon = {value_id = "uhhb", value_type = 'bool'}
UnitValueDB.Hero_HideHeroMinimapDisplay = {value_id = "uhhm", value_type = 'bool'}
UnitValueDB.Hero_IntelligencePerLevel = {value_id = "uinp", value_type = 'real'}
UnitValueDB.Hero_Level = {value_id = "ulev", value_type = 'int'}
UnitValueDB.Hero_PrimaryAttribute = {value_id = "upra", value_type = 'string'}
UnitValueDB.Hero_ProperNames = {value_id = "upro", value_type = 'string'}
UnitValueDB.Hero_ProperNamesUsed = {value_id = "upru", value_type = 'int'}
UnitValueDB.Hero_RequierementsForTier1 = {value_id = "urq0", value_type = 'string'}
UnitValueDB.Hero_RequierementsForTier2 = {value_id = "urq1", value_type = 'string'}
UnitValueDB.Hero_RequierementsForTier3 = {value_id = "urq2", value_type = 'string'}
UnitValueDB.Hero_RequierementsForTier4 = {value_id = "urq3", value_type = 'string'}
UnitValueDB.Hero_RequierementsForTier5 = {value_id = "urq4", value_type = 'string'}
UnitValueDB.Hero_RequierementsForTier6 = {value_id = "urq5", value_type = 'string'}
UnitValueDB.Hero_RequierementsForTier7 = {value_id = "urq6", value_type = 'string'}
UnitValueDB.Hero_RequierementsForTier8 = {value_id = "urq7", value_type = 'string'}
UnitValueDB.Hero_RequierementsForTier9 = {value_id = "urq8", value_type = 'string'}
UnitValueDB.Hero_StartingAgility = {value_id = "uagi", value_type = 'int'}
UnitValueDB.Hero_StartingIntelligence = {value_id = "uint", value_type = 'int'}
UnitValueDB.Hero_StartingStrength = {value_id = "ustr", value_type = 'int'}
UnitValueDB.Hero_StrengthPerLevel = {value_id = "ustp", value_type = 'real'}
UnitValueDB.Hero_StructuresBuilt = {value_id = "ubui", value_type = 'string'}
UnitValueDB.Hero_TooltipAwaken = {value_id = "uawt", value_type = 'string'}
UnitValueDB.Hero_TooltipRevive = {value_id = "utpr", value_type = 'string'}
UnitValueDB.Hero_TransportedSize = {value_id = "ucar", value_type = 'int'}

--=================
-- Building fields
--=================
UnitValueDB.AgilityPerLevel = {value_id = "uagp", value_type = 'real'}
UnitValueDB.ConstructionSound = {value_id = "ubsl", value_type = 'string'}
UnitValueDB.GroundTexture = {value_id = "uubs", value_type = 'string'}
UnitValueDB.ItemsMade = {value_id = "umki", value_type = 'string'}
UnitValueDB.NeutralBuildingShowsMinimapIcon = {value_id = "unbm", value_type = 'bool'}
UnitValueDB.NeutralBuildingValidAsRandomBuilding = {value_id = "unbr", value_type = 'bool'}
UnitValueDB.PathingMap = {value_id = "upat", value_type = 'string'}
UnitValueDB.PlacementPreventedBy = {value_id = "upar", value_type = 'string'}
UnitValueDB.PlacementRequires = {value_id = "upap", value_type = 'string'}
UnitValueDB.PlacementRequiresWaterRadius = {value_id = "upaw", value_type = 'real'}
UnitValueDB.ResearchesAvailable = {value_id = "ures", value_type = 'string'}
UnitValueDB.RevivesDeadHeros = {value_id = "urev", value_type = 'bool'}
UnitValueDB.UnitsTrained = {value_id = "utra", value_type = 'string'}
UnitValueDB.UpgradesTo = {value_id = "uupt", value_type = 'string'}

return UnitValueDB