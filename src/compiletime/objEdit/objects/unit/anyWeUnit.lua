---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type WeFile
local WeFile = require('compiletime.objEdit.weFile')
---@type WeObject
local WeObject = require('compiletime.objEdit.objects.weObject')
---@type WeUtils
local utils = require('compiletime.objEdit.weUtils')

---@class AnyWeUnit : WeObject
local AnyWeUnit = {}
setmetatable(AnyWeUnit, {__index = WeObject})

---@param id string
---@param base_id string
---@return AnyWeUnit
function AnyWeUnit.new(id, base_id)
    local we_unit = WeObject.new(id, base_id, 'unit')
    setmetatable(we_unit, {__index = AnyWeUnit})
    WeFile.units:add(we_unit)
    return we_unit
end

---@param data string
function AnyWeUnit:setTooltipExtended(data) self:addField(WeField.new("utub", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setTooltipBasic(data) self:addField(WeField.new("utip", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setRequirementsLevels(data) self:addField(WeField.new("urqa", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setRequirements(data) self:addField(WeField.new("ureq", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setName(data) self:addField(WeField.new("unam", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setHotkey(data) self:addField(WeField.new("uhot", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setDescription(data) self:addField(WeField.new("ides", 'string', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setButtonPositionY(data) self:addField(WeField.new("ubpy", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setButtonPositionX(data) self:addField(WeField.new("ubpx", 'int', nil, nil, data)) end
---@param data string
function AnyWeUnit:setItemsSold(data) self:addField(WeField.new("usei", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setUnitsSold(data) self:addField(WeField.new("useu", 'string', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setHideMinimapDisplay(data) self:addField(WeField.new("uhom", 'bool', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setUseExtendedLineofSight(data) self:addField(WeField.new("ulos", 'bool', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setUseClickHelper(data) self:addField(WeField.new("uuch", 'bool', nil, nil, data)) end
---@param data string
function AnyWeUnit:setUpgradesUsed(data) self:addField(WeField.new("upgr", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setUnitSoundSet(data) self:addField(WeField.new("usnd", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setUnitClassification(data) self:addField(WeField.new("utyp", 'string', nil, nil, data)) end
---Possible data: 'horse'|'fly'|'hover'|'float'|'amph'
---@param data string
function AnyWeUnit:setMovementType(data) self:addField(WeField.new("umvt", 'MovementType_', nil, nil, data)) end
---@param data number
function AnyWeUnit:setTurnRate(data) self:addField(WeField.new("umvr", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setTintingColorBlue(data) self:addField(WeField.new("uclb", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setTintingColorGreen(data) self:addField(WeField.new("uclg", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setTintingColorRed(data) self:addField(WeField.new("uclr", 'int', nil, nil, data)) end
---@param data string
function AnyWeUnit:setTilesets(data) self:addField(WeField.new("util", 'string', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setTeamColor(data) self:addField(WeField.new("utco", 'int', nil, nil, data)) end
---@param data string
function AnyWeUnit:setTargetedAs(data) self:addField(WeField.new("utar", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setArtTarget(data) self:addField(WeField.new("utaa", 'string', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setStockStartDelay(data) self:addField(WeField.new("usst", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setStockReplenishInterval(data) self:addField(WeField.new("usrg", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setStockMaximum(data) self:addField(WeField.new("usma", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setSpeedMinimum(data) self:addField(WeField.new("umis", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setSpeedMaximum(data) self:addField(WeField.new("umas", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setSpeedBase(data) self:addField(WeField.new("umvs", 'int', nil, nil, data)) end
---@param data string
function AnyWeUnit:setArtSpecial(data) self:addField(WeField.new("uspa", 'string', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setSleeps(data) self:addField(WeField.new("usle", 'bool', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setSightRadiusNight(data) self:addField(WeField.new("usin", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setSightRadiusDay(data) self:addField(WeField.new("usid", 'int', nil, nil, data)) end
---@param data string
function AnyWeUnit:setShadowTextureBuilding(data) self:addField(WeField.new("ushb", 'string', nil, nil, data)) end
---@param data number
function AnyWeUnit:setShadowImageWidth(data) self:addField(WeField.new("ushw", 'real', nil, nil, data)) end
---@param data string
function AnyWeUnit:setShadowImageUnit(data) self:addField(WeField.new("ushu", 'string', nil, nil, data)) end
---@param data number
function AnyWeUnit:setShadowImageHeight(data) self:addField(WeField.new("ushh", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setShadowImageCenterY(data) self:addField(WeField.new("ushy", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setShadowImageCenterX(data) self:addField(WeField.new("ushx", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setSelectionScale(data) self:addField(WeField.new("ussc", 'real', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setSelectionCircleOnWater(data) self:addField(WeField.new("usew", 'bool', nil, nil, data)) end
---@param data number
function AnyWeUnit:setSelectionCircleHeight(data) self:addField(WeField.new("uslz", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setScalingValue(data) self:addField(WeField.new("usca", 'real', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setScaleProjectiles(data) self:addField(WeField.new("uscb", 'bool', nil, nil, data)) end
---@param data string
function AnyWeUnit:setRequiredBoneNames(data) self:addField(WeField.new("ubpr", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setRequiredAttachmentLinkNames(data) self:addField(WeField.new("ualp", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setRequiredAnimationNamesAttachments(data) self:addField(WeField.new("uaap", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setRequiredAnimationNames(data) self:addField(WeField.new("uani", 'string', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setRepairTime(data) self:addField(WeField.new("urtm", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setRepairLumberCost(data) self:addField(WeField.new("ulur", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setRepairGoldCost(data) self:addField(WeField.new("ugor", 'int', nil, nil, data)) end
---@param data string
function AnyWeUnit:setRandomSound(data) self:addField(WeField.new("ursl", 'string', nil, nil, data)) end
---Possible data 'commoner'|'creeps'|'critters'|'demon'|'human'|'naga'|'nightelf'|'orc'|'other'|'undead'|'unknown'
---@param data string
function AnyWeUnit:setRace(data) self:addField(WeField.new("urac", 'Race', nil, nil, data)) end
---@param data number
function AnyWeUnit:setPropulsionWindowdegrees(data) self:addField(WeField.new("uprw", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setProjectileLaunchZSwimming(data) self:addField(WeField.new("ulsz", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setProjectileLaunchZ(data) self:addField(WeField.new("ulpz", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setProjectileLaunchY(data) self:addField(WeField.new("ulpy", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setProjectileLaunchX(data) self:addField(WeField.new("ulpx", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setProjectileImpactZSwimming(data) self:addField(WeField.new("uisz", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setProjectileImpactZ(data) self:addField(WeField.new("uimz", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setPriority(data) self:addField(WeField.new("upri", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setPointValue(data) self:addField(WeField.new("upoi", 'int', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setPlaceableInEditor(data) self:addField(WeField.new("uine", 'bool', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setOrientationInterpolation(data) self:addField(WeField.new("uori", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setOccluderHeight(data) self:addField(WeField.new("uocc", 'real', nil, nil, data)) end
---@param data string
function AnyWeUnit:setNormalAbilities(data) self:addField(WeField.new("uabi", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setNameEditorSuffix(data) self:addField(WeField.new("unsf", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setMovementSound(data) self:addField(WeField.new("umsl", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setModelFileExtraVersions(data) self:addField(WeField.new("uver", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setModelFile(data)
    local f = io.open(data, "r")
    if f ~= nil then 
        f:close()
    else
        print('Can not find model file '..data)
        print(utils.getErrorPos())
    end
    self:addField(WeField.new("umdl", 'string', nil, nil, data))
end
---@param data integer
function AnyWeUnit:setMinimumAttackRange(data) self:addField(WeField.new("uamn", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setMaximumRollAngledegrees(data) self:addField(WeField.new("umxr", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setMaximumPitchAngledegrees(data) self:addField(WeField.new("umxp", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setManaRegeneration(data) self:addField(WeField.new("umpr", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setManaMaximum(data) self:addField(WeField.new("umpm", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setManaInitialAmount(data) self:addField(WeField.new("umpi", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setLumberCost(data) self:addField(WeField.new("ulum", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setSoundLoopingFadeOutRate(data) self:addField(WeField.new("ulfo", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setSoundLoopingFadeInRate(data) self:addField(WeField.new("ulfi", 'int', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setIsaBuilding(data) self:addField(WeField.new("ubdg", 'bool', nil, nil, data)) end
---@param data string
function AnyWeUnit:setIconScoreScreen(data) self:addField(WeField.new("ussi", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setIconGameInterface(data) self:addField(WeField.new("uico", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setHitPointsRegenerationType(data) self:addField(WeField.new("uhrt", 'string', nil, nil, data)) end
---@param data number
function AnyWeUnit:setHitPointsRegenerationRate(data) self:addField(WeField.new("uhpr", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setHitPointsMaximumBase(data) self:addField(WeField.new("uhpm", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setMovementHeightMinimum(data) self:addField(WeField.new("umvf", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setMovementHeight(data) self:addField(WeField.new("umvh", 'real', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setHasWaterShadow(data) self:addField(WeField.new("ushr", 'bool', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setHasTilesetSpecificData(data) self:addField(WeField.new("utss", 'bool', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setGoldCost(data) self:addField(WeField.new("ugol", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setGoldBountyAwardedSidesperDie(data) self:addField(WeField.new("ubsi", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setGoldBountyAwardedbooleanofDice(data) self:addField(WeField.new("ubdi", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setGoldBountyAwardedBase(data) self:addField(WeField.new("ubba", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setLumberBountyAwardedSidesperDie(data) self:addField(WeField.new("ulbs", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setLumberBountyAwardedbooleanofDice(data) self:addField(WeField.new("ulbd", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setLumberBountyAwardedBase(data) self:addField(WeField.new("ulba", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setFoodProduced(data) self:addField(WeField.new("ufma", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setFoodCost(data) self:addField(WeField.new("ufoo", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setFogOfWarSampleRadius(data) self:addField(WeField.new("ufrd", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setElevationSampleRadius(data) self:addField(WeField.new("uerd", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setElevationSamplePoints(data) self:addField(WeField.new("uept", 'int', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setDisplayasNeutralHostile(data) self:addField(WeField.new("uhos", 'bool', nil, nil, data)) end
---@param data string
function AnyWeUnit:setDependencyEquivalents(data) self:addField(WeField.new("udep", 'string', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setDefenseUpgradeBonus(data) self:addField(WeField.new("udup", 'int', nil, nil, data)) end
---Possible data: "normal"|"small"|"medium"|"large"|"fort"|"hero"|"divine"|"none"
---@param data string
function AnyWeUnit:setArmorType(data) self:addField(WeField.new("udty", 'string', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setDefenseBase(data) self:addField(WeField.new("udef", 'int', nil, nil, data)) end
---@param data string
function AnyWeUnit:setDefaultActiveAbility(data) self:addField(WeField.new("udaa", 'string', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setDeathType(data) self:addField(WeField.new("udea", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setDeathTimeseconds(data) self:addField(WeField.new("udtm", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setCollisionSize(data) self:addField(WeField.new("ucol", 'real', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setCategorizationSpecial(data) self:addField(WeField.new("uspe", 'bool', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setCategorizationCampaign(data) self:addField(WeField.new("ucam", 'bool', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setCanFlee(data) self:addField(WeField.new("ufle", 'bool', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setCanDropItemsOnDeath(data) self:addField(WeField.new("udro", 'bool', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setBuildTime(data) self:addField(WeField.new("ubld", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttacksEnabled(data) self:addField(WeField.new("uaen", 'int', nil, nil, data)) end
---Possible data: 'normal'|'instant'|'artillery'|'aline'|'missile'|'msplash'|'mbounce'|'mline'
---@param data string
function AnyWeUnit:setAttack2WeaponType(data) self:addField(WeField.new("ua2w", 'string', nil, nil, data)) end
---Possible data: "Nothing"|"AxeMediumChop"|"MetalHeavyBash"|"MetalHeavyChop"|"MetalHeavySlice"|"MetalLightChop"|"MetalLightSlice"|"MetalMediumBash"|"MetalMediumChop"|"MetalMediumSlice"|"RockHeavyBash"|WoodHeavyBash"|"WoodLightBash"|"WoodMediumBash"
---@param data string
function AnyWeUnit:setAttack2WeaponSound(data) self:addField(WeField.new("ucs2", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setAttack2TargetsAllowed(data) self:addField(WeField.new("ua2g", 'string', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setAttack2ShowUI(data) self:addField(WeField.new("uwu2", 'bool', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack2RangeMotionBuffer(data) self:addField(WeField.new("urb2", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack2Range(data) self:addField(WeField.new("ua2r", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack2ProjectileSpeed(data) self:addField(WeField.new("ua2z", 'int', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setAttack2ProjectileHomingEnabled(data) self:addField(WeField.new("umh2", 'bool', nil, nil, data)) end
---@param data string
function AnyWeUnit:setAttack2ProjectileArt(data) self:addField(WeField.new("ua2m", 'string', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack2ProjectileArc(data) self:addField(WeField.new("uma2", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack2MaximumbooleanofTargets(data) self:addField(WeField.new("utc2", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack2DamageUpgradeAmount(data) self:addField(WeField.new("udu2", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack2DamageSpillRadius(data) self:addField(WeField.new("usr2", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack2DamageSpillDistance(data) self:addField(WeField.new("usd2", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack2DamageSidesperDie(data) self:addField(WeField.new("ua2s", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack2DamagebooleanofDice(data) self:addField(WeField.new("ua2d", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack2DamageLossFactor(data) self:addField(WeField.new("udl2", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack2DamageFactorSmall(data) self:addField(WeField.new("uqd2", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack2DamageFactorMedium(data) self:addField(WeField.new("uhd2", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack2DamageBase(data) self:addField(WeField.new("ua2b", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack2CooldownTime(data) self:addField(WeField.new("ua2c", 'real', nil, nil, data)) end
---Possible data: 'unknown'|'normal'|'pierce'|'siege'|'spells'|'chaos'|'magic'|'hero'
---@param data string
function AnyWeUnit:setAttack2AttackType(data) self:addField(WeField.new("ua2t", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setAttack2AreaofEffectTargets(data) self:addField(WeField.new("ua2p", 'string', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack2AreaofEffectSmallDamage(data) self:addField(WeField.new("ua2q", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack2AreaofEffectMediumDamage(data) self:addField(WeField.new("ua2h", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack2AreaofEffectFullDamage(data) self:addField(WeField.new("ua2f", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack2AnimationDamagePoint(data) self:addField(WeField.new("udp2", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack2AnimationBackswingPoint(data) self:addField(WeField.new("ubs2", 'real', nil, nil, data)) end
---Possible data: 'normal'|'instant'|'artillery'|'aline'|'missile'|'msplash'|'mbounce'|'mline'
---@param data string
function AnyWeUnit:setAttack1WeaponType(data) self:addField(WeField.new("ua1w", 'string', nil, nil, data)) end
---Possible data: 'Nothing'|'AxeMediumChop'|'MetalHeavyBash'|'MetalHeavyChop'|'MetalHeavySlice'|'MetalLightChop'|'MetalLightSlice'|'MetalMediumBash'|'MetalMediumChop'|'MetalMediumSlice'|'RockHeavyBash'|'WoodHeavyBash'|'WoodLightBash'|'WoodMediumBash'
---@param data string
function AnyWeUnit:setAttack1WeaponSound(data) self:addField(WeField.new("ucs1", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setAttack1TargetsAllowed(data) self:addField(WeField.new("ua1g", 'string', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setAttack1ShowUI(data) self:addField(WeField.new("uwu1", 'bool', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack1RangeMotionBuffer(data) self:addField(WeField.new("urb1", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack1Range(data) self:addField(WeField.new("ua1r", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack1ProjectileSpeed(data) self:addField(WeField.new("ua1z", 'int', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setAttack1ProjectileHomingEnabled(data) self:addField(WeField.new("umh1", 'bool', nil, nil, data)) end
---@param data string
function AnyWeUnit:setAttack1ProjectileArt(data) self:addField(WeField.new("ua1m", 'string', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack1ProjectileArc(data) self:addField(WeField.new("uma1", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack1MaximumbooleanofTargets(data) self:addField(WeField.new("utc1", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack1DamageUpgradeAmount(data) self:addField(WeField.new("udu1", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack1DamageSpillRadius(data) self:addField(WeField.new("usr1", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack1DamageSpillDistance(data) self:addField(WeField.new("usd1", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack1DamageSidesperDie(data) self:addField(WeField.new("ua1s", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack1DamagebooleanofDice(data) self:addField(WeField.new("ua1d", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack1DamageLossFactor(data) self:addField(WeField.new("udl1", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack1DamageFactorSmall(data) self:addField(WeField.new("uqd1", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack1DamageFactorMedium(data) self:addField(WeField.new("uhd1", 'real', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack1DamageBase(data) self:addField(WeField.new("ua1b", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack1CooldownTime(data) self:addField(WeField.new("ua1c", 'real', nil, nil, data)) end
---Possible data: 'unknown'|'normal'|'pierce'|'siege'|'spells'|'chaos'|'magic'|'hero'
---@param data string
function AnyWeUnit:setAttack1AttackType(data) self:addField(WeField.new("ua1t", 'string', nil, nil, data)) end
---@param data string
function AnyWeUnit:setAttack1AreaofEffectTargets(data) self:addField(WeField.new("ua1p", 'string', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack1AreaofEffectSmallDamage(data) self:addField(WeField.new("ua1q", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack1AreaofEffectMediumDamage(data) self:addField(WeField.new("ua1h", 'int', nil, nil, data)) end
---@param data integer
function AnyWeUnit:setAttack1AreaofEffectFullDamage(data) self:addField(WeField.new("ua1f", 'int', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack1AnimationDamagePoint(data) self:addField(WeField.new("udp1", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAttack1AnimationBackswingPoint(data) self:addField(WeField.new("ubs1", 'real', nil, nil, data)) end
---Possible data: 'Ethereal'|'Flesh'|'Wood'|'Stone'|'Metal'
---@param data string
function AnyWeUnit:setArmorSoundType(data) self:addField(WeField.new("uarm", 'string', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAnimationWalkSpeed(data) self:addField(WeField.new("uwal", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAnimationRunSpeed(data) self:addField(WeField.new("urun", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAnimationCastPoint(data) self:addField(WeField.new("ucpt", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAnimationCastBackswing(data) self:addField(WeField.new("ucbs", 'real', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAnimationBlendTimeseconds(data) self:addField(WeField.new("uble", 'real', nil, nil, data)) end
---@param data boolean
function AnyWeUnit:setAllowCustomTeamColor(data) self:addField(WeField.new("utcc", 'bool', nil, nil, data)) end
---@param data string
function AnyWeUnit:setAIPlacementType(data) self:addField(WeField.new("uabt", 'string', nil, nil, data)) end
---@param data number
function AnyWeUnit:setAIPlacementRadius(data) self:addField(WeField.new("uabr", 'real', nil, nil, data)) end

return AnyWeUnit