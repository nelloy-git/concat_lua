local WeField = require(CurrentLib..'.weField') ---@type WeField
local WeFile = require(CurrentLib..'.weFile')   ---@type WeFile
local WeObject = require(CurrentLib..'.objects.weObject')

---@class AnyWeUnit : WeObject
local AnyWeUnit = {}
setmetatable(AnyWeUnit, {__index = WeObject})

function AnyWeUnit.new(id, base_id)
    local we_unit = WeObject.new(id, base_id, 'unit')
    setmetatable(we_unit, {__index = AnyWeUnit})
    WeFile.units:add(we_unit)
    return we_unit
end

function AnyWeUnit:setTooltipExtended(string_data)
	self:addField(WeField.new("utub", 'string', nil, nil, string_data))
end

function AnyWeUnit:setTooltipBasic(string_data)
	self:addField(WeField.new("utip", 'string', nil, nil, string_data))
end

function AnyWeUnit:setRequirementsLevels(string_data)
	self:addField(WeField.new("urqa", 'string', nil, nil, string_data))
end

function AnyWeUnit:setRequirements(string_data)
	self:addField(WeField.new("ureq", 'string', nil, nil, string_data))
end

function AnyWeUnit:setName(string_data)
	self:addField(WeField.new("unam", 'string', nil, nil, string_data))
end

function AnyWeUnit:setHotkey(string_data)
	self:addField(WeField.new("uhot", 'string', nil, nil, string_data))
end

function AnyWeUnit:setDescription(string_data)
	self:addField(WeField.new("ides", 'string', nil, nil, string_data))
end

function AnyWeUnit:setButtonPositionY(int_data)
	self:addField(WeField.new("ubpy", 'int', nil, nil, int_data))
end

function AnyWeUnit:setButtonPositionX(int_data)
	self:addField(WeField.new("ubpx", 'int', nil, nil, int_data))
end

function AnyWeUnit:setItemsSold(string_data)
	self:addField(WeField.new("usei", 'string', nil, nil, string_data))
end

function AnyWeUnit:setUnitsSold(string_data)
	self:addField(WeField.new("useu", 'string', nil, nil, string_data))
end

function AnyWeUnit:setHideMinimapDisplay(bool_data)
	self:addField(WeField.new("uhom", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setUseExtendedLineofSight(bool_data)
	self:addField(WeField.new("ulos", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setUseClickHelper(bool_data)
	self:addField(WeField.new("uuch", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setUpgradesUsed(string_data)
	self:addField(WeField.new("upgr", 'string', nil, nil, string_data))
end

function AnyWeUnit:setUnitSoundSet(string_data)
	self:addField(WeField.new("usnd", 'string', nil, nil, string_data))
end

function AnyWeUnit:setUnitClassification(string_data)
	self:addField(WeField.new("utyp", 'string', nil, nil, string_data))
end

-- "horse", "fly", "hover", "float", "amph"
function AnyWeUnit:setMovementType(string_data)
	self:addField(WeField.new("umvt", 'MovementType_', nil, nil, string_data))
end

function AnyWeUnit:setTurnRate(real_data)
	self:addField(WeField.new("umvr", 'real', nil, nil, real_data))
end

function AnyWeUnit:setTintingColorBlue(int_data)
	self:addField(WeField.new("uclb", 'int', nil, nil, int_data))
end

function AnyWeUnit:setTintingColorGreen(int_data)
	self:addField(WeField.new("uclg", 'int', nil, nil, int_data))
end

function AnyWeUnit:setTintingColorRed(int_data)
	self:addField(WeField.new("uclr", 'int', nil, nil, int_data))
end

function AnyWeUnit:setTilesets(string_data)
	self:addField(WeField.new("util", 'string', nil, nil, string_data))
end

function AnyWeUnit:setTeamColor(int_data)
	self:addField(WeField.new("utco", 'int', nil, nil, int_data))
end

function AnyWeUnit:setTargetedAs(string_data)
	self:addField(WeField.new("utar", 'string', nil, nil, string_data))
end

function AnyWeUnit:setArtTarget(string_data)
	self:addField(WeField.new("utaa", 'string', nil, nil, string_data))
end

function AnyWeUnit:setStockStartDelay(int_data)
	self:addField(WeField.new("usst", 'int', nil, nil, int_data))
end

function AnyWeUnit:setStockReplenishInterval(int_data)
	self:addField(WeField.new("usrg", 'int', nil, nil, int_data))
end

function AnyWeUnit:setStockMaximum(int_data)
	self:addField(WeField.new("usma", 'int', nil, nil, int_data))
end

function AnyWeUnit:setSpeedMinimum(int_data)
	self:addField(WeField.new("umis", 'int', nil, nil, int_data))
end

function AnyWeUnit:setSpeedMaximum(int_data)
	self:addField(WeField.new("umas", 'int', nil, nil, int_data))
end

function AnyWeUnit:setSpeedBase(int_data)
	self:addField(WeField.new("umvs", 'int', nil, nil, int_data))
end

function AnyWeUnit:setArtSpecial(string_data)
	self:addField(WeField.new("uspa", 'string', nil, nil, string_data))
end

function AnyWeUnit:setSleeps(bool_data)
	self:addField(WeField.new("usle", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setSightRadiusNight(int_data)
	self:addField(WeField.new("usin", 'int', nil, nil, int_data))
end

function AnyWeUnit:setSightRadiusDay(int_data)
	self:addField(WeField.new("usid", 'int', nil, nil, int_data))
end

function AnyWeUnit:setShadowTextureBuilding(string_data)
	self:addField(WeField.new("ushb", 'string', nil, nil, string_data))
end

function AnyWeUnit:setShadowImageWidth(real_data)
	self:addField(WeField.new("ushw", 'real', nil, nil, real_data))
end

function AnyWeUnit:setShadowImageUnit(string_data)
	self:addField(WeField.new("ushu", 'string', nil, nil, string_data))
end

function AnyWeUnit:setShadowImageHeight(real_data)
	self:addField(WeField.new("ushh", 'real', nil, nil, real_data))
end

function AnyWeUnit:setShadowImageCenterY(real_data)
	self:addField(WeField.new("ushy", 'real', nil, nil, real_data))
end

function AnyWeUnit:setShadowImageCenterX(real_data)
	self:addField(WeField.new("ushx", 'real', nil, nil, real_data))
end

function AnyWeUnit:setSelectionScale(real_data)
	self:addField(WeField.new("ussc", 'real', nil, nil, real_data))
end

function AnyWeUnit:setSelectionCircleOnWater(bool_data)
	self:addField(WeField.new("usew", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setSelectionCircleHeight(real_data)
	self:addField(WeField.new("uslz", 'real', nil, nil, real_data))
end

function AnyWeUnit:setScalingValue(real_data)
	self:addField(WeField.new("usca", 'real', nil, nil, real_data))
end

function AnyWeUnit:setScaleProjectiles(bool_data)
	self:addField(WeField.new("uscb", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setRequiredBoneNames(string_data)
	self:addField(WeField.new("ubpr", 'string', nil, nil, string_data))
end

function AnyWeUnit:setRequiredAttachmentLinkNames(string_data)
	self:addField(WeField.new("ualp", 'string', nil, nil, string_data))
end

function AnyWeUnit:setRequiredAnimationNamesAttachments(string_data)
	self:addField(WeField.new("uaap", 'string', nil, nil, string_data))
end

function AnyWeUnit:setRequiredAnimationNames(string_data)
	self:addField(WeField.new("uani", 'string', nil, nil, string_data))
end

function AnyWeUnit:setRepairTime(int_data)
	self:addField(WeField.new("urtm", 'int', nil, nil, int_data))
end

function AnyWeUnit:setRepairLumberCost(int_data)
	self:addField(WeField.new("ulur", 'int', nil, nil, int_data))
end

function AnyWeUnit:setRepairGoldCost(int_data)
	self:addField(WeField.new("ugor", 'int', nil, nil, int_data))
end

function AnyWeUnit:setRandomSound(string_data)
	self:addField(WeField.new("ursl", 'string', nil, nil, string_data))
end

-- function WeEveryUnit:setRace(Race_data)
-- 	self:addField(WeField.new("urac", 'Race', nil, nil, Race_data))
-- end

function AnyWeUnit:setPropulsionWindowdegrees(real_data)
	self:addField(WeField.new("uprw", 'real', nil, nil, real_data))
end

function AnyWeUnit:setProjectileLaunchZSwimming(real_data)
	self:addField(WeField.new("ulsz", 'real', nil, nil, real_data))
end

function AnyWeUnit:setProjectileLaunchZ(real_data)
	self:addField(WeField.new("ulpz", 'real', nil, nil, real_data))
end

function AnyWeUnit:setProjectileLaunchY(real_data)
	self:addField(WeField.new("ulpy", 'real', nil, nil, real_data))
end

function AnyWeUnit:setProjectileLaunchX(real_data)
	self:addField(WeField.new("ulpx", 'real', nil, nil, real_data))
end

function AnyWeUnit:setProjectileImpactZSwimming(real_data)
	self:addField(WeField.new("uisz", 'real', nil, nil, real_data))
end

function AnyWeUnit:setProjectileImpactZ(real_data)
	self:addField(WeField.new("uimz", 'real', nil, nil, real_data))
end

function AnyWeUnit:setPriority(int_data)
	self:addField(WeField.new("upri", 'int', nil, nil, int_data))
end

function AnyWeUnit:setPointValue(int_data)
	self:addField(WeField.new("upoi", 'int', nil, nil, int_data))
end

function AnyWeUnit:setPlaceableInEditor(bool_data)
	self:addField(WeField.new("uine", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setOrientationInterpolation(int_data)
	self:addField(WeField.new("uori", 'int', nil, nil, int_data))
end

function AnyWeUnit:setOccluderHeight(real_data)
	self:addField(WeField.new("uocc", 'real', nil, nil, real_data))
end

function AnyWeUnit:setNormalAbilities(string_data)
	self:addField(WeField.new("uabi", 'string', nil, nil, string_data))
end

function AnyWeUnit:setNameEditorSuffix(string_data)
	self:addField(WeField.new("unsf", 'string', nil, nil, string_data))
end

function AnyWeUnit:setMovementSound(string_data)
	self:addField(WeField.new("umsl", 'string', nil, nil, string_data))
end

function AnyWeUnit:setModelFileExtraVersions(string_data)
	self:addField(WeField.new("uver", 'string', nil, nil, string_data))
end

function AnyWeUnit:setModelFile(string_data)
	self:addField(WeField.new("umdl", 'string', nil, nil, string_data))
end

function AnyWeUnit:setMinimumAttackRange(int_data)
	self:addField(WeField.new("uamn", 'int', nil, nil, int_data))
end

function AnyWeUnit:setMaximumRollAngledegrees(real_data)
	self:addField(WeField.new("umxr", 'real', nil, nil, real_data))
end

function AnyWeUnit:setMaximumPitchAngledegrees(real_data)
	self:addField(WeField.new("umxp", 'real', nil, nil, real_data))
end

function AnyWeUnit:setManaRegeneration(real_data)
	self:addField(WeField.new("umpr", 'real', nil, nil, real_data))
end

function AnyWeUnit:setManaMaximum(int_data)
	self:addField(WeField.new("umpm", 'int', nil, nil, int_data))
end

function AnyWeUnit:setManaInitialAmount(int_data)
	self:addField(WeField.new("umpi", 'int', nil, nil, int_data))
end

function AnyWeUnit:setLumberCost(int_data)
	self:addField(WeField.new("ulum", 'int', nil, nil, int_data))
end

function AnyWeUnit:setSoundLoopingFadeOutRate(int_data)
	self:addField(WeField.new("ulfo", 'int', nil, nil, int_data))
end

function AnyWeUnit:setSoundLoopingFadeInRate(int_data)
	self:addField(WeField.new("ulfi", 'int', nil, nil, int_data))
end

function AnyWeUnit:setIsaBuilding(bool_data)
	self:addField(WeField.new("ubdg", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setIconScoreScreen(string_data)
	self:addField(WeField.new("ussi", 'string', nil, nil, string_data))
end

function AnyWeUnit:setIconGameInterface(string_data)
	self:addField(WeField.new("uico", 'string', nil, nil, string_data))
end

function AnyWeUnit:setHitPointsRegenerationType(string_data)
	self:addField(WeField.new("uhrt", 'string', nil, nil, string_data))
end

function AnyWeUnit:setHitPointsRegenerationRate(real_data)
	self:addField(WeField.new("uhpr", 'real', nil, nil, real_data))
end

function AnyWeUnit:setHitPointsMaximumBase(int_data)
	self:addField(WeField.new("uhpm", 'int', nil, nil, int_data))
end

function AnyWeUnit:setMovementHeightMinimum(real_data)
	self:addField(WeField.new("umvf", 'real', nil, nil, real_data))
end

function AnyWeUnit:setMovementHeight(real_data)
	self:addField(WeField.new("umvh", 'real', nil, nil, real_data))
end

function AnyWeUnit:setHasWaterShadow(bool_data)
	self:addField(WeField.new("ushr", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setHasTilesetSpecificData(bool_data)
	self:addField(WeField.new("utss", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setGoldCost(int_data)
	self:addField(WeField.new("ugol", 'int', nil, nil, int_data))
end

function AnyWeUnit:setGoldBountyAwardedSidesperDie(int_data)
	self:addField(WeField.new("ubsi", 'int', nil, nil, int_data))
end

function AnyWeUnit:setGoldBountyAwardedNumberofDice(int_data)
	self:addField(WeField.new("ubdi", 'int', nil, nil, int_data))
end

function AnyWeUnit:setGoldBountyAwardedBase(int_data)
	self:addField(WeField.new("ubba", 'int', nil, nil, int_data))
end

function AnyWeUnit:setLumberBountyAwardedSidesperDie(int_data)
	self:addField(WeField.new("ulbs", 'int', nil, nil, int_data))
end

function AnyWeUnit:setLumberBountyAwardedNumberofDice(int_data)
	self:addField(WeField.new("ulbd", 'int', nil, nil, int_data))
end

function AnyWeUnit:setLumberBountyAwardedBase(int_data)
	self:addField(WeField.new("ulba", 'int', nil, nil, int_data))
end

function AnyWeUnit:setFoodProduced(int_data)
	self:addField(WeField.new("ufma", 'int', nil, nil, int_data))
end

function AnyWeUnit:setFoodCost(int_data)
	self:addField(WeField.new("ufoo", 'int', nil, nil, int_data))
end

function AnyWeUnit:setFogOfWarSampleRadius(real_data)
	self:addField(WeField.new("ufrd", 'real', nil, nil, real_data))
end

function AnyWeUnit:setElevationSampleRadius(real_data)
	self:addField(WeField.new("uerd", 'real', nil, nil, real_data))
end

function AnyWeUnit:setElevationSamplePoints(int_data)
	self:addField(WeField.new("uept", 'int', nil, nil, int_data))
end

function AnyWeUnit:setDisplayasNeutralHostile(bool_data)
	self:addField(WeField.new("uhos", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setDependencyEquivalents(string_data)
	self:addField(WeField.new("udep", 'string', nil, nil, string_data))
end

function AnyWeUnit:setDefenseUpgradeBonus(int_data)
	self:addField(WeField.new("udup", 'int', nil, nil, int_data))
end

-- "normal", "small", "medium", "large", "fort", "hero", "divine", "none"
function AnyWeUnit:setArmorType(string_data)
	self:addField(WeField.new("udty", 'string', nil, nil, string_data))
end

function AnyWeUnit:setDefenseBase(int_data)
	self:addField(WeField.new("udef", 'int', nil, nil, int_data))
end

function AnyWeUnit:setDefaultActiveAbility(string_data)
	self:addField(WeField.new("udaa", 'string', nil, nil, string_data))
end

function AnyWeUnit:setDeathType(int_data)
	self:addField(WeField.new("udea", 'int', nil, nil, int_data))
end

function AnyWeUnit:setDeathTimeseconds(real_data)
	self:addField(WeField.new("udtm", 'real', nil, nil, real_data))
end

function AnyWeUnit:setCollisionSize(real_data)
	self:addField(WeField.new("ucol", 'real', nil, nil, real_data))
end

function AnyWeUnit:setCategorizationSpecial(bool_data)
	self:addField(WeField.new("uspe", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setCategorizationCampaign(bool_data)
	self:addField(WeField.new("ucam", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setCanFlee(bool_data)
	self:addField(WeField.new("ufle", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setCanDropItemsOnDeath(bool_data)
	self:addField(WeField.new("udro", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setBuildTime(int_data)
	self:addField(WeField.new("ubld", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttacksEnabled(int_data)
	self:addField(WeField.new("uaen", 'int', nil, nil, int_data))
end

-- "normal", "instant", "artillery", "aline", "missile", "msplash", "mbounce", "mline", "_"
function AnyWeUnit:setAttack2WeaponType(string_data)
	self:addField(WeField.new("ua2w", 'string', nil, nil, string_data))
end

-- "Nothing", "AxeMediumChop", "MetalHeavyBash", "MetalHeavyChop", "MetalHeavySlice",
-- "MetalLightChop", "MetalLightSlice", "MetalMediumBash", "MetalMediumChop",
-- "MetalMediumSlice", "RockHeavyBash", "WoodHeavyBash", "WoodLightBash", "WoodMediumBash"
function AnyWeUnit:setAttack2WeaponSound(string_data)
	self:addField(WeField.new("ucs2", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAttack2TargetsAllowed(string_data)
	self:addField(WeField.new("ua2g", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAttack2ShowUI(bool_data)
	self:addField(WeField.new("uwu2", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setAttack2RangeMotionBuffer(real_data)
	self:addField(WeField.new("urb2", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack2Range(int_data)
	self:addField(WeField.new("ua2r", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack2ProjectileSpeed(int_data)
	self:addField(WeField.new("ua2z", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack2ProjectileHomingEnabled(bool_data)
	self:addField(WeField.new("umh2", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setAttack2ProjectileArt(string_data)
	self:addField(WeField.new("ua2m", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAttack2ProjectileArc(real_data)
	self:addField(WeField.new("uma2", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack2MaximumNumberofTargets(int_data)
	self:addField(WeField.new("utc2", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack2DamageUpgradeAmount(int_data)
	self:addField(WeField.new("udu2", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack2DamageSpillRadius(real_data)
	self:addField(WeField.new("usr2", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack2DamageSpillDistance(real_data)
	self:addField(WeField.new("usd2", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack2DamageSidesperDie(int_data)
	self:addField(WeField.new("ua2s", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack2DamageNumberofDice(int_data)
	self:addField(WeField.new("ua2d", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack2DamageLossFactor(real_data)
	self:addField(WeField.new("udl2", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack2DamageFactorSmall(real_data)
	self:addField(WeField.new("uqd2", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack2DamageFactorMedium(real_data)
	self:addField(WeField.new("uhd2", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack2DamageBase(int_data)
	self:addField(WeField.new("ua2b", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack2CooldownTime(real_data)
	self:addField(WeField.new("ua2c", 'real', nil, nil, real_data))
end

-- "unknown", "normal", "pierce", "siege", "spells", "chaos", "magic", "hero"
function AnyWeUnit:setAttack2AttackType(string_data)
	self:addField(WeField.new("ua2t", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAttack2AreaofEffectTargets(string_data)
	self:addField(WeField.new("ua2p", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAttack2AreaofEffectSmallDamage(int_data)
	self:addField(WeField.new("ua2q", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack2AreaofEffectMediumDamage(int_data)
	self:addField(WeField.new("ua2h", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack2AreaofEffectFullDamage(int_data)
	self:addField(WeField.new("ua2f", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack2AnimationDamagePoint(real_data)
	self:addField(WeField.new("udp2", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack2AnimationBackswingPoint(real_data)
	self:addField(WeField.new("ubs2", 'real', nil, nil, real_data))
end

-- "normal", "instant", "artillery", "aline", "missile", "msplash", "mbounce", "mline", "_"
function AnyWeUnit:setAttack1WeaponType(string_data)
	self:addField(WeField.new("ua1w", 'string', nil, nil, string_data))
end

-- "Nothing", "AxeMediumChop", "MetalHeavyBash", "MetalHeavyChop", "MetalHeavySlice",
-- "MetalLightChop", "MetalLightSlice", "MetalMediumBash", "MetalMediumChop",
-- "MetalMediumSlice", "RockHeavyBash", "WoodHeavyBash", "WoodLightBash", "WoodMediumBash"
function AnyWeUnit:setAttack1WeaponSound(string_data)
	self:addField(WeField.new("ucs1", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAttack1TargetsAllowed(string_data)
	self:addField(WeField.new("ua1g", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAttack1ShowUI(bool_data)
	self:addField(WeField.new("uwu1", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setAttack1RangeMotionBuffer(real_data)
	self:addField(WeField.new("urb1", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack1Range(int_data)
	self:addField(WeField.new("ua1r", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack1ProjectileSpeed(int_data)
	self:addField(WeField.new("ua1z", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack1ProjectileHomingEnabled(bool_data)
	self:addField(WeField.new("umh1", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setAttack1ProjectileArt(string_data)
	self:addField(WeField.new("ua1m", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAttack1ProjectileArc(real_data)
	self:addField(WeField.new("uma1", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack1MaximumNumberofTargets(int_data)
	self:addField(WeField.new("utc1", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack1DamageUpgradeAmount(int_data)
	self:addField(WeField.new("udu1", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack1DamageSpillRadius(real_data)
	self:addField(WeField.new("usr1", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack1DamageSpillDistance(real_data)
	self:addField(WeField.new("usd1", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack1DamageSidesperDie(int_data)
	self:addField(WeField.new("ua1s", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack1DamageNumberofDice(int_data)
	self:addField(WeField.new("ua1d", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack1DamageLossFactor(real_data)
	self:addField(WeField.new("udl1", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack1DamageFactorSmall(real_data)
	self:addField(WeField.new("uqd1", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack1DamageFactorMedium(real_data)
	self:addField(WeField.new("uhd1", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack1DamageBase(int_data)
	self:addField(WeField.new("ua1b", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack1CooldownTime(real_data)
	self:addField(WeField.new("ua1c", 'real', nil, nil, real_data))
end

-- "unknown", "normal", "pierce", "siege", "spells", "chaos", "magic", "hero"
function AnyWeUnit:setAttack1AttackType(string_data)
	self:addField(WeField.new("ua1t", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAttack1AreaofEffectTargets(string_data)
	self:addField(WeField.new("ua1p", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAttack1AreaofEffectSmallDamage(int_data)
	self:addField(WeField.new("ua1q", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack1AreaofEffectMediumDamage(int_data)
	self:addField(WeField.new("ua1h", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack1AreaofEffectFullDamage(int_data)
	self:addField(WeField.new("ua1f", 'int', nil, nil, int_data))
end

function AnyWeUnit:setAttack1AnimationDamagePoint(real_data)
	self:addField(WeField.new("udp1", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAttack1AnimationBackswingPoint(real_data)
	self:addField(WeField.new("ubs1", 'real', nil, nil, real_data))
end

-- "Ethereal", "Flesh", "Wood", "Stone", "Metal"
function AnyWeUnit:setArmorSoundType(string_data)
	self:addField(WeField.new("uarm", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAnimationWalkSpeed(real_data)
	self:addField(WeField.new("uwal", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAnimationRunSpeed(real_data)
	self:addField(WeField.new("urun", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAnimationCastPoint(real_data)
	self:addField(WeField.new("ucpt", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAnimationCastBackswing(real_data)
	self:addField(WeField.new("ucbs", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAnimationBlendTimeseconds(real_data)
	self:addField(WeField.new("uble", 'real', nil, nil, real_data))
end

function AnyWeUnit:setAllowCustomTeamColor(bool_data)
	self:addField(WeField.new("utcc", 'bool', nil, nil, bool_data))
end

function AnyWeUnit:setAIPlacementType(string_data)
	self:addField(WeField.new("uabt", 'string', nil, nil, string_data))
end

function AnyWeUnit:setAIPlacementRadius(real_data)
	self:addField(WeField.new("uabr", 'real', nil, nil, real_data))
end

return AnyWeUnit
