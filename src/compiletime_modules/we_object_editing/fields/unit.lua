local WeUnitModification = {}

local utils = require('compiletime_modules.we_object_editing.utils')
local field = require('compiletime_modules.we_object_editing.fields.field')

function WeUnitModification.setTooltipExtended(str_data)
    return field.new("utub", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setTooltipBasic(str_data)
    return field.new("utip", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setRequirementsLevels(str_data)
    return field.new("urqa", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setRequirements(str_data)
    return field.new("ureq", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setName(str_data)
    return field.new("unam", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setHotkey(str_data)
    return field.new("uhot", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setDescription(str_data)
    return field.new("ides", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setButtonPositionY(int_data)
    return field.new("ubpy", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setButtonPositionX(int_data)
    return field.new("ubpx", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setItemsSold(str_data)
	return field.new("usei", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setUnitsSold(str_data)
	return field.new("useu", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setHideMinimapDisplay(bool_flag)
	return field.new("uhom", utils.int2byte(bool_flag), 'int')
end

function WeUnitModification.setUseExtendedLineofSight(bool_data)
	return field.new("ulos", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setUseClickHelper(bool_data)
	return field.new("uuch", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setUpgradesUsed(str_data)
	return field.new("upgr", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setUnitSoundSet(str_data)
	return field.new("usnd", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setUnitClassification(str_data)
	return field.new("utyp", utils.str2byte(str_data), 'string')
end

-- foot, horse, fly, hover, float, amph
function WeUnitModification.setMovementType(str_data)
	return field.new("umvt", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setTurnRate(real_data)
	return field.new("umvr", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setTintingColorBlue(int_data)
	return field.new("uclb", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setTintingColorGreen(int_data)
	return field.new("uclg", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setTintingColorRed(int_data)
	return field.new("uclr", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setTilesets(str_data)
	return field.new("util", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setTeamColor(int_data)
	return field.new("utco", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setTargetedAs(str_data)
	return field.new("utar", utils.str2byte(str_data), 'string')
end

--@deprecated("use #setArtTarget() instead")
function WeUnitModification.setTarget(str_data)
	return field.new("utaa", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setArtTarget(str_data)
	return field.new("utaa", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setStockStartDelay(int_data)
	return field.new("usst", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setStockReplenishInterval(int_data)
	return field.new("usrg", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setStockMaximum(int_data)
	return field.new("usma", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setSpeedMinimum(int_data)
	return field.new("umis", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setSpeedMaximum(int_data)
	return field.new("umas", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setSpeedBase(int_data)
	return field.new("umvs", utils.int2byte(int_data), 'int')
end

--@deprecated("use #setArtSpecial() instead")
function WeUnitModification.setSpecial(str_data)
	return field.new("uspa", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setArtSpecial(str_data)
	return field.new("uspa", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setSleeps(bool_data)
	return field.new("usle", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setSightRadiusNight(int_data)
	return field.new("usin", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setSightRadiusDay(int_data)
	return field.new("usid", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setShadowTextureBuilding(str_data)
	return field.new("ushb", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setShadowImageWidth(real_data)
	return field.new("ushw", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setShadowImageUnit(str_data)
	return field.new("ushu", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setShadowImageHeight(real_data)
	return field.new("ushh", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setShadowImageCenterY(real_data)
	return field.new("ushy", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setShadowImageCenterX(real_data)
	return field.new("ushx", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setSelectionScale(real_data)
	return field.new("ussc", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setSelectionCircleOnWater(bool_data)
	return field.new("usew", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setSelectionCircleHeight(real_data)
	return field.new("uslz", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setScalingValue(real_data)
	return field.new("usca", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setScaleProjectiles(bool_data)
	return field.new("uscb", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setRequiredBoneNames(str_data)
	return field.new("ubpr", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setRequiredAttachmentLinkNames(str_data)
	return field.new("ualp", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setRequiredAnimationNamesAttachments(str_data)
	return field.new("uaap", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setRequiredAnimationNames(str_data)
	return field.new("uani", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setRepairTime(int_data)
	return field.new("urtm", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setRepairLumberCost(int_data)
	return field.new("ulur", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setRepairGoldCost(int_data)
	return field.new("ugor", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setRandomSound(str_data)
	return field.new("ursl", utils.str2byte(str_data), 'string')
end

-- commoner, creeps, critters, demon, human, naga, nightelf, orc, other, undead, unknown
function WeUnitModification.setRace(str_data)
	return field.new("urac", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setPropulsionWindowdegrees(real_data)
	return field.new("uprw", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setProjectileLaunchZSwimming(real_data)
	return field.new("ulsz", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setProjectileLaunchZ(real_data)
	return field.new("ulpz", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setProjectileLaunchY(real_data)
	return field.new("ulpy", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setProjectileLaunchX(real_data)
	return field.new("ulpx", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setProjectileImpactZSwimming(real_data)
	return field.new("uisz", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setProjectileImpactZ(real_data)
	return field.new("uimz", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setPriority(int_data)
	return field.new("upri", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setPointValue(int_data)
	return field.new("upoi", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setPlaceableInEditor(bool_data)
	return field.new("uine", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setOrientationInterpolation(int_data)
	return field.new("uori", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setOccluderHeight(real_data)
	return field.new("uocc", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setNormalAbilities(str_data)
	return field.new("uabi", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setNameEditorSuffix(str_data)
	return field.new("unsf", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setMovementSound(str_data)
	return field.new("umsl", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setModelFileExtraVersions(str_data)
	return field.new("uver", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setModelFile(str_data)
	return field.new("umdl", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setMinimumAttackRange(int_data)
	return field.new("uamn", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setMaximumRollAngledegrees(real_data)
	return field.new("umxr", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setMaximumPitchAngledegrees(real_data)
	return field.new("umxp", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setManaRegeneration(real_data)
	return field.new("umpr", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setManaMaximum(int_data)
	return field.new("umpm", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setManaInitialAmount(int_data)
	return field.new("umpi", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setLumberCost(int_data)
	return field.new("ulum", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setSoundLoopingFadeOutRate(int_data)
	return field.new("ulfo", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setSoundLoopingFadeInRate(int_data)
	return field.new("ulfi", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setIsaBuilding(bool_data)
	return field.new("ubdg", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setIconScoreScreen(str_data)
	return field.new("ussi", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setIconGameInterface(str_data)
	return field.new("uico", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setHitPointsRegenerationType(str_data)
	return field.new("uhrt", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setHitPointsRegenerationRate(real_data)
	return field.new("uhpr", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setHitPointsMaximumBase(int_data)
	return field.new("uhpm", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setMovementHeightMinimum(real_data)
	return field.new("umvf", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setMovementHeight(real_data)
	return field.new("umvh", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setHasWaterShadow(bool_data)
	return field.new("ushr", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setHasTilesetSpecificData(bool_data)
	return field.new("utss", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setGoldCost(int_data)
	return field.new("ugol", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setGoldBountyAwardedSidesperDie(int_data)
	return field.new("ubsi", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setGoldBountyAwardedNumberofDice(int_data)
	return field.new("ubdi", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setGoldBountyAwardedBase(int_data)
	return field.new("ubba", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setLumberBountyAwardedSidesperDie(int_data)
	return field.new("ulbs", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setLumberBountyAwardedNumberofDice(int_data)
	return field.new("ulbd", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setLumberBountyAwardedBase(int_data)
	return field.new("ulba", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setFoodProduced(int_data)
	return field.new("ufma", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setFoodCost(int_data)
	return field.new("ufoo", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setFogOfWarSampleRadius(real_data)
	return field.new("ufrd", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setElevationSampleRadius(real_data)
	return field.new("uerd", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setElevationSamplePoints(int_data)
	return field.new("uept", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setDisplayasNeutralHostile(bool_data)
	return field.new("uhos", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setDependencyEquivalents(str_data)
	return field.new("udep", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setDefenseUpgradeBonus(int_data)
	return field.new("udup", utils.int2byte(int_data), 'int')
end
-- normal, small, medium, large, fort, hero, divine, none
function WeUnitModification.setArmorType(str_data)
	return field.new("udty", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setDefenseBase(int_data)
	return field.new("udef", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setDefaultActiveAbility(str_data)
	return field.new("udaa", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setDeathType(int_data)
	return field.new("udea", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setDeathTimeseconds(real_data)
	return field.new("udtm", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setCollisionSize(real_data)
	return field.new("ucol", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setCategorizationSpecial(bool_data)
	return field.new("uspe", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setCategorizationCampaign(bool_data)
	return field.new("ucam", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setCanFlee(bool_data)
	return field.new("ufle", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setCanDropItemsOnDeath(bool_data)
	return field.new("udro", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setBuildTime(int_data)
	return field.new("ubld", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttacksEnabled(int_data)
	return field.new("uaen", utils.int2byte(int_data), 'int')
end

-- normal, instant, artillery, aline, missile, msplash, mbounce, mline, default, _
function WeUnitModification.setAttack2WeaponType(str_data)
	return field.new("ua2w", utils.str2byte(str_data), 'string')
end

-- Nothing, AxeMediumChop, MetalHeavyBash, MetalHeavyChop, MetalHeavySlice,
-- MetalLightChop, MetalLightSlice, MetalMediumBash, MetalMediumChop,
-- MetalMediumSlice, RockHeavyBash, WoodHeavyBash, WoodLightBash, WoodMediumBash
function WeUnitModification.setAttack2WeaponSound(str_data)
	return field.new("ucs2", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAttack2TargetsAllowed(str_data)
	return field.new("ua2g", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAttack2ShowUI(bool_data)
	return field.new("uwu2", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setAttack2RangeMotionBuffer(real_data)
	return field.new("urb2", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack2Range(int_data)
	return field.new("ua2r", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack2ProjectileSpeed(int_data)
	return field.new("ua2z", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack2ProjectileHomingEnabled(bool_data)
	return field.new("umh2", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setAttack2ProjectileArt(str_data)
	return field.new("ua2m", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAttack2ProjectileArc(real_data)
	return field.new("uma2", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack2MaximumNumberofTargets(int_data)
	return field.new("utc2", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack2DamageUpgradeAmount(int_data)
	return field.new("udu2", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack2DamageSpillRadius(real_data)
	return field.new("usr2", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack2DamageSpillDistance(real_data)
	return field.new("usd2", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack2DamageSidesperDie(int_data)
	return field.new("ua2s", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack2DamageNumberofDice(int_data)
	return field.new("ua2d", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack2DamageLossFactor(real_data)
	return field.new("udl2", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack2DamageFactorSmall(real_data)
	return field.new("uqd2", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack2DamageFactorMedium(real_data)
	return field.new("uhd2", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack2DamageBase(int_data)
	return field.new("ua2b", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack2CooldownTime(real_data)
	return field.new("ua2c", utils.float2byte(real_data), 'unreal')
end

-- unknown, normal, pierce, siege, spells, chaos, magic, hero
function WeUnitModification.setAttack2AttackType(str_data)
	return field.new("ua2t", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAttack2AreaofEffectTargets(str_data)
	return field.new("ua2p", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAttack2AreaofEffectSmallDamage(int_data)
	return field.new("ua2q", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack2AreaofEffectMediumDamage(int_data)
	return field.new("ua2h", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack2AreaofEffectFullDamage(int_data)
	return field.new("ua2f", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack2AnimationDamagePoint(real_data)
	return field.new("udp2", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack2AnimationBackswingPoint(real_data)
	return field.new("ubs2", utils.float2byte(real_data), 'unreal')
end

-- normal, instant, artillery, aline, missile, msplash, mbounce, mline, default, _
function WeUnitModification.setAttack2WeaponType(str_data)
	return field.new("ua1w", utils.str2byte(str_data), 'string')
end

-- Nothing, AxeMediumChop, MetalHeavyBash, MetalHeavyChop, MetalHeavySlice,
-- MetalLightChop, MetalLightSlice, MetalMediumBash, MetalMediumChop,
-- MetalMediumSlice, RockHeavyBash, WoodHeavyBash, WoodLightBash, WoodMediumBash
function WeUnitModification.setAttack2WeaponSound(str_data)
	return field.new("ucs1", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAttack1TargetsAllowed(str_data)
	return field.new("ua1g", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAttack1ShowUI(bool_data)
	return field.new("uwu1", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setAttack1RangeMotionBuffer(real_data)
	return field.new("urb1", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack1Range(int_data)
	return field.new("ua1r", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack1ProjectileSpeed(int_data)
	return field.new("ua1z", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack1ProjectileHomingEnabled(bool_data)
	return field.new("umh1", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setAttack1ProjectileArt(str_data)
	return field.new("ua1m", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAttack1ProjectileArc(real_data)
	return field.new("uma1", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack1MaximumNumberofTargets(int_data)
	return field.new("utc1", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack1DamageUpgradeAmount(int_data)
	return field.new("udu1", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack1DamageSpillRadius(real_data)
	return field.new("usr1", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack1DamageSpillDistance(real_data)
	return field.new("usd1", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack1DamageSidesperDie(int_data)
	return field.new("ua1s", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack1DamageNumberofDice(int_data)
	return field.new("ua1d", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack1DamageLossFactor(real_data)
	return field.new("udl1", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack1DamageFactorSmall(real_data)
	return field.new("uqd1", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack1DamageFactorMedium(real_data)
	return field.new("uhd1", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack1DamageBase(int_data)
	return field.new("ua1b", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack1CooldownTime(real_data)
	return field.new("ua1c", utils.float2byte(real_data), 'unreal')
end

-- unknown, normal, pierce, siege, spells, chaos, magic, hero
function WeUnitModification.setAttack2AttackType(str_data)
	return field.new("ua1t", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAttack1AreaofEffectTargets(str_data)
	return field.new("ua1p", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAttack1AreaofEffectSmallDamage(int_data)
	return field.new("ua1q", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack1AreaofEffectMediumDamage(int_data)
	return field.new("ua1h", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack1AreaofEffectFullDamage(int_data)
	return field.new("ua1f", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setAttack1AnimationDamagePoint(real_data)
	return field.new("udp1", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAttack1AnimationBackswingPoint(real_data)
	return field.new("ubs1", utils.float2byte(real_data), 'unreal')
end

-- Ethereal, Flesh, Wood, Stone, Metal
function WeUnitModification.setArmorSoundType(str_data)
	return field.new("uarm", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAnimationWalkSpeed(real_data)
	return field.new("uwal", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setAnimationRunSpeed(real_data)
	return field.new("urun", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setAnimationCastPoint(real_data)
	return field.new("ucpt", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAnimationCastBackswing(real_data)
	return field.new("ucbs", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAnimationBlendTimeseconds(real_data)
	return field.new("uble", utils.float2byte(real_data), 'real')
end

function WeUnitModification.setAllowCustomTeamColor(bool_data)
	return field.new("utcc", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setAIPlacementType(str_data)
	return field.new("uabt", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAIPlacementRadius(real_data)
	return field.new("uabr", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setAcquisitionRange(real_data)
	return field.new("uacq", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setTransportedSize(int_data)
	return field.new("ucar", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setLevel(int_data)
	return field.new("ulev", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setGroupSeparationPriority(int_data)
	return field.new("urpr", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setGroupSeparationParameter(int_data)
	return field.new("urpp", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setGroupSeparationGroupNumber(int_data)
	return field.new("urpg", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setGroupSeparationEnabled(bool_data)
	return field.new("urpo", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setFormationRank(int_data)
	return field.new("ufor", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setStructuresBuilt(str_data)
	return field.new("ubui", utils.str2byte(str_data), 'string')
end

function WeUnitModification.hideHeroDeathMsg(bool_flag)
	return field.new("uhhd", utils.int2byte(bool_flag), 'int')
end

function WeUnitModification.hideHeroInterfaceIcon(bool_flag)
	return field.new("uhhb", utils.int2byte(bool_flag), 'int')
end

function WeUnitModification.hideHeroMinimapDisplay(bool_flag)
	return field.new("uhhm", utils.int2byte(bool_flag), 'int')
end

function WeUnitModification.setTooltipRevive(str_data)
	return field.new("utpr", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setTooltipAwaken(str_data)
	return field.new("uawt", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setStrengthPerLevel(real_data)
	return field.new("ustp", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setStartingStrength(int_data)
	return field.new("ustr", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setStartingIntelligence(int_data)
	return field.new("uint", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setStartingAgility(int_data)
	return field.new("uagi", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setProperNamesUsed(int_data)
	return field.new("upru", utils.int2byte(int_data), 'int')
end

function WeUnitModification.setProperNames(str_data)
	return field.new("upro", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setPrimaryAttribute(str_data)
	return field.new("upra", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setIntelligencePerLevel(real_data)
	return field.new("uinp", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setHeroRevivalLocations(str_data)
	return field.new("urva", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setHeroAbilities(str_data)
	return field.new("uhab", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setAgilityPerLevel(real_data)
	return field.new("uagp", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setCasterUpgradeTips(str_data)
	return field.new("ucut", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setCasterUpgradeNames(str_data)
	return field.new("ucun", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setCasterUpgradeArt(str_data)
	return field.new("ucua", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setUpgradesTo(str_data)
	return field.new("uupt", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setUnitsTrained(str_data)
	return field.new("utra", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setRevivesDeadHeros(bool_data)
	return field.new("urev", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setResearchesAvailable(str_data)
	return field.new("ures", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setPlacementRequiresWaterRadius(real_data)
	return field.new("upaw", utils.float2byte(real_data), 'unreal')
end

function WeUnitModification.setPlacementRequires(str_data)
	return field.new("upap", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setPlacementPreventedBy(str_data)
	return field.new("upar", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setPathingMap(str_data)
	return field.new("upat", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setNeutralBuildingValidAsRandomBuilding(bool_data)
	return field.new("unbr", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setNeutralBuildingShowsMinimapIcon(bool_data)
	return field.new("unbm", utils.int2byte(bool_data), 'int')
end

function WeUnitModification.setItemsMade(str_data)
	return field.new("umki", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setGroundTexture(str_data)
	return field.new("uubs", utils.str2byte(str_data), 'string')
end

function WeUnitModification.setConstructionSound(str_data)
	return field.new("ubsl", utils.str2byte(str_data), 'string')
end



--function setRequierementsForTier(int tier, str_data)
--	utils.str2byte(str_switch tier, 'string')
--		case 2
--			def.setString("urq1", data)
--		case 3
--			def.setString("urq2", data)
--		case 4
--			def.setString("urq3", data)
--		case 5
--			def.setString("urq4", data)
--		case 6
--			def.setString("urq5", data)
--		case 7
--			def.setString("urq6", data)
--		case 8
--			def.setString("urq7", data)
--		case 9
--			def.setString("urq8", data)
--		default

return WeUnitModification