local WeUnit = {}

local WeField = require('compiletime.we_object_editing.fields.field')
local WeObject = require("compiletime.we_object_editing.objects.we_object")

function WeUnit.new(id, base_id)
    local we_unit = {we_obj = WeObject.new(id, base_id, 'unit'), we_type = 'unit'}
    setmetatable(we_unit, {__index = WeUnit})
    return we_unit
end

function WeUnit:serialize()
    return self.we_obj:serialize()
end

function WeUnit:setTooltipExtended(string_data)
    local field = WeField.new('TooltipExtended', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setTooltipBasic(string_data)
    local field = WeField.new('TooltipBasic', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequirementsLevels(string_data)
    local field = WeField.new('RequirementsLevels', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequirements(string_data)
    local field = WeField.new('Requirements', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setName(string_data)
    local field = WeField.new('Name', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setHotkey(string_data)
    local field = WeField.new('Hotkey', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setDescription(string_data)
    local field = WeField.new('Description', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setButtonPositionY(int_data)
    local field = WeField.new('ButtonPositionY', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setButtonPositionX(int_data)
    local field = WeField.new('ButtonPositionX', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setItemsSold(string_data)
    local field = WeField.new('ItemsSold', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setUnitsSold(string_data)
    local field = WeField.new('UnitsSold', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setHideMinimapDisplay(int_data)
    local field = WeField.new('HideMinimapDisplay', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setUseExtendedLineofSight(int_data)
    local field = WeField.new('UseExtendedLineofSight', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setUseClickHelper(int_data)
    local field = WeField.new('UseClickHelper', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setUpgradesUsed(string_data)
    local field = WeField.new('UpgradesUsed', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setUnitSoundSet(string_data)
    local field = WeField.new('UnitSoundSet', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setUnitClassification(string_data)
    local field = WeField.new('UnitClassification', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setMovementType(string_data)
    local field = WeField.new('MovementType', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setTurnRate(unreal_data)
    local field = WeField.new('TurnRate', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setTintingColorBlue(int_data)
    local field = WeField.new('TintingColorBlue', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setTintingColorGreen(int_data)
    local field = WeField.new('TintingColorGreen', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setTintingColorRed(int_data)
    local field = WeField.new('TintingColorRed', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setTilesets(string_data)
    local field = WeField.new('Tilesets', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setTeamColor(int_data)
    local field = WeField.new('TeamColor', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setTargetedAs(string_data)
    local field = WeField.new('TargetedAs', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setTarget(string_data)
    local field = WeField.new('Target', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setArtTarget(string_data)
    local field = WeField.new('ArtTarget', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setStockStartDelay(int_data)
    local field = WeField.new('StockStartDelay', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setStockReplenishInterval(int_data)
    local field = WeField.new('StockReplenishInterval', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setStockMaximum(int_data)
    local field = WeField.new('StockMaximum', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setSpeedMinimum(int_data)
    local field = WeField.new('SpeedMinimum', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setSpeedMaximum(int_data)
    local field = WeField.new('SpeedMaximum', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setSpeedBase(int_data)
    local field = WeField.new('SpeedBase', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setSpecial(string_data)
    local field = WeField.new('Special', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setArtSpecial(string_data)
    local field = WeField.new('ArtSpecial', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setSleeps(int_data)
    local field = WeField.new('Sleeps', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setSightRadiusNight(int_data)
    local field = WeField.new('SightRadiusNight', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setSightRadiusDay(int_data)
    local field = WeField.new('SightRadiusDay', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setShadowTextureBuilding(string_data)
    local field = WeField.new('ShadowTextureBuilding', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setShadowImageWidth(real_data)
    local field = WeField.new('ShadowImageWidth', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setShadowImageUnit(string_data)
    local field = WeField.new('ShadowImageUnit', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setShadowImageHeight(real_data)
    local field = WeField.new('ShadowImageHeight', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setShadowImageCenterY(real_data)
    local field = WeField.new('ShadowImageCenterY', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setShadowImageCenterX(real_data)
    local field = WeField.new('ShadowImageCenterX', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setSelectionScale(real_data)
    local field = WeField.new('SelectionScale', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setSelectionCircleOnWater(int_data)
    local field = WeField.new('SelectionCircleOnWater', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setSelectionCircleHeight(real_data)
    local field = WeField.new('SelectionCircleHeight', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setScalingValue(real_data)
    local field = WeField.new('ScalingValue', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setScaleProjectiles(int_data)
    local field = WeField.new('ScaleProjectiles', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequiredBoneNames(string_data)
    local field = WeField.new('RequiredBoneNames', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequiredAttachmentLinkNames(string_data)
    local field = WeField.new('RequiredAttachmentLinkNames', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequiredAnimationNamesAttachments(string_data)
    local field = WeField.new('RequiredAnimationNamesAttachments', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequiredAnimationNames(string_data)
    local field = WeField.new('RequiredAnimationNames', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRepairTime(int_data)
    local field = WeField.new('RepairTime', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setRepairLumberCost(int_data)
    local field = WeField.new('RepairLumberCost', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setRepairGoldCost(int_data)
    local field = WeField.new('RepairGoldCost', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setRandomSound(string_data)
    local field = WeField.new('RandomSound', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRace(string_data)
    local field = WeField.new('Race', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setPropulsionWindowdegrees(unreal_data)
    local field = WeField.new('PropulsionWindowdegrees', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setProjectileLaunchZSwimming(unreal_data)
    local field = WeField.new('ProjectileLaunchZSwimming', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setProjectileLaunchZ(unreal_data)
    local field = WeField.new('ProjectileLaunchZ', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setProjectileLaunchY(unreal_data)
    local field = WeField.new('ProjectileLaunchY', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setProjectileLaunchX(unreal_data)
    local field = WeField.new('ProjectileLaunchX', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setProjectileImpactZSwimming(unreal_data)
    local field = WeField.new('ProjectileImpactZSwimming', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setProjectileImpactZ(unreal_data)
    local field = WeField.new('ProjectileImpactZ', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setPriority(int_data)
    local field = WeField.new('Priority', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setPointValue(int_data)
    local field = WeField.new('PointValue', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setPlaceableInEditor(int_data)
    local field = WeField.new('PlaceableInEditor', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setOrientationInterpolation(int_data)
    local field = WeField.new('OrientationInterpolation', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setOccluderHeight(unreal_data)
    local field = WeField.new('OccluderHeight', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setNormalAbilities(string_data)
    local field = WeField.new('NormalAbilities', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setNameEditorSuffix(string_data)
    local field = WeField.new('NameEditorSuffix', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setMovementSound(string_data)
    local field = WeField.new('MovementSound', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setModelFileExtraVersions(string_data)
    local field = WeField.new('ModelFileExtraVersions', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setModelFile(string_data)
    local field = WeField.new('ModelFile', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setMinimumAttackRange(int_data)
    local field = WeField.new('MinimumAttackRange', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setMaximumRollAngledegrees(real_data)
    local field = WeField.new('MaximumRollAngledegrees', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setMaximumPitchAngledegrees(real_data)
    local field = WeField.new('MaximumPitchAngledegrees', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setManaRegeneration(unreal_data)
    local field = WeField.new('ManaRegeneration', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setManaMaximum(int_data)
    local field = WeField.new('ManaMaximum', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setManaInitialAmount(int_data)
    local field = WeField.new('ManaInitialAmount', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setLumberCost(int_data)
    local field = WeField.new('LumberCost', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setSoundLoopingFadeOutRate(int_data)
    local field = WeField.new('SoundLoopingFadeOutRate', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setSoundLoopingFadeInRate(int_data)
    local field = WeField.new('SoundLoopingFadeInRate', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setIsaBuilding(int_data)
    local field = WeField.new('IsaBuilding', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setIconScoreScreen(string_data)
    local field = WeField.new('IconScoreScreen', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setIconGameInterface(string_data)
    local field = WeField.new('IconGameInterface', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setHitPointsRegenerationType(string_data)
    local field = WeField.new('HitPointsRegenerationType', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setHitPointsRegenerationRate(unreal_data)
    local field = WeField.new('HitPointsRegenerationRate', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setHitPointsMaximumBase(int_data)
    local field = WeField.new('HitPointsMaximumBase', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setMovementHeightMinimum(unreal_data)
    local field = WeField.new('MovementHeightMinimum', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setMovementHeight(unreal_data)
    local field = WeField.new('MovementHeight', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setHasWaterShadow(int_data)
    local field = WeField.new('HasWaterShadow', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setHasTilesetSpecificData(int_data)
    local field = WeField.new('HasTilesetSpecificData', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setGoldCost(int_data)
    local field = WeField.new('GoldCost', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setGoldBountyAwardedSidesperDie(int_data)
    local field = WeField.new('GoldBountyAwardedSidesperDie', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setGoldBountyAwardedNumberofDice(int_data)
    local field = WeField.new('GoldBountyAwardedNumberofDice', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setGoldBountyAwardedBase(int_data)
    local field = WeField.new('GoldBountyAwardedBase', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setLumberBountyAwardedSidesperDie(int_data)
    local field = WeField.new('LumberBountyAwardedSidesperDie', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setLumberBountyAwardedNumberofDice(int_data)
    local field = WeField.new('LumberBountyAwardedNumberofDice', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setLumberBountyAwardedBase(int_data)
    local field = WeField.new('LumberBountyAwardedBase', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setFoodProduced(int_data)
    local field = WeField.new('FoodProduced', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setFoodCost(int_data)
    local field = WeField.new('FoodCost', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setFogOfWarSampleRadius(real_data)
    local field = WeField.new('FogOfWarSampleRadius', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setElevationSampleRadius(real_data)
    local field = WeField.new('ElevationSampleRadius', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setElevationSamplePoints(int_data)
    local field = WeField.new('ElevationSamplePoints', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setDisplayasNeutralHostile(int_data)
    local field = WeField.new('DisplayasNeutralHostile', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setDependencyEquivalents(string_data)
    local field = WeField.new('DependencyEquivalents', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setDefenseUpgradeBonus(int_data)
    local field = WeField.new('DefenseUpgradeBonus', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setArmorType(string_data)
    local field = WeField.new('ArmorType', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setDefenseBase(int_data)
    local field = WeField.new('DefenseBase', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setDefaultActiveAbility(string_data)
    local field = WeField.new('DefaultActiveAbility', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setDeathType(int_data)
    local field = WeField.new('DeathType', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setDeathTimeseconds(unreal_data)
    local field = WeField.new('DeathTimeseconds', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setCollisionSize(unreal_data)
    local field = WeField.new('CollisionSize', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setCategorizationSpecial(int_data)
    local field = WeField.new('CategorizationSpecial', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setCategorizationCampaign(int_data)
    local field = WeField.new('CategorizationCampaign', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setCanFlee(int_data)
    local field = WeField.new('CanFlee', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setCanDropItemsOnDeath(int_data)
    local field = WeField.new('CanDropItemsOnDeath', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setBuildTime(int_data)
    local field = WeField.new('BuildTime', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttacksEnabled(int_data)
    local field = WeField.new('AttacksEnabled', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2WeaponType(string_data)
    local field = WeField.new('Attack2WeaponType', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2WeaponSound(string_data)
    local field = WeField.new('Attack2WeaponSound', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2TargetsAllowed(string_data)
    local field = WeField.new('Attack2TargetsAllowed', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2ShowUI(int_data)
    local field = WeField.new('Attack2ShowUI', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2RangeMotionBuffer(unreal_data)
    local field = WeField.new('Attack2RangeMotionBuffer', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2Range(int_data)
    local field = WeField.new('Attack2Range', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2ProjectileSpeed(int_data)
    local field = WeField.new('Attack2ProjectileSpeed', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2ProjectileHomingEnabled(int_data)
    local field = WeField.new('Attack2ProjectileHomingEnabled', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2ProjectileArt(string_data)
    local field = WeField.new('Attack2ProjectileArt', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2ProjectileArc(unreal_data)
    local field = WeField.new('Attack2ProjectileArc', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2MaximumNumberofTargets(int_data)
    local field = WeField.new('Attack2MaximumNumberofTargets', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2DamageUpgradeAmount(int_data)
    local field = WeField.new('Attack2DamageUpgradeAmount', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2DamageSpillRadius(unreal_data)
    local field = WeField.new('Attack2DamageSpillRadius', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2DamageSpillDistance(unreal_data)
    local field = WeField.new('Attack2DamageSpillDistance', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2DamageSidesperDie(int_data)
    local field = WeField.new('Attack2DamageSidesperDie', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2DamageNumberofDice(int_data)
    local field = WeField.new('Attack2DamageNumberofDice', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2DamageLossFactor(unreal_data)
    local field = WeField.new('Attack2DamageLossFactor', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2DamageFactorSmall(unreal_data)
    local field = WeField.new('Attack2DamageFactorSmall', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2DamageFactorMedium(unreal_data)
    local field = WeField.new('Attack2DamageFactorMedium', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2DamageBase(int_data)
    local field = WeField.new('Attack2DamageBase', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2CooldownTime(unreal_data)
    local field = WeField.new('Attack2CooldownTime', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2AttackType(string_data)
    local field = WeField.new('Attack2AttackType', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2AreaofEffectTargets(string_data)
    local field = WeField.new('Attack2AreaofEffectTargets', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2AreaofEffectSmallDamage(int_data)
    local field = WeField.new('Attack2AreaofEffectSmallDamage', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2AreaofEffectMediumDamage(int_data)
    local field = WeField.new('Attack2AreaofEffectMediumDamage', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2AreaofEffectFullDamage(int_data)
    local field = WeField.new('Attack2AreaofEffectFullDamage', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2AnimationDamagePoint(unreal_data)
    local field = WeField.new('Attack2AnimationDamagePoint', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2AnimationBackswingPoint(unreal_data)
    local field = WeField.new('Attack2AnimationBackswingPoint', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2WeaponType(string_data)
    local field = WeField.new('Attack2WeaponType', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2WeaponSound(string_data)
    local field = WeField.new('Attack2WeaponSound', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1TargetsAllowed(string_data)
    local field = WeField.new('Attack1TargetsAllowed', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1ShowUI(int_data)
    local field = WeField.new('Attack1ShowUI', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1RangeMotionBuffer(unreal_data)
    local field = WeField.new('Attack1RangeMotionBuffer', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1Range(int_data)
    local field = WeField.new('Attack1Range', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1ProjectileSpeed(int_data)
    local field = WeField.new('Attack1ProjectileSpeed', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1ProjectileHomingEnabled(int_data)
    local field = WeField.new('Attack1ProjectileHomingEnabled', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1ProjectileArt(string_data)
    local field = WeField.new('Attack1ProjectileArt', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1ProjectileArc(unreal_data)
    local field = WeField.new('Attack1ProjectileArc', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1MaximumNumberofTargets(int_data)
    local field = WeField.new('Attack1MaximumNumberofTargets', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1DamageUpgradeAmount(int_data)
    local field = WeField.new('Attack1DamageUpgradeAmount', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1DamageSpillRadius(unreal_data)
    local field = WeField.new('Attack1DamageSpillRadius', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1DamageSpillDistance(unreal_data)
    local field = WeField.new('Attack1DamageSpillDistance', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1DamageSidesperDie(int_data)
    local field = WeField.new('Attack1DamageSidesperDie', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1DamageNumberofDice(int_data)
    local field = WeField.new('Attack1DamageNumberofDice', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1DamageLossFactor(unreal_data)
    local field = WeField.new('Attack1DamageLossFactor', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1DamageFactorSmall(unreal_data)
    local field = WeField.new('Attack1DamageFactorSmall', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1DamageFactorMedium(unreal_data)
    local field = WeField.new('Attack1DamageFactorMedium', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1DamageBase(int_data)
    local field = WeField.new('Attack1DamageBase', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1CooldownTime(unreal_data)
    local field = WeField.new('Attack1CooldownTime', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack2AttackType(string_data)
    local field = WeField.new('Attack2AttackType', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1AreaofEffectTargets(string_data)
    local field = WeField.new('Attack1AreaofEffectTargets', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1AreaofEffectSmallDamage(int_data)
    local field = WeField.new('Attack1AreaofEffectSmallDamage', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1AreaofEffectMediumDamage(int_data)
    local field = WeField.new('Attack1AreaofEffectMediumDamage', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1AreaofEffectFullDamage(int_data)
    local field = WeField.new('Attack1AreaofEffectFullDamage', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1AnimationDamagePoint(unreal_data)
    local field = WeField.new('Attack1AnimationDamagePoint', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAttack1AnimationBackswingPoint(unreal_data)
    local field = WeField.new('Attack1AnimationBackswingPoint', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setArmorSoundType(string_data)
    local field = WeField.new('ArmorSoundType', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAnimationWalkSpeed(real_data)
    local field = WeField.new('AnimationWalkSpeed', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setAnimationRunSpeed(real_data)
    local field = WeField.new('AnimationRunSpeed', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setAnimationCastPoint(unreal_data)
    local field = WeField.new('AnimationCastPoint', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAnimationCastBackswing(unreal_data)
    local field = WeField.new('AnimationCastBackswing', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAnimationBlendTimeseconds(real_data)
    local field = WeField.new('AnimationBlendTimeseconds', 'unit', real_data)
    self.we_obj:addField(field)
end

function WeUnit:setAllowCustomTeamColor(int_data)
    local field = WeField.new('AllowCustomTeamColor', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setAIPlacementType(string_data)
    local field = WeField.new('AIPlacementType', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAIPlacementRadius(unreal_data)
    local field = WeField.new('AIPlacementRadius', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setAcquisitionRange(unreal_data)
    local field = WeField.new('AcquisitionRange', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setTransportedSize(int_data)
    local field = WeField.new('TransportedSize', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setLevel(int_data)
    local field = WeField.new('Level', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setGroupSeparationPriority(int_data)
    local field = WeField.new('GroupSeparationPriority', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setGroupSeparationParameter(int_data)
    local field = WeField.new('GroupSeparationParameter', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setGroupSeparationGroupNumber(int_data)
    local field = WeField.new('GroupSeparationGroupNumber', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setGroupSeparationEnabled(int_data)
    local field = WeField.new('GroupSeparationEnabled', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setFormationRank(int_data)
    local field = WeField.new('FormationRank', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setStructuresBuilt(string_data)
    local field = WeField.new('StructuresBuilt', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:seteHeroDeathMsg(int_data)
    local field = WeField.new('eHeroDeathMsg', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:seteHeroInterfaceIcon(int_data)
    local field = WeField.new('eHeroInterfaceIcon', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:seteHeroMinimapDisplay(int_data)
    local field = WeField.new('eHeroMinimapDisplay', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setTooltipRevive(string_data)
    local field = WeField.new('TooltipRevive', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setTooltipAwaken(string_data)
    local field = WeField.new('TooltipAwaken', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setStrengthPerLevel(unreal_data)
    local field = WeField.new('StrengthPerLevel', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setStartingStrength(int_data)
    local field = WeField.new('StartingStrength', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setStartingIntelligence(int_data)
    local field = WeField.new('StartingIntelligence', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setStartingAgility(int_data)
    local field = WeField.new('StartingAgility', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setProperNamesUsed(int_data)
    local field = WeField.new('ProperNamesUsed', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setProperNames(string_data)
    local field = WeField.new('ProperNames', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setPrimaryAttribute(string_data)
    local field = WeField.new('PrimaryAttribute', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setIntelligencePerLevel(unreal_data)
    local field = WeField.new('IntelligencePerLevel', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setHeroRevivalLocations(string_data)
    local field = WeField.new('HeroRevivalLocations', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setHeroAbilities(string_data)
    local field = WeField.new('HeroAbilities', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setAgilityPerLevel(unreal_data)
    local field = WeField.new('AgilityPerLevel', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setCasterUpgradeTips(string_data)
    local field = WeField.new('CasterUpgradeTips', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setCasterUpgradeNames(string_data)
    local field = WeField.new('CasterUpgradeNames', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setCasterUpgradeArt(string_data)
    local field = WeField.new('CasterUpgradeArt', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setUpgradesTo(string_data)
    local field = WeField.new('UpgradesTo', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setUnitsTrained(string_data)
    local field = WeField.new('UnitsTrained', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRevivesDeadHeros(int_data)
    local field = WeField.new('RevivesDeadHeros', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setResearchesAvailable(string_data)
    local field = WeField.new('ResearchesAvailable', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setPlacementRequiresWaterRadius(unreal_data)
    local field = WeField.new('PlacementRequiresWaterRadius', 'unit', unreal_data)
    self.we_obj:addField(field)
end

function WeUnit:setPlacementRequires(string_data)
    local field = WeField.new('PlacementRequires', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setPlacementPreventedBy(string_data)
    local field = WeField.new('PlacementPreventedBy', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setPathingMap(string_data)
    local field = WeField.new('PathingMap', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setNeutralBuildingValidAsRandomBuilding(int_data)
    local field = WeField.new('NeutralBuildingValidAsRandomBuilding', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setNeutralBuildingShowsMinimapIcon(int_data)
    local field = WeField.new('NeutralBuildingShowsMinimapIcon', 'unit', int_data)
    self.we_obj:addField(field)
end

function WeUnit:setItemsMade(string_data)
    local field = WeField.new('ItemsMade', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setGroundTexture(string_data)
    local field = WeField.new('GroundTexture', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setConstructionSound(string_data)
    local field = WeField.new('ConstructionSound', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequierementsForTier1(string_data)
    local field = WeField.new('RequierementsForTier1', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequierementsForTier2(string_data)
    local field = WeField.new('RequierementsForTier2', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequierementsForTier3(string_data)
    local field = WeField.new('RequierementsForTier3', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequierementsForTier4(string_data)
    local field = WeField.new('RequierementsForTier4', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequierementsForTier5(string_data)
    local field = WeField.new('RequierementsForTier5', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequierementsForTier6(string_data)
    local field = WeField.new('RequierementsForTier6', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequierementsForTier7(string_data)
    local field = WeField.new('RequierementsForTier7', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequierementsForTier8(string_data)
    local field = WeField.new('RequierementsForTier8', 'unit', string_data)
    self.we_obj:addField(field)
end

function WeUnit:setRequierementsForTier9(string_data)
    local field = WeField.new('RequierementsForTier9', 'unit', string_data)
    self.we_obj:addField(field)
end


return WeUnit