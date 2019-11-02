---@class UnitCompiletimeData
local UnitCompiletimeData = {}
local UnitCompiletimeData_meta = {__index = UnitCompiletimeData}

---@alias UnitCompiletimeParameter string
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
---| '"CasterUpgradeTips"'
---| '"CasterUpgradeNames"'
---| '"CasterUpgradeArt"'

---@return HeroCompiletimeData
function UnitCompiletimeData.new()
    ---@type HeroCompiletimeData
    local data = {}
    setmetatable(data, UnitCompiletimeData_meta)
    return data
end

---@param name UnitCompiletimeParameter
---@param value any
function UnitCompiletimeData:setField(name, value)
    self[name] = value
end

---@param name UnitCompiletimeParameter
---@return any
function UnitCompiletimeData:getField(name)
    return self[name]
end

---@param base_id string|integer
---@return integer
function UnitCompiletimeData:generate(base_id)
    local WeObjEdit = require('compiletime.objEdit.objEdit')

    self["Id"] = WeObjEdit.Utils.nextUnitId()
    local unit = WeObjEdit.Unit.Unit.new(self["Id"], ID2str(base_id))

    if self["Name"] then unit:setName(self["Name"]) end
    if self["TooltipExtended"] then unit:setTooltipExtended(self["TooltipExtended"]) end
    if self["TooltipBasic"] then unit:setTooltipBasic(self["TooltipBasic"]) end
    if self["RequirementsLevels"] then unit:setRequirementsLevels(self["RequirementsLevels"]) end
    if self["Requirements"] then unit:setRequirements(self["Requirements"]) end
    if self["Hotkey"] then unit:setHotkey(self["Hotkey"]) end
    if self["Description"] then unit:setDescription(self["Description"]) end
    if self["ButtonPositionY"] then unit:setButtonPositionY(self["ButtonPositionY"]) end
    if self["ButtonPositionX"] then unit:setButtonPositionX(self["ButtonPositionX"]) end
    if self["ItemsSold"] then unit:setItemsSold(self["ItemsSold"]) end
    if self["UnitsSold"] then unit:setUnitsSold(self["UnitsSold"]) end
    if self["HideMinimapDisplay"] then unit:setHideMinimapDisplay(self["HideMinimapDisplay"]) end
    if self["UseExtendedLineofSight"] then unit:setUseExtendedLineofSight(self["UseExtendedLineofSight"]) end
    if self["UseClickHelper"] then unit:setUseClickHelper(self["UseClickHelper"]) end
    if self["UpgradesUsed"] then unit:setUpgradesUsed(self["UpgradesUsed"]) end
    if self["UnitSoundSet"] then unit:setUnitSoundSet(self["UnitSoundSet"]) end
    if self["UnitClassification"] then unit:setUnitClassification(self["UnitClassification"]) end
    if self["MovementType"] then unit:setMovementType(self["MovementType"]) end
    if self["TurnRate"] then unit:setTurnRate(self["TurnRate"]) end
    if self["TintingColorBlue"] then unit:setTintingColorBlue(self["TintingColorBlue"]) end
    if self["TintingColorGreen"] then unit:setTintingColorGreen(self["TintingColorGreen"]) end
    if self["TintingColorRed"] then unit:setTintingColorRed(self["TintingColorRed"]) end
    if self["Tilesets"] then unit:setTilesets(self["Tilesets"]) end
    if self["TeamColor"] then unit:setTeamColor(self["TeamColor"]) end
    if self["TargetedAs"] then unit:setTargetedAs(self["TargetedAs"]) end
    if self["ArtTarget"] then unit:setArtTarget(self["ArtTarget"]) end
    if self["StockStartDelay"] then unit:setStockStartDelay(self["StockStartDelay"]) end
    if self["StockReplenishInterval"] then unit:setStockReplenishInterval(self["StockReplenishInterval"]) end
    if self["StockMaximum"] then unit:setStockMaximum(self["StockMaximum"]) end
    if self["SpeedMinimum"] then unit:setSpeedMinimum(self["SpeedMinimum"]) end
    if self["SpeedMaximum"] then unit:setSpeedMaximum(self["SpeedMaximum"]) end
    if self["SpeedBase"] then unit:setSpeedBase(self["SpeedBase"]) end
    if self["ArtSpecial"] then unit:setArtSpecial(self["ArtSpecial"]) end
    if self["Sleeps"] then unit:setSleeps(self["Sleeps"]) end
    if self["SightRadiusNight"] then unit:setSightRadiusNight(self["SightRadiusNight"]) end
    if self["SightRadiusDay"] then unit:setSightRadiusDay(self["SightRadiusDay"]) end
    if self["ShadowTextureBuilding"] then unit:setShadowTextureBuilding(self["ShadowTextureBuilding"]) end
    if self["ShadowImageWidth"] then unit:setShadowImageWidth(self["ShadowImageWidth"]) end
    if self["ShadowImageUnit"] then unit:setShadowImageUnit(self["ShadowImageUnit"]) end
    if self["ShadowImageHeight"] then unit:setShadowImageHeight(self["ShadowImageHeight"]) end
    if self["ShadowImageCenterY"] then unit:setShadowImageCenterY(self["ShadowImageCenterY"]) end
    if self["ShadowImageCenterX"] then unit:setShadowImageCenterX(self["ShadowImageCenterX"]) end
    if self["SelectionScale"] then unit:setSelectionScale(self["SelectionScale"]) end
    if self["SelectionCircleOnWater"] then unit:setSelectionCircleOnWater(self["SelectionCircleOnWater"]) end
    if self["SelectionCircleHeight"] then unit:setSelectionCircleHeight(self["SelectionCircleHeight"]) end
    if self["ScalingValue"] then unit:setScalingValue(self["ScalingValue"]) end
    if self["ScaleProjectiles"] then unit:setScaleProjectiles(self["ScaleProjectiles"]) end
    if self["RequiredBoneNames"] then unit:setRequiredBoneNames(self["RequiredBoneNames"]) end
    if self["RequiredAttachmentLinkNames"] then unit:setRequiredAttachmentLinkNames(self["RequiredAttachmentLinkNames"]) end
    if self["RequiredAnimationNamesAttachments"] then unit:setRequiredAnimationNamesAttachments(self["RequiredAnimationNamesAttachments"]) end
    if self["RequiredAnimationNames"] then unit:setRequiredAnimationNames(self["RequiredAnimationNames"]) end
    if self["RepairTime"] then unit:setRepairTime(self["RepairTime"]) end
    if self["RepairLumberCost"] then unit:setRepairLumberCost(self["RepairLumberCost"]) end
    if self["RepairGoldCost"] then unit:setRepairGoldCost(self["RepairGoldCost"]) end
    if self["RandomSound"] then unit:setRandomSound(self["RandomSound"]) end
    if self["Race"] then unit:setRace(self["Race"]) end
    if self["PropulsionWindowdegrees"] then unit:setPropulsionWindowdegrees(self["PropulsionWindowdegrees"]) end
    if self["ProjectileLaunchZSwimming"] then unit:setProjectileLaunchZSwimming(self["ProjectileLaunchZSwimming"]) end
    if self["ProjectileLaunchZ"] then unit:setProjectileLaunchZ(self["ProjectileLaunchZ"]) end
    if self["ProjectileLaunchY"] then unit:setProjectileLaunchY(self["ProjectileLaunchY"]) end
    if self["ProjectileLaunchX"] then unit:setProjectileLaunchX(self["ProjectileLaunchX"]) end
    if self["ProjectileImpactZSwimming"] then unit:setProjectileImpactZSwimming(self["ProjectileImpactZSwimming"]) end
    if self["ProjectileImpactZ"] then unit:setProjectileImpactZ(self["ProjectileImpactZ"]) end
    if self["Priority"] then unit:setPriority(self["Priority"]) end
    if self["PointValue"] then unit:setPointValue(self["PointValue"]) end
    if self["PlaceableInEditor"] then unit:setPlaceableInEditor(self["PlaceableInEditor"]) end
    if self["OrientationInterpolation"] then unit:setOrientationInterpolation(self["OrientationInterpolation"]) end
    if self["OccluderHeight"] then unit:setOccluderHeight(self["OccluderHeight"]) end
    if self["NormalAbilities"] then unit:setNormalAbilities(self["NormalAbilities"]) end
    if self["NameEditorSuffix"] then unit:setNameEditorSuffix(self["NameEditorSuffix"]) end
    if self["MovementSound"] then unit:setMovementSound(self["MovementSound"]) end
    if self["ModelFileExtraVersions"] then unit:setModelFileExtraVersions(self["ModelFileExtraVersions"]) end
    if self["ModelFile"] then unit:setModelFile(self["ModelFile"]) end
    if self["MinimumAttackRange"] then unit:setMinimumAttackRange(self["MinimumAttackRange"]) end
    if self["MaximumRollAngledegrees"] then unit:setMaximumRollAngledegrees(self["MaximumRollAngledegrees"]) end
    if self["MaximumPitchAngledegrees"] then unit:setMaximumPitchAngledegrees(self["MaximumPitchAngledegrees"]) end
    if self["ManaRegeneration"] then unit:setManaRegeneration(self["ManaRegeneration"]) end
    if self["ManaMaximum"] then unit:setManaMaximum(self["ManaMaximum"]) end
    if self["ManaInitialAmount"] then unit:setManaInitialAmount(self["ManaInitialAmount"]) end
    if self["LumberCost"] then unit:setLumberCost(self["LumberCost"]) end
    if self["SoundLoopingFadeOutRate"] then unit:setSoundLoopingFadeOutRate(self["SoundLoopingFadeOutRate"]) end
    if self["SoundLoopingFadeInRate"] then unit:setSoundLoopingFadeInRate(self["SoundLoopingFadeInRate"]) end
    if self["IsaBuilding"] then unit:setIsaBuilding(self["IsaBuilding"]) end
    if self["IconScoreScreen"] then unit:setIconScoreScreen(self["IconScoreScreen"]) end
    if self["IconGameInterface"] then unit:setIconGameInterface(self["IconGameInterface"]) end
    if self["HitPointsRegenerationType"] then unit:setHitPointsRegenerationType(self["HitPointsRegenerationType"]) end
    if self["HitPointsRegenerationRate"] then unit:setHitPointsRegenerationRate(self["HitPointsRegenerationRate"]) end
    if self["HitPointsMaximumBase"] then unit:setHitPointsMaximumBase(self["HitPointsMaximumBase"]) end
    if self["MovementHeightMinimum"] then unit:setMovementHeightMinimum(self["MovementHeightMinimum"]) end
    if self["MovementHeight"] then unit:setMovementHeight(self["MovementHeight"]) end
    if self["HasWaterShadow"] then unit:setHasWaterShadow(self["HasWaterShadow"]) end
    if self["HasTilesetSpecificData"] then unit:setHasTilesetSpecificData(self["HasTilesetSpecificData"]) end
    if self["GoldCost"] then unit:setGoldCost(self["GoldCost"]) end
    if self["GoldBountyAwardedSidesperDie"] then unit:setGoldBountyAwardedSidesperDie(self["GoldBountyAwardedSidesperDie"]) end
    if self["GoldBountyAwardedbooleanofDice"] then unit:setGoldBountyAwardedbooleanofDice(self["GoldBountyAwardedbooleanofDice"]) end
    if self["GoldBountyAwardedBase"] then unit:setGoldBountyAwardedBase(self["GoldBountyAwardedBase"]) end
    if self["LumberBountyAwardedSidesperDie"] then unit:setLumberBountyAwardedSidesperDie(self["LumberBountyAwardedSidesperDie"]) end
    if self["LumberBountyAwardedbooleanofDice"] then unit:setLumberBountyAwardedbooleanofDice(self["LumberBountyAwardedbooleanofDice"]) end
    if self["LumberBountyAwardedBase"] then unit:setLumberBountyAwardedBase(self["LumberBountyAwardedBase"]) end
    if self["FoodProduced"] then unit:setFoodProduced(self["FoodProduced"]) end
    if self["FoodCost"] then unit:setFoodCost(self["FoodCost"]) end
    if self["FogOfWarSampleRadius"] then unit:setFogOfWarSampleRadius(self["FogOfWarSampleRadius"]) end
    if self["ElevationSampleRadius"] then unit:setElevationSampleRadius(self["ElevationSampleRadius"]) end
    if self["ElevationSamplePoints"] then unit:setElevationSamplePoints(self["ElevationSamplePoints"]) end
    if self["DisplayasNeutralHostile"] then unit:setDisplayasNeutralHostile(self["DisplayasNeutralHostile"]) end
    if self["DependencyEquivalents"] then unit:setDependencyEquivalents(self["DependencyEquivalents"]) end
    if self["DefenseUpgradeBonus"] then unit:setDefenseUpgradeBonus(self["DefenseUpgradeBonus"]) end
    if self["ArmorType"] then unit:setArmorType(self["ArmorType"]) end
    if self["DefenseBase"] then unit:setDefenseBase(self["DefenseBase"]) end
    if self["DefaultActiveAbility"] then unit:setDefaultActiveAbility(self["DefaultActiveAbility"]) end
    if self["DeathType"] then unit:setDeathType(self["DeathType"]) end
    if self["DeathTimeseconds"] then unit:setDeathTimeseconds(self["DeathTimeseconds"]) end
    if self["CollisionSize"] then unit:setCollisionSize(self["CollisionSize"]) end
    if self["CategorizationSpecial"] then unit:setCategorizationSpecial(self["CategorizationSpecial"]) end
    if self["CategorizationCampaign"] then unit:setCategorizationCampaign(self["CategorizationCampaign"]) end
    if self["CanFlee"] then unit:setCanFlee(self["CanFlee"]) end
    if self["CanDropItemsOnDeath"] then unit:setCanDropItemsOnDeath(self["CanDropItemsOnDeath"]) end
    if self["BuildTime"] then unit:setBuildTime(self["BuildTime"]) end
    if self["AttacksEnabled"] then unit:setAttacksEnabled(self["AttacksEnabled"]) end
    if self["Attack2WeaponType"] then unit:setAttack2WeaponType(self["Attack2WeaponType"]) end
    if self["Attack2WeaponSound"] then unit:setAttack2WeaponSound(self["Attack2WeaponSound"]) end
    if self["Attack2TargetsAllowed"] then unit:setAttack2TargetsAllowed(self["Attack2TargetsAllowed"]) end
    if self["Attack2ShowUI"] then unit:setAttack2ShowUI(self["Attack2ShowUI"]) end
    if self["Attack2RangeMotionBuffer"] then unit:setAttack2RangeMotionBuffer(self["Attack2RangeMotionBuffer"]) end
    if self["Attack2Range"] then unit:setAttack2Range(self["Attack2Range"]) end
    if self["Attack2ProjectileSpeed"] then unit:setAttack2ProjectileSpeed(self["Attack2ProjectileSpeed"]) end
    if self["Attack2ProjectileHomingEnabled"] then unit:setAttack2ProjectileHomingEnabled(self["Attack2ProjectileHomingEnabled"]) end
    if self["Attack2ProjectileArt"] then unit:setAttack2ProjectileArt(self["Attack2ProjectileArt"]) end
    if self["Attack2ProjectileArc"] then unit:setAttack2ProjectileArc(self["Attack2ProjectileArc"]) end
    if self["Attack2MaximumbooleanofTargets"] then unit:setAttack2MaximumbooleanofTargets(self["Attack2MaximumbooleanofTargets"]) end
    if self["Attack2DamageUpgradeAmount"] then unit:setAttack2DamageUpgradeAmount(self["Attack2DamageUpgradeAmount"]) end
    if self["Attack2DamageSpillRadius"] then unit:setAttack2DamageSpillRadius(self["Attack2DamageSpillRadius"]) end
    if self["Attack2DamageSpillDistance"] then unit:setAttack2DamageSpillDistance(self["Attack2DamageSpillDistance"]) end
    if self["Attack2DamageSidesperDie"] then unit:setAttack2DamageSidesperDie(self["Attack2DamageSidesperDie"]) end
    if self["Attack2DamagebooleanofDice"] then unit:setAttack2DamagebooleanofDice(self["Attack2DamagebooleanofDice"]) end
    if self["Attack2DamageLossFactor"] then unit:setAttack2DamageLossFactor(self["Attack2DamageLossFactor"]) end
    if self["Attack2DamageFactorSmall"] then unit:setAttack2DamageFactorSmall(self["Attack2DamageFactorSmall"]) end
    if self["Attack2DamageFactorMedium"] then unit:setAttack2DamageFactorMedium(self["Attack2DamageFactorMedium"]) end
    if self["Attack2DamageBase"] then unit:setAttack2DamageBase(self["Attack2DamageBase"]) end
    if self["Attack2CooldownTime"] then unit:setAttack2CooldownTime(self["Attack2CooldownTime"]) end
    if self["Attack2AttackType"] then unit:setAttack2AttackType(self["Attack2AttackType"]) end
    if self["Attack2AreaofEffectTargets"] then unit:setAttack2AreaofEffectTargets(self["Attack2AreaofEffectTargets"]) end
    if self["Attack2AreaofEffectSmallDamage"] then unit:setAttack2AreaofEffectSmallDamage(self["Attack2AreaofEffectSmallDamage"]) end
    if self["Attack2AreaofEffectMediumDamage"] then unit:setAttack2AreaofEffectMediumDamage(self["Attack2AreaofEffectMediumDamage"]) end
    if self["Attack2AreaofEffectFullDamage"] then unit:setAttack2AreaofEffectFullDamage(self["Attack2AreaofEffectFullDamage"]) end
    if self["Attack2AnimationDamagePoint"] then unit:setAttack2AnimationDamagePoint(self["Attack2AnimationDamagePoint"]) end
    if self["Attack2AnimationBackswingPoint"] then unit:setAttack2AnimationBackswingPoint(self["Attack2AnimationBackswingPoint"]) end
    if self["Attack1WeaponType"] then unit:setAttack1WeaponType(self["Attack1WeaponType"]) end
    if self["Attack1WeaponSound"] then unit:setAttack1WeaponSound(self["Attack1WeaponSound"]) end
    if self["Attack1TargetsAllowed"] then unit:setAttack1TargetsAllowed(self["Attack1TargetsAllowed"]) end
    if self["Attack1ShowUI"] then unit:setAttack1ShowUI(self["Attack1ShowUI"]) end
    if self["Attack1RangeMotionBuffer"] then unit:setAttack1RangeMotionBuffer(self["Attack1RangeMotionBuffer"]) end
    if self["Attack1Range"] then unit:setAttack1Range(self["Attack1Range"]) end
    if self["Attack1ProjectileSpeed"] then unit:setAttack1ProjectileSpeed(self["Attack1ProjectileSpeed"]) end
    if self["Attack1ProjectileHomingEnabled"] then unit:setAttack1ProjectileHomingEnabled(self["Attack1ProjectileHomingEnabled"]) end
    if self["Attack1ProjectileArt"] then unit:setAttack1ProjectileArt(self["Attack1ProjectileArt"]) end
    if self["Attack1ProjectileArc"] then unit:setAttack1ProjectileArc(self["Attack1ProjectileArc"]) end
    if self["Attack1MaximumbooleanofTargets"] then unit:setAttack1MaximumbooleanofTargets(self["Attack1MaximumbooleanofTargets"]) end
    if self["Attack1DamageUpgradeAmount"] then unit:setAttack1DamageUpgradeAmount(self["Attack1DamageUpgradeAmount"]) end
    if self["Attack1DamageSpillRadius"] then unit:setAttack1DamageSpillRadius(self["Attack1DamageSpillRadius"]) end
    if self["Attack1DamageSpillDistance"] then unit:setAttack1DamageSpillDistance(self["Attack1DamageSpillDistance"]) end
    if self["Attack1DamageSidesperDie"] then unit:setAttack1DamageSidesperDie(self["Attack1DamageSidesperDie"]) end
    if self["Attack1DamagebooleanofDice"] then unit:setAttack1DamagebooleanofDice(self["Attack1DamagebooleanofDice"]) end
    if self["Attack1DamageLossFactor"] then unit:setAttack1DamageLossFactor(self["Attack1DamageLossFactor"]) end
    if self["Attack1DamageFactorSmall"] then unit:setAttack1DamageFactorSmall(self["Attack1DamageFactorSmall"]) end
    if self["Attack1DamageFactorMedium"] then unit:setAttack1DamageFactorMedium(self["Attack1DamageFactorMedium"]) end
    if self["Attack1DamageBase"] then unit:setAttack1DamageBase(self["Attack1DamageBase"]) end
    if self["Attack1CooldownTime"] then unit:setAttack1CooldownTime(self["Attack1CooldownTime"]) end
    if self["Attack1AttackType"] then unit:setAttack1AttackType(self["Attack1AttackType"]) end
    if self["Attack1AreaofEffectTargets"] then unit:setAttack1AreaofEffectTargets(self["Attack1AreaofEffectTargets"]) end
    if self["Attack1AreaofEffectSmallDamage"] then unit:setAttack1AreaofEffectSmallDamage(self["Attack1AreaofEffectSmallDamage"]) end
    if self["Attack1AreaofEffectMediumDamage"] then unit:setAttack1AreaofEffectMediumDamage(self["Attack1AreaofEffectMediumDamage"]) end
    if self["Attack1AreaofEffectFullDamage"] then unit:setAttack1AreaofEffectFullDamage(self["Attack1AreaofEffectFullDamage"]) end
    if self["Attack1AnimationDamagePoint"] then unit:setAttack1AnimationDamagePoint(self["Attack1AnimationDamagePoint"]) end
    if self["Attack1AnimationBackswingPoint"] then unit:setAttack1AnimationBackswingPoint(self["Attack1AnimationBackswingPoint"]) end
    if self["ArmorSoundType"] then unit:setArmorSoundType(self["ArmorSoundType"]) end
    if self["AnimationWalkSpeed"] then unit:setAnimationWalkSpeed(self["AnimationWalkSpeed"]) end
    if self["AnimationRunSpeed"] then unit:setAnimationRunSpeed(self["AnimationRunSpeed"]) end
    if self["AnimationCastPoint"] then unit:setAnimationCastPoint(self["AnimationCastPoint"]) end
    if self["AnimationCastBackswing"] then unit:setAnimationCastBackswing(self["AnimationCastBackswing"]) end
    if self["AnimationBlendTimeseconds"] then unit:setAnimationBlendTimeseconds(self["AnimationBlendTimeseconds"]) end
    if self["AllowCustomTeamColor"] then unit:setAllowCustomTeamColor(self["AllowCustomTeamColor"]) end
    if self["AIPlacementType"] then unit:setAIPlacementType(self["AIPlacementType"]) end
    if self["AIPlacementRadius"] then unit:setAIPlacementRadius(self["AIPlacementRadius"]) end
    if self["TransportedSize"] then unit:setTransportedSize(self["TransportedSize"]) end
    if self["Level"] then unit:setLevel(self["Level"]) end
    if self["GroupSeparationPriority"] then unit:setGroupSeparationPriority(self["GroupSeparationPriority"]) end
    if self["GroupSeparationParameter"] then unit:setGroupSeparationParameter(self["GroupSeparationParameter"]) end
    if self["GroupSeparationGroupNumber"] then unit:setGroupSeparationGroupNumber(self["GroupSeparationGroupNumber"]) end
    if self["GroupSeparationEnabled"] then unit:setGroupSeparationEnabled(self["GroupSeparationEnabled"]) end
    if self["FormationRank"] then unit:setFormationRank(self["FormationRank"]) end
    if self["StructuresBuilt"] then unit:setStructuresBuilt(self["StructuresBuilt"]) end
    if self["CasterUpgradeTips"] then unit:setCasterUpgradeTips(self["CasterUpgradeTips"]) end
    if self["CasterUpgradeNames"] then unit:setCasterUpgradeNames(self["CasterUpgradeNames"]) end
    if self["CasterUpgradeArt"] then unit:setCasterUpgradeArt(self["CasterUpgradeArt"]) end

end

return UnitCompiletimeData