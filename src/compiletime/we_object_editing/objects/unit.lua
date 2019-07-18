local WeUnit = {}

local WeField = require('compiletime.we_object_editing.fields.field')
local WeObject = require("compiletime.we_object_editing.objects.we_object")

function WeUnit.new(id, base_id)
    local we_unit = {we_obj = WeObject.new(id, base_id, 'unit')}
    setmetatable(we_unit, {__index = WeUnit})
    return we_unit
end

function WeUnit.setTooltipExtended(we_unit, string_data)
    local field = WeField.new('TooltipExtended', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTooltipBasic(we_unit, string_data)
    local field = WeField.new('TooltipBasic', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequirementsLevels(we_unit, string_data)
    local field = WeField.new('RequirementsLevels', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequirements(we_unit, string_data)
    local field = WeField.new('Requirements', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setName(we_unit, string_data)
    local field = WeField.new('Name', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setHotkey(we_unit, string_data)
    local field = WeField.new('Hotkey', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setDescription(we_unit, string_data)
    local field = WeField.new('Description', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setButtonPositionY(we_unit, int_data)
    local field = WeField.new('ButtonPositionY', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setButtonPositionX(we_unit, int_data)
    local field = WeField.new('ButtonPositionX', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setItemsSold(we_unit, string_data)
    local field = WeField.new('ItemsSold', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setUnitsSold(we_unit, string_data)
    local field = WeField.new('UnitsSold', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setHideMinimapDisplay(we_unit, int_data)
    local field = WeField.new('HideMinimapDisplay', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setUseExtendedLineofSight(we_unit, int_data)
    local field = WeField.new('UseExtendedLineofSight', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setUseClickHelper(we_unit, int_data)
    local field = WeField.new('UseClickHelper', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setUpgradesUsed(we_unit, string_data)
    local field = WeField.new('UpgradesUsed', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setUnitSoundSet(we_unit, string_data)
    local field = WeField.new('UnitSoundSet', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setUnitClassification(we_unit, string_data)
    local field = WeField.new('UnitClassification', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setMovementType(we_unit, string_data)
    local field = WeField.new('MovementType', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTurnRate(we_unit, unreal_data)
    local field = WeField.new('TurnRate', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTintingColorBlue(we_unit, int_data)
    local field = WeField.new('TintingColorBlue', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTintingColorGreen(we_unit, int_data)
    local field = WeField.new('TintingColorGreen', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTintingColorRed(we_unit, int_data)
    local field = WeField.new('TintingColorRed', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTilesets(we_unit, string_data)
    local field = WeField.new('Tilesets', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTeamColor(we_unit, int_data)
    local field = WeField.new('TeamColor', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTargetedAs(we_unit, string_data)
    local field = WeField.new('TargetedAs', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTarget(we_unit, string_data)
    local field = WeField.new('Target', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setArtTarget(we_unit, string_data)
    local field = WeField.new('ArtTarget', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setStockStartDelay(we_unit, int_data)
    local field = WeField.new('StockStartDelay', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setStockReplenishInterval(we_unit, int_data)
    local field = WeField.new('StockReplenishInterval', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setStockMaximum(we_unit, int_data)
    local field = WeField.new('StockMaximum', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSpeedMinimum(we_unit, int_data)
    local field = WeField.new('SpeedMinimum', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSpeedMaximum(we_unit, int_data)
    local field = WeField.new('SpeedMaximum', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSpeedBase(we_unit, int_data)
    local field = WeField.new('SpeedBase', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSpecial(we_unit, string_data)
    local field = WeField.new('Special', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setArtSpecial(we_unit, string_data)
    local field = WeField.new('ArtSpecial', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSleeps(we_unit, int_data)
    local field = WeField.new('Sleeps', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSightRadiusNight(we_unit, int_data)
    local field = WeField.new('SightRadiusNight', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSightRadiusDay(we_unit, int_data)
    local field = WeField.new('SightRadiusDay', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setShadowTextureBuilding(we_unit, string_data)
    local field = WeField.new('ShadowTextureBuilding', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setShadowImageWidth(we_unit, real_data)
    local field = WeField.new('ShadowImageWidth', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setShadowImageUnit(we_unit, string_data)
    local field = WeField.new('ShadowImageUnit', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setShadowImageHeight(we_unit, real_data)
    local field = WeField.new('ShadowImageHeight', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setShadowImageCenterY(we_unit, real_data)
    local field = WeField.new('ShadowImageCenterY', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setShadowImageCenterX(we_unit, real_data)
    local field = WeField.new('ShadowImageCenterX', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSelectionScale(we_unit, real_data)
    local field = WeField.new('SelectionScale', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSelectionCircleOnWater(we_unit, int_data)
    local field = WeField.new('SelectionCircleOnWater', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSelectionCircleHeight(we_unit, real_data)
    local field = WeField.new('SelectionCircleHeight', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setScalingValue(we_unit, real_data)
    local field = WeField.new('ScalingValue', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setScaleProjectiles(we_unit, int_data)
    local field = WeField.new('ScaleProjectiles', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequiredBoneNames(we_unit, string_data)
    local field = WeField.new('RequiredBoneNames', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequiredAttachmentLinkNames(we_unit, string_data)
    local field = WeField.new('RequiredAttachmentLinkNames', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequiredAnimationNamesAttachments(we_unit, string_data)
    local field = WeField.new('RequiredAnimationNamesAttachments', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequiredAnimationNames(we_unit, string_data)
    local field = WeField.new('RequiredAnimationNames', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRepairTime(we_unit, int_data)
    local field = WeField.new('RepairTime', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRepairLumberCost(we_unit, int_data)
    local field = WeField.new('RepairLumberCost', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRepairGoldCost(we_unit, int_data)
    local field = WeField.new('RepairGoldCost', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRandomSound(we_unit, string_data)
    local field = WeField.new('RandomSound', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRace(we_unit, string_data)
    local field = WeField.new('Race', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setPropulsionWindowdegrees(we_unit, unreal_data)
    local field = WeField.new('PropulsionWindowdegrees', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setProjectileLaunchZSwimming(we_unit, unreal_data)
    local field = WeField.new('ProjectileLaunchZSwimming', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setProjectileLaunchZ(we_unit, unreal_data)
    local field = WeField.new('ProjectileLaunchZ', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setProjectileLaunchY(we_unit, unreal_data)
    local field = WeField.new('ProjectileLaunchY', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setProjectileLaunchX(we_unit, unreal_data)
    local field = WeField.new('ProjectileLaunchX', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setProjectileImpactZSwimming(we_unit, unreal_data)
    local field = WeField.new('ProjectileImpactZSwimming', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setProjectileImpactZ(we_unit, unreal_data)
    local field = WeField.new('ProjectileImpactZ', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setPriority(we_unit, int_data)
    local field = WeField.new('Priority', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setPointValue(we_unit, int_data)
    local field = WeField.new('PointValue', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setPlaceableInEditor(we_unit, int_data)
    local field = WeField.new('PlaceableInEditor', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setOrientationInterpolation(we_unit, int_data)
    local field = WeField.new('OrientationInterpolation', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setOccluderHeight(we_unit, unreal_data)
    local field = WeField.new('OccluderHeight', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setNormalAbilities(we_unit, string_data)
    local field = WeField.new('NormalAbilities', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setNameEditorSuffix(we_unit, string_data)
    local field = WeField.new('NameEditorSuffix', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setMovementSound(we_unit, string_data)
    local field = WeField.new('MovementSound', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setModelFileExtraVersions(we_unit, string_data)
    local field = WeField.new('ModelFileExtraVersions', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setModelFile(we_unit, string_data)
    local field = WeField.new('ModelFile', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setMinimumAttackRange(we_unit, int_data)
    local field = WeField.new('MinimumAttackRange', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setMaximumRollAngledegrees(we_unit, real_data)
    local field = WeField.new('MaximumRollAngledegrees', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setMaximumPitchAngledegrees(we_unit, real_data)
    local field = WeField.new('MaximumPitchAngledegrees', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setManaRegeneration(we_unit, unreal_data)
    local field = WeField.new('ManaRegeneration', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setManaMaximum(we_unit, int_data)
    local field = WeField.new('ManaMaximum', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setManaInitialAmount(we_unit, int_data)
    local field = WeField.new('ManaInitialAmount', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setLumberCost(we_unit, int_data)
    local field = WeField.new('LumberCost', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSoundLoopingFadeOutRate(we_unit, int_data)
    local field = WeField.new('SoundLoopingFadeOutRate', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setSoundLoopingFadeInRate(we_unit, int_data)
    local field = WeField.new('SoundLoopingFadeInRate', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setIsaBuilding(we_unit, int_data)
    local field = WeField.new('IsaBuilding', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setIconScoreScreen(we_unit, string_data)
    local field = WeField.new('IconScoreScreen', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setIconGameInterface(we_unit, string_data)
    local field = WeField.new('IconGameInterface', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setHitPointsRegenerationType(we_unit, string_data)
    local field = WeField.new('HitPointsRegenerationType', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setHitPointsRegenerationRate(we_unit, unreal_data)
    local field = WeField.new('HitPointsRegenerationRate', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setHitPointsMaximumBase(we_unit, int_data)
    local field = WeField.new('HitPointsMaximumBase', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setMovementHeightMinimum(we_unit, unreal_data)
    local field = WeField.new('MovementHeightMinimum', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setMovementHeight(we_unit, unreal_data)
    local field = WeField.new('MovementHeight', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setHasWaterShadow(we_unit, int_data)
    local field = WeField.new('HasWaterShadow', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setHasTilesetSpecificData(we_unit, int_data)
    local field = WeField.new('HasTilesetSpecificData', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setGoldCost(we_unit, int_data)
    local field = WeField.new('GoldCost', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setGoldBountyAwardedSidesperDie(we_unit, int_data)
    local field = WeField.new('GoldBountyAwardedSidesperDie', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setGoldBountyAwardedNumberofDice(we_unit, int_data)
    local field = WeField.new('GoldBountyAwardedNumberofDice', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setGoldBountyAwardedBase(we_unit, int_data)
    local field = WeField.new('GoldBountyAwardedBase', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setLumberBountyAwardedSidesperDie(we_unit, int_data)
    local field = WeField.new('LumberBountyAwardedSidesperDie', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setLumberBountyAwardedNumberofDice(we_unit, int_data)
    local field = WeField.new('LumberBountyAwardedNumberofDice', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setLumberBountyAwardedBase(we_unit, int_data)
    local field = WeField.new('LumberBountyAwardedBase', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setFoodProduced(we_unit, int_data)
    local field = WeField.new('FoodProduced', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setFoodCost(we_unit, int_data)
    local field = WeField.new('FoodCost', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setFogOfWarSampleRadius(we_unit, real_data)
    local field = WeField.new('FogOfWarSampleRadius', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setElevationSampleRadius(we_unit, real_data)
    local field = WeField.new('ElevationSampleRadius', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setElevationSamplePoints(we_unit, int_data)
    local field = WeField.new('ElevationSamplePoints', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setDisplayasNeutralHostile(we_unit, int_data)
    local field = WeField.new('DisplayasNeutralHostile', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setDependencyEquivalents(we_unit, string_data)
    local field = WeField.new('DependencyEquivalents', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setDefenseUpgradeBonus(we_unit, int_data)
    local field = WeField.new('DefenseUpgradeBonus', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setArmorType(we_unit, string_data)
    local field = WeField.new('ArmorType', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setDefenseBase(we_unit, int_data)
    local field = WeField.new('DefenseBase', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setDefaultActiveAbility(we_unit, string_data)
    local field = WeField.new('DefaultActiveAbility', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setDeathType(we_unit, int_data)
    local field = WeField.new('DeathType', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setDeathTimeseconds(we_unit, unreal_data)
    local field = WeField.new('DeathTimeseconds', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setCollisionSize(we_unit, unreal_data)
    local field = WeField.new('CollisionSize', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setCategorizationSpecial(we_unit, int_data)
    local field = WeField.new('CategorizationSpecial', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setCategorizationCampaign(we_unit, int_data)
    local field = WeField.new('CategorizationCampaign', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setCanFlee(we_unit, int_data)
    local field = WeField.new('CanFlee', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setCanDropItemsOnDeath(we_unit, int_data)
    local field = WeField.new('CanDropItemsOnDeath', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setBuildTime(we_unit, int_data)
    local field = WeField.new('BuildTime', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttacksEnabled(we_unit, int_data)
    local field = WeField.new('AttacksEnabled', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2WeaponType(we_unit, string_data)
    local field = WeField.new('Attack2WeaponType', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2WeaponSound(we_unit, string_data)
    local field = WeField.new('Attack2WeaponSound', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2TargetsAllowed(we_unit, string_data)
    local field = WeField.new('Attack2TargetsAllowed', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2ShowUI(we_unit, int_data)
    local field = WeField.new('Attack2ShowUI', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2RangeMotionBuffer(we_unit, unreal_data)
    local field = WeField.new('Attack2RangeMotionBuffer', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2Range(we_unit, int_data)
    local field = WeField.new('Attack2Range', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2ProjectileSpeed(we_unit, int_data)
    local field = WeField.new('Attack2ProjectileSpeed', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2ProjectileHomingEnabled(we_unit, int_data)
    local field = WeField.new('Attack2ProjectileHomingEnabled', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2ProjectileArt(we_unit, string_data)
    local field = WeField.new('Attack2ProjectileArt', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2ProjectileArc(we_unit, unreal_data)
    local field = WeField.new('Attack2ProjectileArc', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2MaximumNumberofTargets(we_unit, int_data)
    local field = WeField.new('Attack2MaximumNumberofTargets', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2DamageUpgradeAmount(we_unit, int_data)
    local field = WeField.new('Attack2DamageUpgradeAmount', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2DamageSpillRadius(we_unit, unreal_data)
    local field = WeField.new('Attack2DamageSpillRadius', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2DamageSpillDistance(we_unit, unreal_data)
    local field = WeField.new('Attack2DamageSpillDistance', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2DamageSidesperDie(we_unit, int_data)
    local field = WeField.new('Attack2DamageSidesperDie', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2DamageNumberofDice(we_unit, int_data)
    local field = WeField.new('Attack2DamageNumberofDice', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2DamageLossFactor(we_unit, unreal_data)
    local field = WeField.new('Attack2DamageLossFactor', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2DamageFactorSmall(we_unit, unreal_data)
    local field = WeField.new('Attack2DamageFactorSmall', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2DamageFactorMedium(we_unit, unreal_data)
    local field = WeField.new('Attack2DamageFactorMedium', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2DamageBase(we_unit, int_data)
    local field = WeField.new('Attack2DamageBase', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2CooldownTime(we_unit, unreal_data)
    local field = WeField.new('Attack2CooldownTime', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2AttackType(we_unit, string_data)
    local field = WeField.new('Attack2AttackType', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2AreaofEffectTargets(we_unit, string_data)
    local field = WeField.new('Attack2AreaofEffectTargets', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2AreaofEffectSmallDamage(we_unit, int_data)
    local field = WeField.new('Attack2AreaofEffectSmallDamage', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2AreaofEffectMediumDamage(we_unit, int_data)
    local field = WeField.new('Attack2AreaofEffectMediumDamage', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2AreaofEffectFullDamage(we_unit, int_data)
    local field = WeField.new('Attack2AreaofEffectFullDamage', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2AnimationDamagePoint(we_unit, unreal_data)
    local field = WeField.new('Attack2AnimationDamagePoint', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2AnimationBackswingPoint(we_unit, unreal_data)
    local field = WeField.new('Attack2AnimationBackswingPoint', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2WeaponType(we_unit, string_data)
    local field = WeField.new('Attack2WeaponType', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2WeaponSound(we_unit, string_data)
    local field = WeField.new('Attack2WeaponSound', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1TargetsAllowed(we_unit, string_data)
    local field = WeField.new('Attack1TargetsAllowed', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1ShowUI(we_unit, int_data)
    local field = WeField.new('Attack1ShowUI', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1RangeMotionBuffer(we_unit, unreal_data)
    local field = WeField.new('Attack1RangeMotionBuffer', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1Range(we_unit, int_data)
    local field = WeField.new('Attack1Range', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1ProjectileSpeed(we_unit, int_data)
    local field = WeField.new('Attack1ProjectileSpeed', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1ProjectileHomingEnabled(we_unit, int_data)
    local field = WeField.new('Attack1ProjectileHomingEnabled', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1ProjectileArt(we_unit, string_data)
    local field = WeField.new('Attack1ProjectileArt', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1ProjectileArc(we_unit, unreal_data)
    local field = WeField.new('Attack1ProjectileArc', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1MaximumNumberofTargets(we_unit, int_data)
    local field = WeField.new('Attack1MaximumNumberofTargets', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1DamageUpgradeAmount(we_unit, int_data)
    local field = WeField.new('Attack1DamageUpgradeAmount', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1DamageSpillRadius(we_unit, unreal_data)
    local field = WeField.new('Attack1DamageSpillRadius', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1DamageSpillDistance(we_unit, unreal_data)
    local field = WeField.new('Attack1DamageSpillDistance', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1DamageSidesperDie(we_unit, int_data)
    local field = WeField.new('Attack1DamageSidesperDie', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1DamageNumberofDice(we_unit, int_data)
    local field = WeField.new('Attack1DamageNumberofDice', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1DamageLossFactor(we_unit, unreal_data)
    local field = WeField.new('Attack1DamageLossFactor', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1DamageFactorSmall(we_unit, unreal_data)
    local field = WeField.new('Attack1DamageFactorSmall', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1DamageFactorMedium(we_unit, unreal_data)
    local field = WeField.new('Attack1DamageFactorMedium', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1DamageBase(we_unit, int_data)
    local field = WeField.new('Attack1DamageBase', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1CooldownTime(we_unit, unreal_data)
    local field = WeField.new('Attack1CooldownTime', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack2AttackType(we_unit, string_data)
    local field = WeField.new('Attack2AttackType', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1AreaofEffectTargets(we_unit, string_data)
    local field = WeField.new('Attack1AreaofEffectTargets', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1AreaofEffectSmallDamage(we_unit, int_data)
    local field = WeField.new('Attack1AreaofEffectSmallDamage', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1AreaofEffectMediumDamage(we_unit, int_data)
    local field = WeField.new('Attack1AreaofEffectMediumDamage', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1AreaofEffectFullDamage(we_unit, int_data)
    local field = WeField.new('Attack1AreaofEffectFullDamage', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1AnimationDamagePoint(we_unit, unreal_data)
    local field = WeField.new('Attack1AnimationDamagePoint', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAttack1AnimationBackswingPoint(we_unit, unreal_data)
    local field = WeField.new('Attack1AnimationBackswingPoint', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setArmorSoundType(we_unit, string_data)
    local field = WeField.new('ArmorSoundType', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAnimationWalkSpeed(we_unit, real_data)
    local field = WeField.new('AnimationWalkSpeed', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAnimationRunSpeed(we_unit, real_data)
    local field = WeField.new('AnimationRunSpeed', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAnimationCastPoint(we_unit, unreal_data)
    local field = WeField.new('AnimationCastPoint', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAnimationCastBackswing(we_unit, unreal_data)
    local field = WeField.new('AnimationCastBackswing', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAnimationBlendTimeseconds(we_unit, real_data)
    local field = WeField.new('AnimationBlendTimeseconds', 'unit', real_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAllowCustomTeamColor(we_unit, int_data)
    local field = WeField.new('AllowCustomTeamColor', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAIPlacementType(we_unit, string_data)
    local field = WeField.new('AIPlacementType', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAIPlacementRadius(we_unit, unreal_data)
    local field = WeField.new('AIPlacementRadius', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAcquisitionRange(we_unit, unreal_data)
    local field = WeField.new('AcquisitionRange', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTransportedSize(we_unit, int_data)
    local field = WeField.new('TransportedSize', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setLevel(we_unit, int_data)
    local field = WeField.new('Level', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setGroupSeparationPriority(we_unit, int_data)
    local field = WeField.new('GroupSeparationPriority', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setGroupSeparationParameter(we_unit, int_data)
    local field = WeField.new('GroupSeparationParameter', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setGroupSeparationGroupNumber(we_unit, int_data)
    local field = WeField.new('GroupSeparationGroupNumber', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setGroupSeparationEnabled(we_unit, int_data)
    local field = WeField.new('GroupSeparationEnabled', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setFormationRank(we_unit, int_data)
    local field = WeField.new('FormationRank', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setStructuresBuilt(we_unit, string_data)
    local field = WeField.new('StructuresBuilt', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.seteHeroDeathMsg(we_unit, int_data)
    local field = WeField.new('eHeroDeathMsg', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.seteHeroInterfaceIcon(we_unit, int_data)
    local field = WeField.new('eHeroInterfaceIcon', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.seteHeroMinimapDisplay(we_unit, int_data)
    local field = WeField.new('eHeroMinimapDisplay', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTooltipRevive(we_unit, string_data)
    local field = WeField.new('TooltipRevive', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setTooltipAwaken(we_unit, string_data)
    local field = WeField.new('TooltipAwaken', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setStrengthPerLevel(we_unit, unreal_data)
    local field = WeField.new('StrengthPerLevel', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setStartingStrength(we_unit, int_data)
    local field = WeField.new('StartingStrength', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setStartingIntelligence(we_unit, int_data)
    local field = WeField.new('StartingIntelligence', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setStartingAgility(we_unit, int_data)
    local field = WeField.new('StartingAgility', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setProperNamesUsed(we_unit, int_data)
    local field = WeField.new('ProperNamesUsed', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setProperNames(we_unit, string_data)
    local field = WeField.new('ProperNames', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setPrimaryAttribute(we_unit, string_data)
    local field = WeField.new('PrimaryAttribute', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setIntelligencePerLevel(we_unit, unreal_data)
    local field = WeField.new('IntelligencePerLevel', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setHeroRevivalLocations(we_unit, string_data)
    local field = WeField.new('HeroRevivalLocations', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setHeroAbilities(we_unit, string_data)
    local field = WeField.new('HeroAbilities', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setAgilityPerLevel(we_unit, unreal_data)
    local field = WeField.new('AgilityPerLevel', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setCasterUpgradeTips(we_unit, string_data)
    local field = WeField.new('CasterUpgradeTips', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setCasterUpgradeNames(we_unit, string_data)
    local field = WeField.new('CasterUpgradeNames', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setCasterUpgradeArt(we_unit, string_data)
    local field = WeField.new('CasterUpgradeArt', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setUpgradesTo(we_unit, string_data)
    local field = WeField.new('UpgradesTo', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setUnitsTrained(we_unit, string_data)
    local field = WeField.new('UnitsTrained', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRevivesDeadHeros(we_unit, int_data)
    local field = WeField.new('RevivesDeadHeros', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setResearchesAvailable(we_unit, string_data)
    local field = WeField.new('ResearchesAvailable', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setPlacementRequiresWaterRadius(we_unit, unreal_data)
    local field = WeField.new('PlacementRequiresWaterRadius', 'unit', unreal_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setPlacementRequires(we_unit, string_data)
    local field = WeField.new('PlacementRequires', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setPlacementPreventedBy(we_unit, string_data)
    local field = WeField.new('PlacementPreventedBy', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setPathingMap(we_unit, string_data)
    local field = WeField.new('PathingMap', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setNeutralBuildingValidAsRandomBuilding(we_unit, int_data)
    local field = WeField.new('NeutralBuildingValidAsRandomBuilding', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setNeutralBuildingShowsMinimapIcon(we_unit, int_data)
    local field = WeField.new('NeutralBuildingShowsMinimapIcon', 'unit', int_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setItemsMade(we_unit, string_data)
    local field = WeField.new('ItemsMade', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setGroundTexture(we_unit, string_data)
    local field = WeField.new('GroundTexture', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setConstructionSound(we_unit, string_data)
    local field = WeField.new('ConstructionSound', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequierementsForTier1(we_unit, string_data)
    local field = WeField.new('RequierementsForTier1', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequierementsForTier2(we_unit, string_data)
    local field = WeField.new('RequierementsForTier2', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequierementsForTier3(we_unit, string_data)
    local field = WeField.new('RequierementsForTier3', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequierementsForTier4(we_unit, string_data)
    local field = WeField.new('RequierementsForTier4', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequierementsForTier5(we_unit, string_data)
    local field = WeField.new('RequierementsForTier5', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequierementsForTier6(we_unit, string_data)
    local field = WeField.new('RequierementsForTier6', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequierementsForTier7(we_unit, string_data)
    local field = WeField.new('RequierementsForTier7', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequierementsForTier8(we_unit, string_data)
    local field = WeField.new('RequierementsForTier8', 'unit', string_data)
    we_unit.we_obj:addField(field)
end

function WeUnit.setRequierementsForTier9(we_unit, string_data)
    local field = WeField.new('RequierementsForTier9', 'unit', string_data)
    we_unit.we_obj:addField(field)
end


return WeUnit