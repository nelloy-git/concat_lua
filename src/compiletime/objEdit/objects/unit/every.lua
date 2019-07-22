local WeEveryUnit = {}

local WeField = require(CurrentLib..'.we_field')
local WeObject = require(CurrentLib..'.objects.we_object')
setmetatable(WeEveryUnit, {__index = WeObject})

function WeEveryUnit.new(id, base_id)
    local we_unit = WeObject.new(id, base_id, 'unit')
    setmetatable(we_unit, {__index = WeEveryUnit})
    return we_unit
end

function WeEveryUnit:setTooltipExtended(string_data)
	self:addField(WeField.new("utub", 'string', nil, nil, string_data))
end

function WeEveryUnit:setTooltipBasic(string_data)
	self:addField(WeField.new("utip", 'string', nil, nil, string_data))
end

function WeEveryUnit:setRequirementsLevels(string_data)
	self:addField(WeField.new("urqa", 'string', nil, nil, string_data))
end

function WeEveryUnit:setRequirements(string_data)
	self:addField(WeField.new("ureq", 'string', nil, nil, string_data))
end

function WeEveryUnit:setName(string_data)
	self:addField(WeField.new("unam", 'string', nil, nil, string_data))
end

function WeEveryUnit:setHotkey(string_data)
	self:addField(WeField.new("uhot", 'string', nil, nil, string_data))
end

function WeEveryUnit:setDescription(string_data)
	self:addField(WeField.new("ides", 'string', nil, nil, string_data))
end

function WeEveryUnit:setButtonPositionY(int_data)
	self:addField(WeField.new("ubpy", 'int', nil, nil, int_data))
end

function WeEveryUnit:setButtonPositionX(int_data)
	self:addField(WeField.new("ubpx", 'int', nil, nil, int_data))
end

function WeEveryUnit:setItemsSold(string_data)
	self:addField(WeField.new("usei", 'string', nil, nil, string_data))
end

function WeEveryUnit:setUnitsSold(string_data)
	self:addField(WeField.new("useu", 'string', nil, nil, string_data))
end

function WeEveryUnit:setHideMinimapDisplay(bool_data)
	self:addField(WeField.new("uhom", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setUseExtendedLineofSight(bool_data)
	self:addField(WeField.new("ulos", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setUseClickHelper(bool_data)
	self:addField(WeField.new("uuch", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setUpgradesUsed(string_data)
	self:addField(WeField.new("upgr", 'string', nil, nil, string_data))
end

function WeEveryUnit:setUnitSoundSet(string_data)
	self:addField(WeField.new("usnd", 'string', nil, nil, string_data))
end

function WeEveryUnit:setUnitClassification(string_data)
	self:addField(WeField.new("utyp", 'string', nil, nil, string_data))
end

-- "horse", "fly", "hover", "float", "amph"
function WeEveryUnit:setMovementType(string_data)
	self:addField(WeField.new("umvt", 'MovementType_', nil, nil, string_data))
end

function WeEveryUnit:setTurnRate(real_data)
	self:addField(WeField.new("umvr", 'real', nil, nil, real_data))
end

function WeEveryUnit:setTintingColorBlue(int_data)
	self:addField(WeField.new("uclb", 'int', nil, nil, int_data))
end

function WeEveryUnit:setTintingColorGreen(int_data)
	self:addField(WeField.new("uclg", 'int', nil, nil, int_data))
end

function WeEveryUnit:setTintingColorRed(int_data)
	self:addField(WeField.new("uclr", 'int', nil, nil, int_data))
end

function WeEveryUnit:setTilesets(string_data)
	self:addField(WeField.new("util", 'string', nil, nil, string_data))
end

function WeEveryUnit:setTeamColor(int_data)
	self:addField(WeField.new("utco", 'int', nil, nil, int_data))
end

function WeEveryUnit:setTargetedAs(string_data)
	self:addField(WeField.new("utar", 'string', nil, nil, string_data))
end

function WeEveryUnit:setArtTarget(string_data)
	self:addField(WeField.new("utaa", 'string', nil, nil, string_data))
end

function WeEveryUnit:setStockStartDelay(int_data)
	self:addField(WeField.new("usst", 'int', nil, nil, int_data))
end

function WeEveryUnit:setStockReplenishInterval(int_data)
	self:addField(WeField.new("usrg", 'int', nil, nil, int_data))
end

function WeEveryUnit:setStockMaximum(int_data)
	self:addField(WeField.new("usma", 'int', nil, nil, int_data))
end

function WeEveryUnit:setSpeedMinimum(int_data)
	self:addField(WeField.new("umis", 'int', nil, nil, int_data))
end

function WeEveryUnit:setSpeedMaximum(int_data)
	self:addField(WeField.new("umas", 'int', nil, nil, int_data))
end

function WeEveryUnit:setSpeedBase(int_data)
	self:addField(WeField.new("umvs", 'int', nil, nil, int_data))
end

function WeEveryUnit:setArtSpecial(string_data)
	self:addField(WeField.new("uspa", 'string', nil, nil, string_data))
end

function WeEveryUnit:setSleeps(bool_data)
	self:addField(WeField.new("usle", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setSightRadiusNight(int_data)
	self:addField(WeField.new("usin", 'int', nil, nil, int_data))
end

function WeEveryUnit:setSightRadiusDay(int_data)
	self:addField(WeField.new("usid", 'int', nil, nil, int_data))
end

function WeEveryUnit:setShadowTextureBuilding(string_data)
	self:addField(WeField.new("ushb", 'string', nil, nil, string_data))
end

function WeEveryUnit:setShadowImageWidth(real_data)
	self:addField(WeField.new("ushw", 'real', nil, nil, real_data))
end

function WeEveryUnit:setShadowImageUnit(string_data)
	self:addField(WeField.new("ushu", 'string', nil, nil, string_data))
end

function WeEveryUnit:setShadowImageHeight(real_data)
	self:addField(WeField.new("ushh", 'real', nil, nil, real_data))
end

function WeEveryUnit:setShadowImageCenterY(real_data)
	self:addField(WeField.new("ushy", 'real', nil, nil, real_data))
end

function WeEveryUnit:setShadowImageCenterX(real_data)
	self:addField(WeField.new("ushx", 'real', nil, nil, real_data))
end

function WeEveryUnit:setSelectionScale(real_data)
	self:addField(WeField.new("ussc", 'real', nil, nil, real_data))
end

function WeEveryUnit:setSelectionCircleOnWater(bool_data)
	self:addField(WeField.new("usew", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setSelectionCircleHeight(real_data)
	self:addField(WeField.new("uslz", 'real', nil, nil, real_data))
end

function WeEveryUnit:setScalingValue(real_data)
	self:addField(WeField.new("usca", 'real', nil, nil, real_data))
end

function WeEveryUnit:setScaleProjectiles(bool_data)
	self:addField(WeField.new("uscb", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setRequiredBoneNames(string_data)
	self:addField(WeField.new("ubpr", 'string', nil, nil, string_data))
end

function WeEveryUnit:setRequiredAttachmentLinkNames(string_data)
	self:addField(WeField.new("ualp", 'string', nil, nil, string_data))
end

function WeEveryUnit:setRequiredAnimationNamesAttachments(string_data)
	self:addField(WeField.new("uaap", 'string', nil, nil, string_data))
end

function WeEveryUnit:setRequiredAnimationNames(string_data)
	self:addField(WeField.new("uani", 'string', nil, nil, string_data))
end

function WeEveryUnit:setRepairTime(int_data)
	self:addField(WeField.new("urtm", 'int', nil, nil, int_data))
end

function WeEveryUnit:setRepairLumberCost(int_data)
	self:addField(WeField.new("ulur", 'int', nil, nil, int_data))
end

function WeEveryUnit:setRepairGoldCost(int_data)
	self:addField(WeField.new("ugor", 'int', nil, nil, int_data))
end

function WeEveryUnit:setRandomSound(string_data)
	self:addField(WeField.new("ursl", 'string', nil, nil, string_data))
end

-- function WeEveryUnit:setRace(Race_data)
-- 	self:addField(WeField.new("urac", 'Race', nil, nil, Race_data))
-- end

function WeEveryUnit:setPropulsionWindowdegrees(real_data)
	self:addField(WeField.new("uprw", 'real', nil, nil, real_data))
end

function WeEveryUnit:setProjectileLaunchZSwimming(real_data)
	self:addField(WeField.new("ulsz", 'real', nil, nil, real_data))
end

function WeEveryUnit:setProjectileLaunchZ(real_data)
	self:addField(WeField.new("ulpz", 'real', nil, nil, real_data))
end

function WeEveryUnit:setProjectileLaunchY(real_data)
	self:addField(WeField.new("ulpy", 'real', nil, nil, real_data))
end

function WeEveryUnit:setProjectileLaunchX(real_data)
	self:addField(WeField.new("ulpx", 'real', nil, nil, real_data))
end

function WeEveryUnit:setProjectileImpactZSwimming(real_data)
	self:addField(WeField.new("uisz", 'real', nil, nil, real_data))
end

function WeEveryUnit:setProjectileImpactZ(real_data)
	self:addField(WeField.new("uimz", 'real', nil, nil, real_data))
end

function WeEveryUnit:setPriority(int_data)
	self:addField(WeField.new("upri", 'int', nil, nil, int_data))
end

function WeEveryUnit:setPointValue(int_data)
	self:addField(WeField.new("upoi", 'int', nil, nil, int_data))
end

function WeEveryUnit:setPlaceableInEditor(bool_data)
	self:addField(WeField.new("uine", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setOrientationInterpolation(int_data)
	self:addField(WeField.new("uori", 'int', nil, nil, int_data))
end

function WeEveryUnit:setOccluderHeight(real_data)
	self:addField(WeField.new("uocc", 'real', nil, nil, real_data))
end

function WeEveryUnit:setNormalAbilities(string_data)
	self:addField(WeField.new("uabi", 'string', nil, nil, string_data))
end

function WeEveryUnit:setNameEditorSuffix(string_data)
	self:addField(WeField.new("unsf", 'string', nil, nil, string_data))
end

function WeEveryUnit:setMovementSound(string_data)
	self:addField(WeField.new("umsl", 'string', nil, nil, string_data))
end

function WeEveryUnit:setModelFileExtraVersions(string_data)
	self:addField(WeField.new("uver", 'string', nil, nil, string_data))
end

function WeEveryUnit:setModelFile(string_data)
	self:addField(WeField.new("umdl", 'string', nil, nil, string_data))
end

function WeEveryUnit:setMinimumAttackRange(int_data)
	self:addField(WeField.new("uamn", 'int', nil, nil, int_data))
end

function WeEveryUnit:setMaximumRollAngledegrees(real_data)
	self:addField(WeField.new("umxr", 'real', nil, nil, real_data))
end

function WeEveryUnit:setMaximumPitchAngledegrees(real_data)
	self:addField(WeField.new("umxp", 'real', nil, nil, real_data))
end

function WeEveryUnit:setManaRegeneration(real_data)
	self:addField(WeField.new("umpr", 'real', nil, nil, real_data))
end

function WeEveryUnit:setManaMaximum(int_data)
	self:addField(WeField.new("umpm", 'int', nil, nil, int_data))
end

function WeEveryUnit:setManaInitialAmount(int_data)
	self:addField(WeField.new("umpi", 'int', nil, nil, int_data))
end

function WeEveryUnit:setLumberCost(int_data)
	self:addField(WeField.new("ulum", 'int', nil, nil, int_data))
end

function WeEveryUnit:setSoundLoopingFadeOutRate(int_data)
	self:addField(WeField.new("ulfo", 'int', nil, nil, int_data))
end

function WeEveryUnit:setSoundLoopingFadeInRate(int_data)
	self:addField(WeField.new("ulfi", 'int', nil, nil, int_data))
end

function WeEveryUnit:setIsaBuilding(bool_data)
	self:addField(WeField.new("ubdg", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setIconScoreScreen(string_data)
	self:addField(WeField.new("ussi", 'string', nil, nil, string_data))
end

function WeEveryUnit:setIconGameInterface(string_data)
	self:addField(WeField.new("uico", 'string', nil, nil, string_data))
end

function WeEveryUnit:setHitPointsRegenerationType(string_data)
	self:addField(WeField.new("uhrt", 'string', nil, nil, string_data))
end

function WeEveryUnit:setHitPointsRegenerationRate(real_data)
	self:addField(WeField.new("uhpr", 'real', nil, nil, real_data))
end

function WeEveryUnit:setHitPointsMaximumBase(int_data)
	self:addField(WeField.new("uhpm", 'int', nil, nil, int_data))
end

function WeEveryUnit:setMovementHeightMinimum(real_data)
	self:addField(WeField.new("umvf", 'real', nil, nil, real_data))
end

function WeEveryUnit:setMovementHeight(real_data)
	self:addField(WeField.new("umvh", 'real', nil, nil, real_data))
end

function WeEveryUnit:setHasWaterShadow(bool_data)
	self:addField(WeField.new("ushr", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setHasTilesetSpecificData(bool_data)
	self:addField(WeField.new("utss", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setGoldCost(int_data)
	self:addField(WeField.new("ugol", 'int', nil, nil, int_data))
end

function WeEveryUnit:setGoldBountyAwardedSidesperDie(int_data)
	self:addField(WeField.new("ubsi", 'int', nil, nil, int_data))
end

function WeEveryUnit:setGoldBountyAwardedNumberofDice(int_data)
	self:addField(WeField.new("ubdi", 'int', nil, nil, int_data))
end

function WeEveryUnit:setGoldBountyAwardedBase(int_data)
	self:addField(WeField.new("ubba", 'int', nil, nil, int_data))
end

function WeEveryUnit:setLumberBountyAwardedSidesperDie(int_data)
	self:addField(WeField.new("ulbs", 'int', nil, nil, int_data))
end

function WeEveryUnit:setLumberBountyAwardedNumberofDice(int_data)
	self:addField(WeField.new("ulbd", 'int', nil, nil, int_data))
end

function WeEveryUnit:setLumberBountyAwardedBase(int_data)
	self:addField(WeField.new("ulba", 'int', nil, nil, int_data))
end

function WeEveryUnit:setFoodProduced(int_data)
	self:addField(WeField.new("ufma", 'int', nil, nil, int_data))
end

function WeEveryUnit:setFoodCost(int_data)
	self:addField(WeField.new("ufoo", 'int', nil, nil, int_data))
end

function WeEveryUnit:setFogOfWarSampleRadius(real_data)
	self:addField(WeField.new("ufrd", 'real', nil, nil, real_data))
end

function WeEveryUnit:setElevationSampleRadius(real_data)
	self:addField(WeField.new("uerd", 'real', nil, nil, real_data))
end

function WeEveryUnit:setElevationSamplePoints(int_data)
	self:addField(WeField.new("uept", 'int', nil, nil, int_data))
end

function WeEveryUnit:setDisplayasNeutralHostile(bool_data)
	self:addField(WeField.new("uhos", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setDependencyEquivalents(string_data)
	self:addField(WeField.new("udep", 'string', nil, nil, string_data))
end

function WeEveryUnit:setDefenseUpgradeBonus(int_data)
	self:addField(WeField.new("udup", 'int', nil, nil, int_data))
end

-- "normal", "small", "medium", "large", "fort", "hero", "divine", "none"
function WeEveryUnit:setArmorType(string_data)
	self:addField(WeField.new("udty", 'string', nil, nil, string_data))
end

function WeEveryUnit:setDefenseBase(int_data)
	self:addField(WeField.new("udef", 'int', nil, nil, int_data))
end

function WeEveryUnit:setDefaultActiveAbility(string_data)
	self:addField(WeField.new("udaa", 'string', nil, nil, string_data))
end

function WeEveryUnit:setDeathType(int_data)
	self:addField(WeField.new("udea", 'int', nil, nil, int_data))
end

function WeEveryUnit:setDeathTimeseconds(real_data)
	self:addField(WeField.new("udtm", 'real', nil, nil, real_data))
end

function WeEveryUnit:setCollisionSize(real_data)
	self:addField(WeField.new("ucol", 'real', nil, nil, real_data))
end

function WeEveryUnit:setCategorizationSpecial(bool_data)
	self:addField(WeField.new("uspe", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setCategorizationCampaign(bool_data)
	self:addField(WeField.new("ucam", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setCanFlee(bool_data)
	self:addField(WeField.new("ufle", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setCanDropItemsOnDeath(bool_data)
	self:addField(WeField.new("udro", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setBuildTime(int_data)
	self:addField(WeField.new("ubld", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttacksEnabled(int_data)
	self:addField(WeField.new("uaen", 'int', nil, nil, int_data))
end

-- "normal", "instant", "artillery", "aline", "missile", "msplash", "mbounce", "mline", "_"
function WeEveryUnit:setAttack2WeaponType(string_data)
	self:addField(WeField.new("ua2w", 'string', nil, nil, string_data))
end

-- "Nothing", "AxeMediumChop", "MetalHeavyBash", "MetalHeavyChop", "MetalHeavySlice",
-- "MetalLightChop", "MetalLightSlice", "MetalMediumBash", "MetalMediumChop",
-- "MetalMediumSlice", "RockHeavyBash", "WoodHeavyBash", "WoodLightBash", "WoodMediumBash"
function WeEveryUnit:setAttack2WeaponSound(string_data)
	self:addField(WeField.new("ucs2", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAttack2TargetsAllowed(string_data)
	self:addField(WeField.new("ua2g", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAttack2ShowUI(bool_data)
	self:addField(WeField.new("uwu2", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setAttack2RangeMotionBuffer(real_data)
	self:addField(WeField.new("urb2", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack2Range(int_data)
	self:addField(WeField.new("ua2r", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack2ProjectileSpeed(int_data)
	self:addField(WeField.new("ua2z", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack2ProjectileHomingEnabled(bool_data)
	self:addField(WeField.new("umh2", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setAttack2ProjectileArt(string_data)
	self:addField(WeField.new("ua2m", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAttack2ProjectileArc(real_data)
	self:addField(WeField.new("uma2", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack2MaximumNumberofTargets(int_data)
	self:addField(WeField.new("utc2", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack2DamageUpgradeAmount(int_data)
	self:addField(WeField.new("udu2", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack2DamageSpillRadius(real_data)
	self:addField(WeField.new("usr2", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack2DamageSpillDistance(real_data)
	self:addField(WeField.new("usd2", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack2DamageSidesperDie(int_data)
	self:addField(WeField.new("ua2s", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack2DamageNumberofDice(int_data)
	self:addField(WeField.new("ua2d", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack2DamageLossFactor(real_data)
	self:addField(WeField.new("udl2", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack2DamageFactorSmall(real_data)
	self:addField(WeField.new("uqd2", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack2DamageFactorMedium(real_data)
	self:addField(WeField.new("uhd2", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack2DamageBase(int_data)
	self:addField(WeField.new("ua2b", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack2CooldownTime(real_data)
	self:addField(WeField.new("ua2c", 'real', nil, nil, real_data))
end

-- "unknown", "normal", "pierce", "siege", "spells", "chaos", "magic", "hero"
function WeEveryUnit:setAttack2AttackType(string_data)
	self:addField(WeField.new("ua2t", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAttack2AreaofEffectTargets(string_data)
	self:addField(WeField.new("ua2p", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAttack2AreaofEffectSmallDamage(int_data)
	self:addField(WeField.new("ua2q", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack2AreaofEffectMediumDamage(int_data)
	self:addField(WeField.new("ua2h", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack2AreaofEffectFullDamage(int_data)
	self:addField(WeField.new("ua2f", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack2AnimationDamagePoint(real_data)
	self:addField(WeField.new("udp2", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack2AnimationBackswingPoint(real_data)
	self:addField(WeField.new("ubs2", 'real', nil, nil, real_data))
end

-- "normal", "instant", "artillery", "aline", "missile", "msplash", "mbounce", "mline", "_"
function WeEveryUnit:setAttack1WeaponType(string_data)
	self:addField(WeField.new("ua1w", 'string', nil, nil, string_data))
end

-- "Nothing", "AxeMediumChop", "MetalHeavyBash", "MetalHeavyChop", "MetalHeavySlice",
-- "MetalLightChop", "MetalLightSlice", "MetalMediumBash", "MetalMediumChop",
-- "MetalMediumSlice", "RockHeavyBash", "WoodHeavyBash", "WoodLightBash", "WoodMediumBash"
function WeEveryUnit:setAttack1WeaponSound(string_data)
	self:addField(WeField.new("ucs1", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAttack1TargetsAllowed(string_data)
	self:addField(WeField.new("ua1g", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAttack1ShowUI(bool_data)
	self:addField(WeField.new("uwu1", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setAttack1RangeMotionBuffer(real_data)
	self:addField(WeField.new("urb1", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack1Range(int_data)
	self:addField(WeField.new("ua1r", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack1ProjectileSpeed(int_data)
	self:addField(WeField.new("ua1z", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack1ProjectileHomingEnabled(bool_data)
	self:addField(WeField.new("umh1", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setAttack1ProjectileArt(string_data)
	self:addField(WeField.new("ua1m", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAttack1ProjectileArc(real_data)
	self:addField(WeField.new("uma1", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack1MaximumNumberofTargets(int_data)
	self:addField(WeField.new("utc1", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack1DamageUpgradeAmount(int_data)
	self:addField(WeField.new("udu1", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack1DamageSpillRadius(real_data)
	self:addField(WeField.new("usr1", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack1DamageSpillDistance(real_data)
	self:addField(WeField.new("usd1", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack1DamageSidesperDie(int_data)
	self:addField(WeField.new("ua1s", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack1DamageNumberofDice(int_data)
	self:addField(WeField.new("ua1d", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack1DamageLossFactor(real_data)
	self:addField(WeField.new("udl1", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack1DamageFactorSmall(real_data)
	self:addField(WeField.new("uqd1", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack1DamageFactorMedium(real_data)
	self:addField(WeField.new("uhd1", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack1DamageBase(int_data)
	self:addField(WeField.new("ua1b", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack1CooldownTime(real_data)
	self:addField(WeField.new("ua1c", 'real', nil, nil, real_data))
end

-- "unknown", "normal", "pierce", "siege", "spells", "chaos", "magic", "hero"
function WeEveryUnit:setAttack1AttackType(string_data)
	self:addField(WeField.new("ua1t", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAttack1AreaofEffectTargets(string_data)
	self:addField(WeField.new("ua1p", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAttack1AreaofEffectSmallDamage(int_data)
	self:addField(WeField.new("ua1q", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack1AreaofEffectMediumDamage(int_data)
	self:addField(WeField.new("ua1h", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack1AreaofEffectFullDamage(int_data)
	self:addField(WeField.new("ua1f", 'int', nil, nil, int_data))
end

function WeEveryUnit:setAttack1AnimationDamagePoint(real_data)
	self:addField(WeField.new("udp1", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAttack1AnimationBackswingPoint(real_data)
	self:addField(WeField.new("ubs1", 'real', nil, nil, real_data))
end

-- "Ethereal", "Flesh", "Wood", "Stone", "Metal"
function WeEveryUnit:setArmorSoundType(string_data)
	self:addField(WeField.new("uarm", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAnimationWalkSpeed(real_data)
	self:addField(WeField.new("uwal", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAnimationRunSpeed(real_data)
	self:addField(WeField.new("urun", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAnimationCastPoint(real_data)
	self:addField(WeField.new("ucpt", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAnimationCastBackswing(real_data)
	self:addField(WeField.new("ucbs", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAnimationBlendTimeseconds(real_data)
	self:addField(WeField.new("uble", 'real', nil, nil, real_data))
end

function WeEveryUnit:setAllowCustomTeamColor(bool_data)
	self:addField(WeField.new("utcc", 'bool', nil, nil, bool_data))
end

function WeEveryUnit:setAIPlacementType(string_data)
	self:addField(WeField.new("uabt", 'string', nil, nil, string_data))
end

function WeEveryUnit:setAIPlacementRadius(real_data)
	self:addField(WeField.new("uabr", 'real', nil, nil, real_data))
end

return WeEveryUnit
