---@class HeroCompiletimeData
local HeroCompiletimeData = {}
local HeroCompiletimeData_meta = {__index = HeroCompiletimeData}

---@alias HeroCompiletimeParameter string
---| '"Name"'
---| '"TooltipExtended"'
---| '"TooltipBasic"'
---| '"RequirementsLevels"'
---| '"Requirements"'
---| '"Hotkey"'
---| '"Description"'
---| '"ButtonPositionY"'
---| '"ButtonPositionX"'
---| '"ItemsSold"'
---| '"UnitsSold"'
---| '"HideMinimapDisplay"'
---| '"UseExtendedLineofSight"'
---| '"UseClickHelper"'
---| '"UpgradesUsed"'
---| '"UnitSoundSet"'
---| '"UnitClassification"'
---| '"MovementType"'
---| '"TurnRate"'
---| '"TintingColorBlue"'
---| '"TintingColorGreen"'
---| '"TintingColorRed"'
---| '"Tilesets"'
---| '"TeamColor"'
---| '"TargetedAs"'
---| '"ArtTarget"'
---| '"StockStartDelay"'
---| '"StockReplenishInterval"'
---| '"StockMaximum"'
---| '"SpeedMinimum"'
---| '"SpeedMaximum"'
---| '"SpeedBase"'
---| '"ArtSpecial"'
---| '"Sleeps"'
---| '"SightRadiusNight"'
---| '"SightRadiusDay"'
---| '"ShadowTextureBuilding"'
---| '"ShadowImageWidth"'
---| '"ShadowImageUnit"'
---| '"ShadowImageHeight"'
---| '"ShadowImageCenterY"'
---| '"ShadowImageCenterX"'
---| '"SelectionScale"'
---| '"SelectionCircleOnWater"'
---| '"SelectionCircleHeight"'
---| '"ScalingValue"'
---| '"ScaleProjectiles"'
---| '"RequiredBoneNames"'
---| '"RequiredAttachmentLinkNames"'
---| '"RequiredAnimationNamesAttachments"'
---| '"RequiredAnimationNames"'
---| '"RepairTime"'
---| '"RepairLumberCost"'
---| '"RepairGoldCost"'
---| '"RandomSound"'
---| '"Race"'
---| '"PropulsionWindowdegrees"'
---| '"ProjectileLaunchZSwimming"'
---| '"ProjectileLaunchZ"'
---| '"ProjectileLaunchY"'
---| '"ProjectileLaunchX"'
---| '"ProjectileImpactZSwimming"'
---| '"ProjectileImpactZ"'
---| '"Priority"'
---| '"PointValue"'
---| '"PlaceableInEditor"'
---| '"OrientationInterpolation"'
---| '"OccluderHeight"'
---| '"NormalAbilities"'
---| '"NameEditorSuffix"'
---| '"MovementSound"'
---| '"ModelFileExtraVersions"'
---| '"ModelFile"'
---| '"MinimumAttackRange"'
---| '"MaximumRollAngledegrees"'
---| '"MaximumPitchAngledegrees"'
---| '"ManaRegeneration"'
---| '"ManaMaximum"'
---| '"ManaInitialAmount"'
---| '"LumberCost"'
---| '"SoundLoopingFadeOutRate"'
---| '"SoundLoopingFadeInRate"'
---| '"IsaBuilding"'
---| '"IconScoreScreen"'
---| '"IconGameInterface"'
---| '"HitPointsRegenerationType"'
---| '"HitPointsRegenerationRate"'
---| '"HitPointsMaximumBase"'
---| '"MovementHeightMinimum"'
---| '"MovementHeight"'
---| '"HasWaterShadow"'
---| '"HasTilesetSpecificData"'
---| '"GoldCost"'
---| '"GoldBountyAwardedSidesperDie"'
---| '"GoldBountyAwardedbooleanofDice"'
---| '"GoldBountyAwardedBase"'
---| '"LumberBountyAwardedSidesperDie"'
---| '"LumberBountyAwardedbooleanofDice"'
---| '"LumberBountyAwardedBase"'
---| '"FoodProduced"'
---| '"FoodCost"'
---| '"FogOfWarSampleRadius"'
---| '"ElevationSampleRadius"'
---| '"ElevationSamplePoints"'
---| '"DisplayasNeutralHostile"'
---| '"DependencyEquivalents"'
---| '"DefenseUpgradeBonus"'
---| '"ArmorType"'
---| '"DefenseBase"'
---| '"DefaultActiveAbility"'
---| '"DeathType"'
---| '"DeathTimeseconds"'
---| '"CollisionSize"'
---| '"CategorizationSpecial"'
---| '"CategorizationCampaign"'
---| '"CanFlee"'
---| '"CanDropItemsOnDeath"'
---| '"BuildTime"'
---| '"AttacksEnabled"'
---| '"Attack2WeaponType"'
---| '"Attack2WeaponSound"'
---| '"Attack2TargetsAllowed"'
---| '"Attack2ShowUI"'
---| '"Attack2RangeMotionBuffer"'
---| '"Attack2Range"'
---| '"Attack2ProjectileSpeed"'
---| '"Attack2ProjectileHomingEnabled"'
---| '"Attack2ProjectileArt"'
---| '"Attack2ProjectileArc"'
---| '"Attack2MaximumbooleanofTargets"'
---| '"Attack2DamageUpgradeAmount"'
---| '"Attack2DamageSpillRadius"'
---| '"Attack2DamageSpillDistance"'
---| '"Attack2DamageSidesperDie"'
---| '"Attack2DamagebooleanofDice"'
---| '"Attack2DamageLossFactor"'
---| '"Attack2DamageFactorSmall"'
---| '"Attack2DamageFactorMedium"'
---| '"Attack2DamageBase"'
---| '"Attack2CooldownTime"'
---| '"Attack2AttackType"'
---| '"Attack2AreaofEffectTargets"'
---| '"Attack2AreaofEffectSmallDamage"'
---| '"Attack2AreaofEffectMediumDamage"'
---| '"Attack2AreaofEffectFullDamage"'
---| '"Attack2AnimationDamagePoint"'
---| '"Attack2AnimationBackswingPoint"'
---| '"Attack1WeaponType"'
---| '"Attack1WeaponSound"'
---| '"Attack1TargetsAllowed"'
---| '"Attack1ShowUI"'
---| '"Attack1RangeMotionBuffer"'
---| '"Attack1Range"'
---| '"Attack1ProjectileSpeed"'
---| '"Attack1ProjectileHomingEnabled"'
---| '"Attack1ProjectileArt"'
---| '"Attack1ProjectileArc"'
---| '"Attack1MaximumbooleanofTargets"'
---| '"Attack1DamageUpgradeAmount"'
---| '"Attack1DamageSpillRadius"'
---| '"Attack1DamageSpillDistance"'
---| '"Attack1DamageSidesperDie"'
---| '"Attack1DamagebooleanofDice"'
---| '"Attack1DamageLossFactor"'
---| '"Attack1DamageFactorSmall"'
---| '"Attack1DamageFactorMedium"'
---| '"Attack1DamageBase"'
---| '"Attack1CooldownTime"'
---| '"Attack1AttackType"'
---| '"Attack1AreaofEffectTargets"'
---| '"Attack1AreaofEffectSmallDamage"'
---| '"Attack1AreaofEffectMediumDamage"'
---| '"Attack1AreaofEffectFullDamage"'
---| '"Attack1AnimationDamagePoint"'
---| '"Attack1AnimationBackswingPoint"'
---| '"ArmorSoundType"'
---| '"AnimationWalkSpeed"'
---| '"AnimationRunSpeed"'
---| '"AnimationCastPoint"'
---| '"AnimationCastBackswing"'
---| '"AnimationBlendTimeseconds"'
---| '"AllowCustomTeamColor"'
---| '"AIPlacementType"'
---| '"AIPlacementRadius"'
---| '"TransportedSize"'
---| '"Level"'
---| '"GroupSeparationPriority"'
---| '"GroupSeparationParameter"'
---| '"GroupSeparationGroupNumber"'
---| '"GroupSeparationEnabled"'
---| '"FormationRank"'
---| '"StructuresBuilt"'
---| '"HideHeroDeathMsg"'
---| '"HideHeroInterfaceIcon"'
---| '"HideHeroMinimapDisplay"'
---| '"TooltipRevive"'
---| '"TooltipAwaken"'
---| '"StrengthPerLevel"'
---| '"StartingStrength"'
---| '"StartingIntelligence"'
---| '"StartingAgility"'
---| '"ProperNamesUsed"'
---| '"ProperNames"'
---| '"PrimaryAttribute"'
---| '"IntelligencePerLevel"'
---| '"HeroRevivalLocations"'
---| '"HeroAbilities"'
---| '"AgilityPerLevel"'
---| '"RequierementsForTier1"'
---| '"RequierementsForTier2"'
---| '"RequierementsForTier3"'
---| '"RequierementsForTier4"'
---| '"RequierementsForTier5"'
---| '"RequierementsForTier6"'
---| '"RequierementsForTier7"'
---| '"RequierementsForTier8"'
---| '"RequierementsForTier9"'
---| '"UpgradesTo"'
---| '"UnitsTrained"'
---| '"RevivesDeadHeros"'
---| '"ResearchesAvailable"'
---| '"PlacementRequiresWaterRadius"'
---| '"PlacementRequires"'
---| '"PlacementPreventedBy"'
---| '"PathingMap"'
---| '"NeutralBuildingValidAsRandomBuilding"'
---| '"NeutralBuildingShowsMinimapIcon"'
---| '"ItemsMade"'
---| '"GroundTexture"'
---| '"ConstructionSound"'
---| '"TooltipRevive"'
---| '"TooltipAwaken"'
---| '"StrengthPerLevel"'
---| '"StartingStrength"'
---| '"StartingIntelligence"'
---| '"StartingAgility"'
---| '"ProperNamesUsed"'
---| '"ProperNames"'
---| '"PrimaryAttribute"'
---| '"IntelligencePerLevel"'
---| '"HeroRevivalLocations"'
---| '"HeroAbilities"'
---| '"AgilityPerLevel"'

---@return HeroCompiletimeData
function HeroCompiletimeData.new()
    ---@type HeroCompiletimeData
    local data = {}
    setmetatable(data, HeroCompiletimeData_meta)
    return data
end

---@param name HeroCompiletimeParameter
---@param value any
function HeroCompiletimeData:setField(name, value)
    self[name] = value
end

---@param name ChannelParameter
---@return any
function HeroCompiletimeData:getField(name)
    return self[name]
end

---@param base_id string|integer
---@return integer
function HeroCompiletimeData:generate(base_id)
    local WeObjEdit = require('compiletime.objEdit.objEdit')

    self["Id"] = WeObjEdit.Utils.nextHeroId()
    local hero = WeObjEdit.Unit.Hero.new(self["Id"], ID2str(ID(base_id)))

    if self["Name"] then hero:setName(self["Name"]) end
    if self["TooltipExtended"] then hero:setTooltipExtended(self["TooltipExtended"]) end
    if self["TooltipBasic"] then hero:setTooltipBasic(self["TooltipBasic"]) end
    if self["RequirementsLevels"] then hero:setRequirementsLevels(self["RequirementsLevels"]) end
    if self["Requirements"] then hero:setRequirements(self["Requirements"]) end
    if self["Hotkey"] then hero:setHotkey(self["Hotkey"]) end
    if self["Description"] then hero:setDescription(self["Description"]) end
    if self["ButtonPositionY"] then hero:setButtonPositionY(self["ButtonPositionY"]) end
    if self["ButtonPositionX"] then hero:setButtonPositionX(self["ButtonPositionX"]) end
    if self["ItemsSold"] then hero:setItemsSold(self["ItemsSold"]) end
    if self["UnitsSold"] then hero:setUnitsSold(self["UnitsSold"]) end
    if self["HideMinimapDisplay"] then hero:setHideMinimapDisplay(self["HideMinimapDisplay"]) end
    if self["UseExtendedLineofSight"] then hero:setUseExtendedLineofSight(self["UseExtendedLineofSight"]) end
    if self["UseClickHelper"] then hero:setUseClickHelper(self["UseClickHelper"]) end
    if self["UpgradesUsed"] then hero:setUpgradesUsed(self["UpgradesUsed"]) end
    if self["UnitSoundSet"] then hero:setUnitSoundSet(self["UnitSoundSet"]) end
    if self["UnitClassification"] then hero:setUnitClassification(self["UnitClassification"]) end
    if self["MovementType"] then hero:setMovementType(self["MovementType"]) end
    if self["TurnRate"] then hero:setTurnRate(self["TurnRate"]) end
    if self["TintingColorBlue"] then hero:setTintingColorBlue(self["TintingColorBlue"]) end
    if self["TintingColorGreen"] then hero:setTintingColorGreen(self["TintingColorGreen"]) end
    if self["TintingColorRed"] then hero:setTintingColorRed(self["TintingColorRed"]) end
    if self["Tilesets"] then hero:setTilesets(self["Tilesets"]) end
    if self["TeamColor"] then hero:setTeamColor(self["TeamColor"]) end
    if self["TargetedAs"] then hero:setTargetedAs(self["TargetedAs"]) end
    if self["ArtTarget"] then hero:setArtTarget(self["ArtTarget"]) end
    if self["StockStartDelay"] then hero:setStockStartDelay(self["StockStartDelay"]) end
    if self["StockReplenishInterval"] then hero:setStockReplenishInterval(self["StockReplenishInterval"]) end
    if self["StockMaximum"] then hero:setStockMaximum(self["StockMaximum"]) end
    if self["SpeedMinimum"] then hero:setSpeedMinimum(self["SpeedMinimum"]) end
    if self["SpeedMaximum"] then hero:setSpeedMaximum(self["SpeedMaximum"]) end
    if self["SpeedBase"] then hero:setSpeedBase(self["SpeedBase"]) end
    if self["ArtSpecial"] then hero:setArtSpecial(self["ArtSpecial"]) end
    if self["Sleeps"] then hero:setSleeps(self["Sleeps"]) end
    if self["SightRadiusNight"] then hero:setSightRadiusNight(self["SightRadiusNight"]) end
    if self["SightRadiusDay"] then hero:setSightRadiusDay(self["SightRadiusDay"]) end
    if self["ShadowTextureBuilding"] then hero:setShadowTextureBuilding(self["ShadowTextureBuilding"]) end
    if self["ShadowImageWidth"] then hero:setShadowImageWidth(self["ShadowImageWidth"]) end
    if self["ShadowImageUnit"] then hero:setShadowImageUnit(self["ShadowImageUnit"]) end
    if self["ShadowImageHeight"] then hero:setShadowImageHeight(self["ShadowImageHeight"]) end
    if self["ShadowImageCenterY"] then hero:setShadowImageCenterY(self["ShadowImageCenterY"]) end
    if self["ShadowImageCenterX"] then hero:setShadowImageCenterX(self["ShadowImageCenterX"]) end
    if self["SelectionScale"] then hero:setSelectionScale(self["SelectionScale"]) end
    if self["SelectionCircleOnWater"] then hero:setSelectionCircleOnWater(self["SelectionCircleOnWater"]) end
    if self["SelectionCircleHeight"] then hero:setSelectionCircleHeight(self["SelectionCircleHeight"]) end
    if self["ScalingValue"] then hero:setScalingValue(self["ScalingValue"]) end
    if self["ScaleProjectiles"] then hero:setScaleProjectiles(self["ScaleProjectiles"]) end
    if self["RequiredBoneNames"] then hero:setRequiredBoneNames(self["RequiredBoneNames"]) end
    if self["RequiredAttachmentLinkNames"] then hero:setRequiredAttachmentLinkNames(self["RequiredAttachmentLinkNames"]) end
    if self["RequiredAnimationNamesAttachments"] then hero:setRequiredAnimationNamesAttachments(self["RequiredAnimationNamesAttachments"]) end
    if self["RequiredAnimationNames"] then hero:setRequiredAnimationNames(self["RequiredAnimationNames"]) end
    if self["RepairTime"] then hero:setRepairTime(self["RepairTime"]) end
    if self["RepairLumberCost"] then hero:setRepairLumberCost(self["RepairLumberCost"]) end
    if self["RepairGoldCost"] then hero:setRepairGoldCost(self["RepairGoldCost"]) end
    if self["RandomSound"] then hero:setRandomSound(self["RandomSound"]) end
    if self["Race"] then hero:setRace(self["Race"]) end
    if self["PropulsionWindowdegrees"] then hero:setPropulsionWindowdegrees(self["PropulsionWindowdegrees"]) end
    if self["ProjectileLaunchZSwimming"] then hero:setProjectileLaunchZSwimming(self["ProjectileLaunchZSwimming"]) end
    if self["ProjectileLaunchZ"] then hero:setProjectileLaunchZ(self["ProjectileLaunchZ"]) end
    if self["ProjectileLaunchY"] then hero:setProjectileLaunchY(self["ProjectileLaunchY"]) end
    if self["ProjectileLaunchX"] then hero:setProjectileLaunchX(self["ProjectileLaunchX"]) end
    if self["ProjectileImpactZSwimming"] then hero:setProjectileImpactZSwimming(self["ProjectileImpactZSwimming"]) end
    if self["ProjectileImpactZ"] then hero:setProjectileImpactZ(self["ProjectileImpactZ"]) end
    if self["Priority"] then hero:setPriority(self["Priority"]) end
    if self["PointValue"] then hero:setPointValue(self["PointValue"]) end
    if self["PlaceableInEditor"] then hero:setPlaceableInEditor(self["PlaceableInEditor"]) end
    if self["OrientationInterpolation"] then hero:setOrientationInterpolation(self["OrientationInterpolation"]) end
    if self["OccluderHeight"] then hero:setOccluderHeight(self["OccluderHeight"]) end
    if self["NormalAbilities"] then hero:setNormalAbilities(self["NormalAbilities"]) end
    if self["NameEditorSuffix"] then hero:setNameEditorSuffix(self["NameEditorSuffix"]) end
    if self["MovementSound"] then hero:setMovementSound(self["MovementSound"]) end
    if self["ModelFileExtraVersions"] then hero:setModelFileExtraVersions(self["ModelFileExtraVersions"]) end
    if self["ModelFile"] then hero:setModelFile(self["ModelFile"]) end
    if self["MinimumAttackRange"] then hero:setMinimumAttackRange(self["MinimumAttackRange"]) end
    if self["MaximumRollAngledegrees"] then hero:setMaximumRollAngledegrees(self["MaximumRollAngledegrees"]) end
    if self["MaximumPitchAngledegrees"] then hero:setMaximumPitchAngledegrees(self["MaximumPitchAngledegrees"]) end
    if self["ManaRegeneration"] then hero:setManaRegeneration(self["ManaRegeneration"]) end
    if self["ManaMaximum"] then hero:setManaMaximum(self["ManaMaximum"]) end
    if self["ManaInitialAmount"] then hero:setManaInitialAmount(self["ManaInitialAmount"]) end
    if self["LumberCost"] then hero:setLumberCost(self["LumberCost"]) end
    if self["SoundLoopingFadeOutRate"] then hero:setSoundLoopingFadeOutRate(self["SoundLoopingFadeOutRate"]) end
    if self["SoundLoopingFadeInRate"] then hero:setSoundLoopingFadeInRate(self["SoundLoopingFadeInRate"]) end
    if self["IsaBuilding"] then hero:setIsaBuilding(self["IsaBuilding"]) end
    if self["IconScoreScreen"] then hero:setIconScoreScreen(self["IconScoreScreen"]) end
    if self["IconGameInterface"] then hero:setIconGameInterface(self["IconGameInterface"]) end
    if self["HitPointsRegenerationType"] then hero:setHitPointsRegenerationType(self["HitPointsRegenerationType"]) end
    if self["HitPointsRegenerationRate"] then hero:setHitPointsRegenerationRate(self["HitPointsRegenerationRate"]) end
    if self["HitPointsMaximumBase"] then hero:setHitPointsMaximumBase(self["HitPointsMaximumBase"]) end
    if self["MovementHeightMinimum"] then hero:setMovementHeightMinimum(self["MovementHeightMinimum"]) end
    if self["MovementHeight"] then hero:setMovementHeight(self["MovementHeight"]) end
    if self["HasWaterShadow"] then hero:setHasWaterShadow(self["HasWaterShadow"]) end
    if self["HasTilesetSpecificData"] then hero:setHasTilesetSpecificData(self["HasTilesetSpecificData"]) end
    if self["GoldCost"] then hero:setGoldCost(self["GoldCost"]) end
    if self["GoldBountyAwardedSidesperDie"] then hero:setGoldBountyAwardedSidesperDie(self["GoldBountyAwardedSidesperDie"]) end
    if self["GoldBountyAwardedbooleanofDice"] then hero:setGoldBountyAwardedbooleanofDice(self["GoldBountyAwardedbooleanofDice"]) end
    if self["GoldBountyAwardedBase"] then hero:setGoldBountyAwardedBase(self["GoldBountyAwardedBase"]) end
    if self["LumberBountyAwardedSidesperDie"] then hero:setLumberBountyAwardedSidesperDie(self["LumberBountyAwardedSidesperDie"]) end
    if self["LumberBountyAwardedbooleanofDice"] then hero:setLumberBountyAwardedbooleanofDice(self["LumberBountyAwardedbooleanofDice"]) end
    if self["LumberBountyAwardedBase"] then hero:setLumberBountyAwardedBase(self["LumberBountyAwardedBase"]) end
    if self["FoodProduced"] then hero:setFoodProduced(self["FoodProduced"]) end
    if self["FoodCost"] then hero:setFoodCost(self["FoodCost"]) end
    if self["FogOfWarSampleRadius"] then hero:setFogOfWarSampleRadius(self["FogOfWarSampleRadius"]) end
    if self["ElevationSampleRadius"] then hero:setElevationSampleRadius(self["ElevationSampleRadius"]) end
    if self["ElevationSamplePoints"] then hero:setElevationSamplePoints(self["ElevationSamplePoints"]) end
    if self["DisplayasNeutralHostile"] then hero:setDisplayasNeutralHostile(self["DisplayasNeutralHostile"]) end
    if self["DependencyEquivalents"] then hero:setDependencyEquivalents(self["DependencyEquivalents"]) end
    if self["DefenseUpgradeBonus"] then hero:setDefenseUpgradeBonus(self["DefenseUpgradeBonus"]) end
    if self["ArmorType"] then hero:setArmorType(self["ArmorType"]) end
    if self["DefenseBase"] then hero:setDefenseBase(self["DefenseBase"]) end
    if self["DefaultActiveAbility"] then hero:setDefaultActiveAbility(self["DefaultActiveAbility"]) end
    if self["DeathType"] then hero:setDeathType(self["DeathType"]) end
    if self["DeathTimeseconds"] then hero:setDeathTimeseconds(self["DeathTimeseconds"]) end
    if self["CollisionSize"] then hero:setCollisionSize(self["CollisionSize"]) end
    if self["CategorizationSpecial"] then hero:setCategorizationSpecial(self["CategorizationSpecial"]) end
    if self["CategorizationCampaign"] then hero:setCategorizationCampaign(self["CategorizationCampaign"]) end
    if self["CanFlee"] then hero:setCanFlee(self["CanFlee"]) end
    if self["CanDropItemsOnDeath"] then hero:setCanDropItemsOnDeath(self["CanDropItemsOnDeath"]) end
    if self["BuildTime"] then hero:setBuildTime(self["BuildTime"]) end
    if self["AttacksEnabled"] then hero:setAttacksEnabled(self["AttacksEnabled"]) end
    if self["Attack2WeaponType"] then hero:setAttack2WeaponType(self["Attack2WeaponType"]) end
    if self["Attack2WeaponSound"] then hero:setAttack2WeaponSound(self["Attack2WeaponSound"]) end
    if self["Attack2TargetsAllowed"] then hero:setAttack2TargetsAllowed(self["Attack2TargetsAllowed"]) end
    if self["Attack2ShowUI"] then hero:setAttack2ShowUI(self["Attack2ShowUI"]) end
    if self["Attack2RangeMotionBuffer"] then hero:setAttack2RangeMotionBuffer(self["Attack2RangeMotionBuffer"]) end
    if self["Attack2Range"] then hero:setAttack2Range(self["Attack2Range"]) end
    if self["Attack2ProjectileSpeed"] then hero:setAttack2ProjectileSpeed(self["Attack2ProjectileSpeed"]) end
    if self["Attack2ProjectileHomingEnabled"] then hero:setAttack2ProjectileHomingEnabled(self["Attack2ProjectileHomingEnabled"]) end
    if self["Attack2ProjectileArt"] then hero:setAttack2ProjectileArt(self["Attack2ProjectileArt"]) end
    if self["Attack2ProjectileArc"] then hero:setAttack2ProjectileArc(self["Attack2ProjectileArc"]) end
    if self["Attack2MaximumbooleanofTargets"] then hero:setAttack2MaximumbooleanofTargets(self["Attack2MaximumbooleanofTargets"]) end
    if self["Attack2DamageUpgradeAmount"] then hero:setAttack2DamageUpgradeAmount(self["Attack2DamageUpgradeAmount"]) end
    if self["Attack2DamageSpillRadius"] then hero:setAttack2DamageSpillRadius(self["Attack2DamageSpillRadius"]) end
    if self["Attack2DamageSpillDistance"] then hero:setAttack2DamageSpillDistance(self["Attack2DamageSpillDistance"]) end
    if self["Attack2DamageSidesperDie"] then hero:setAttack2DamageSidesperDie(self["Attack2DamageSidesperDie"]) end
    if self["Attack2DamagebooleanofDice"] then hero:setAttack2DamagebooleanofDice(self["Attack2DamagebooleanofDice"]) end
    if self["Attack2DamageLossFactor"] then hero:setAttack2DamageLossFactor(self["Attack2DamageLossFactor"]) end
    if self["Attack2DamageFactorSmall"] then hero:setAttack2DamageFactorSmall(self["Attack2DamageFactorSmall"]) end
    if self["Attack2DamageFactorMedium"] then hero:setAttack2DamageFactorMedium(self["Attack2DamageFactorMedium"]) end
    if self["Attack2DamageBase"] then hero:setAttack2DamageBase(self["Attack2DamageBase"]) end
    if self["Attack2CooldownTime"] then hero:setAttack2CooldownTime(self["Attack2CooldownTime"]) end
    if self["Attack2AttackType"] then hero:setAttack2AttackType(self["Attack2AttackType"]) end
    if self["Attack2AreaofEffectTargets"] then hero:setAttack2AreaofEffectTargets(self["Attack2AreaofEffectTargets"]) end
    if self["Attack2AreaofEffectSmallDamage"] then hero:setAttack2AreaofEffectSmallDamage(self["Attack2AreaofEffectSmallDamage"]) end
    if self["Attack2AreaofEffectMediumDamage"] then hero:setAttack2AreaofEffectMediumDamage(self["Attack2AreaofEffectMediumDamage"]) end
    if self["Attack2AreaofEffectFullDamage"] then hero:setAttack2AreaofEffectFullDamage(self["Attack2AreaofEffectFullDamage"]) end
    if self["Attack2AnimationDamagePoint"] then hero:setAttack2AnimationDamagePoint(self["Attack2AnimationDamagePoint"]) end
    if self["Attack2AnimationBackswingPoint"] then hero:setAttack2AnimationBackswingPoint(self["Attack2AnimationBackswingPoint"]) end
    if self["Attack1WeaponType"] then hero:setAttack1WeaponType(self["Attack1WeaponType"]) end
    if self["Attack1WeaponSound"] then hero:setAttack1WeaponSound(self["Attack1WeaponSound"]) end
    if self["Attack1TargetsAllowed"] then hero:setAttack1TargetsAllowed(self["Attack1TargetsAllowed"]) end
    if self["Attack1ShowUI"] then hero:setAttack1ShowUI(self["Attack1ShowUI"]) end
    if self["Attack1RangeMotionBuffer"] then hero:setAttack1RangeMotionBuffer(self["Attack1RangeMotionBuffer"]) end
    if self["Attack1Range"] then hero:setAttack1Range(self["Attack1Range"]) end
    if self["Attack1ProjectileSpeed"] then hero:setAttack1ProjectileSpeed(self["Attack1ProjectileSpeed"]) end
    if self["Attack1ProjectileHomingEnabled"] then hero:setAttack1ProjectileHomingEnabled(self["Attack1ProjectileHomingEnabled"]) end
    if self["Attack1ProjectileArt"] then hero:setAttack1ProjectileArt(self["Attack1ProjectileArt"]) end
    if self["Attack1ProjectileArc"] then hero:setAttack1ProjectileArc(self["Attack1ProjectileArc"]) end
    if self["Attack1MaximumbooleanofTargets"] then hero:setAttack1MaximumbooleanofTargets(self["Attack1MaximumbooleanofTargets"]) end
    if self["Attack1DamageUpgradeAmount"] then hero:setAttack1DamageUpgradeAmount(self["Attack1DamageUpgradeAmount"]) end
    if self["Attack1DamageSpillRadius"] then hero:setAttack1DamageSpillRadius(self["Attack1DamageSpillRadius"]) end
    if self["Attack1DamageSpillDistance"] then hero:setAttack1DamageSpillDistance(self["Attack1DamageSpillDistance"]) end
    if self["Attack1DamageSidesperDie"] then hero:setAttack1DamageSidesperDie(self["Attack1DamageSidesperDie"]) end
    if self["Attack1DamagebooleanofDice"] then hero:setAttack1DamagebooleanofDice(self["Attack1DamagebooleanofDice"]) end
    if self["Attack1DamageLossFactor"] then hero:setAttack1DamageLossFactor(self["Attack1DamageLossFactor"]) end
    if self["Attack1DamageFactorSmall"] then hero:setAttack1DamageFactorSmall(self["Attack1DamageFactorSmall"]) end
    if self["Attack1DamageFactorMedium"] then hero:setAttack1DamageFactorMedium(self["Attack1DamageFactorMedium"]) end
    if self["Attack1DamageBase"] then hero:setAttack1DamageBase(self["Attack1DamageBase"]) end
    if self["Attack1CooldownTime"] then hero:setAttack1CooldownTime(self["Attack1CooldownTime"]) end
    if self["Attack1AttackType"] then hero:setAttack1AttackType(self["Attack1AttackType"]) end
    if self["Attack1AreaofEffectTargets"] then hero:setAttack1AreaofEffectTargets(self["Attack1AreaofEffectTargets"]) end
    if self["Attack1AreaofEffectSmallDamage"] then hero:setAttack1AreaofEffectSmallDamage(self["Attack1AreaofEffectSmallDamage"]) end
    if self["Attack1AreaofEffectMediumDamage"] then hero:setAttack1AreaofEffectMediumDamage(self["Attack1AreaofEffectMediumDamage"]) end
    if self["Attack1AreaofEffectFullDamage"] then hero:setAttack1AreaofEffectFullDamage(self["Attack1AreaofEffectFullDamage"]) end
    if self["Attack1AnimationDamagePoint"] then hero:setAttack1AnimationDamagePoint(self["Attack1AnimationDamagePoint"]) end
    if self["Attack1AnimationBackswingPoint"] then hero:setAttack1AnimationBackswingPoint(self["Attack1AnimationBackswingPoint"]) end
    if self["ArmorSoundType"] then hero:setArmorSoundType(self["ArmorSoundType"]) end
    if self["AnimationWalkSpeed"] then hero:setAnimationWalkSpeed(self["AnimationWalkSpeed"]) end
    if self["AnimationRunSpeed"] then hero:setAnimationRunSpeed(self["AnimationRunSpeed"]) end
    if self["AnimationCastPoint"] then hero:setAnimationCastPoint(self["AnimationCastPoint"]) end
    if self["AnimationCastBackswing"] then hero:setAnimationCastBackswing(self["AnimationCastBackswing"]) end
    if self["AnimationBlendTimeseconds"] then hero:setAnimationBlendTimeseconds(self["AnimationBlendTimeseconds"]) end
    if self["AllowCustomTeamColor"] then hero:setAllowCustomTeamColor(self["AllowCustomTeamColor"]) end
    if self["AIPlacementType"] then hero:setAIPlacementType(self["AIPlacementType"]) end
    if self["AIPlacementRadius"] then hero:setAIPlacementRadius(self["AIPlacementRadius"]) end
    if self["TransportedSize"] then hero:setTransportedSize(self["TransportedSize"]) end
    if self["Level"] then hero:setLevel(self["Level"]) end
    if self["GroupSeparationPriority"] then hero:setGroupSeparationPriority(self["GroupSeparationPriority"]) end
    if self["GroupSeparationParameter"] then hero:setGroupSeparationParameter(self["GroupSeparationParameter"]) end
    if self["GroupSeparationGroupNumber"] then hero:setGroupSeparationGroupNumber(self["GroupSeparationGroupNumber"]) end
    if self["GroupSeparationEnabled"] then hero:setGroupSeparationEnabled(self["GroupSeparationEnabled"]) end
    if self["FormationRank"] then hero:setFormationRank(self["FormationRank"]) end
    if self["StructuresBuilt"] then hero:setStructuresBuilt(self["StructuresBuilt"]) end
    if self["HideHeroDeathMsg"] then hero:setHideHeroDeathMsg(self["HideHeroDeathMsg"]) end
    if self["HideHeroInterfaceIcon"] then hero:setHideHeroInterfaceIcon(self["HideHeroInterfaceIcon"]) end
    if self["HideHeroMinimapDisplay"] then hero:setHideHeroMinimapDisplay(self["HideHeroMinimapDisplay"]) end
    if self["TooltipRevive"] then hero:setTooltipRevive(self["TooltipRevive"]) end
    if self["TooltipAwaken"] then hero:setTooltipAwaken(self["TooltipAwaken"]) end
    if self["StrengthPerLevel"] then hero:setStrengthPerLevel(self["StrengthPerLevel"]) end
    if self["StartingStrength"] then hero:setStartingStrength(self["StartingStrength"]) end
    if self["StartingIntelligence"] then hero:setStartingIntelligence(self["StartingIntelligence"]) end
    if self["StartingAgility"] then hero:setStartingAgility(self["StartingAgility"]) end
    if self["ProperNamesUsed"] then hero:setProperNamesUsed(self["ProperNamesUsed"]) end
    if self["ProperNames"] then hero:setProperNames(self["ProperNames"]) end
    if self["PrimaryAttribute"] then hero:setPrimaryAttribute(self["PrimaryAttribute"]) end
    if self["IntelligencePerLevel"] then hero:setIntelligencePerLevel(self["IntelligencePerLevel"]) end
    if self["HeroRevivalLocations"] then hero:setHeroRevivalLocations(self["HeroRevivalLocations"]) end
    if self["HeroAbilities"] then hero:setHeroAbilities(self["HeroAbilities"]) end
    if self["AgilityPerLevel"] then hero:setAgilityPerLevel(self["AgilityPerLevel"]) end
    if self["RequierementsForTier1"] then hero:setRequierementsForTier1(self["RequierementsForTier1"]) end
    if self["RequierementsForTier2"] then hero:setRequierementsForTier2(self["RequierementsForTier2"]) end
    if self["RequierementsForTier3"] then hero:setRequierementsForTier3(self["RequierementsForTier3"]) end
    if self["RequierementsForTier4"] then hero:setRequierementsForTier4(self["RequierementsForTier4"]) end
    if self["RequierementsForTier5"] then hero:setRequierementsForTier5(self["RequierementsForTier5"]) end
    if self["RequierementsForTier6"] then hero:setRequierementsForTier6(self["RequierementsForTier6"]) end
    if self["RequierementsForTier7"] then hero:setRequierementsForTier7(self["RequierementsForTier7"]) end
    if self["RequierementsForTier8"] then hero:setRequierementsForTier8(self["RequierementsForTier8"]) end
    if self["RequierementsForTier9"] then hero:setRequierementsForTier9(self["RequierementsForTier9"]) end
    if self["UpgradesTo"] then hero:setUpgradesTo(self["UpgradesTo"]) end
    if self["UnitsTrained"] then hero:setUnitsTrained(self["UnitsTrained"]) end
    if self["RevivesDeadHeros"] then hero:setRevivesDeadHeros(self["RevivesDeadHeros"]) end
    if self["ResearchesAvailable"] then hero:setResearchesAvailable(self["ResearchesAvailable"]) end
    if self["PlacementRequiresWaterRadius"] then hero:setPlacementRequiresWaterRadius(self["PlacementRequiresWaterRadius"]) end
    if self["PlacementRequires"] then hero:setPlacementRequires(self["PlacementRequires"]) end
    if self["PlacementPreventedBy"] then hero:setPlacementPreventedBy(self["PlacementPreventedBy"]) end
    if self["PathingMap"] then hero:setPathingMap(self["PathingMap"]) end
    if self["NeutralBuildingValidAsRandomBuilding"] then hero:setNeutralBuildingValidAsRandomBuilding(self["NeutralBuildingValidAsRandomBuilding"]) end
    if self["NeutralBuildingShowsMinimapIcon"] then hero:setNeutralBuildingShowsMinimapIcon(self["NeutralBuildingShowsMinimapIcon"]) end
    if self["ItemsMade"] then hero:setItemsMade(self["ItemsMade"]) end
    if self["GroundTexture"] then hero:setGroundTexture(self["GroundTexture"]) end
    if self["ConstructionSound"] then hero:setConstructionSound(self["ConstructionSound"]) end
    if self["TooltipRevive"] then hero:setTooltipRevive(self["TooltipRevive"]) end
    if self["TooltipAwaken"] then hero:setTooltipAwaken(self["TooltipAwaken"]) end
    if self["StrengthPerLevel"] then hero:setStrengthPerLevel(self["StrengthPerLevel"]) end
    if self["StartingStrength"] then hero:setStartingStrength(self["StartingStrength"]) end
    if self["StartingIntelligence"] then hero:setStartingIntelligence(self["StartingIntelligence"]) end
    if self["StartingAgility"] then hero:setStartingAgility(self["StartingAgility"]) end
    if self["ProperNamesUsed"] then hero:setProperNamesUsed(self["ProperNamesUsed"]) end
    if self["ProperNames"] then hero:setProperNames(self["ProperNames"]) end
    if self["PrimaryAttribute"] then hero:setPrimaryAttribute(self["PrimaryAttribute"]) end
    if self["IntelligencePerLevel"] then hero:setIntelligencePerLevel(self["IntelligencePerLevel"]) end
    if self["HeroRevivalLocations"] then hero:setHeroRevivalLocations(self["HeroRevivalLocations"]) end
    if self["HeroAbilities"] then hero:setHeroAbilities(self["HeroAbilities"]) end
    if self["AgilityPerLevel"] then hero:setAgilityPerLevel(self["AgilityPerLevel"]) end

end

return HeroCompiletimeData