--=========
-- Include
--=========

local Class = require('Utils.Class')

local Log = require('utils.Log')
---@type WeFieldClass
local WeField = require('compiletime.ObjectEdit.WeField')
---@type WeObjectClass
local WeObject = require('compiletime.ObjectEdit.WeObject')
---@type WeObjectFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeObjectFile')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeUnit = Class.newClass('WeUnit', WeObject)

---@class WeUnit
local public = WeUnit.public
---@class WeUnitClass
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
    local instance = instance_data or Class.newInstanceData(WeUnit)
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

local fmt = string.format

function private.checkType(field, data)
    local data_type = field:getDataType()
    local res = false
    if data_type == 'string' and type(data) == 'string' then
        res = true
    end
    if data_type == 'int' and type(data) == 'number' and data % 1 == 0 then
        res = true
    end
    if data_type == 'bool' and type(data) == 'boolean' then
        res = true
    end
    if (data_type == 'real' or data_type == 'unreal') and type(data) == 'number' then
        res = true
    end

    if not res then
        local msg = fmt('Wrong data type. Got %s. Need %s.',
                         type(data), data_type)
        Log(Log.Warn, field:getName(), msg)
    end
    return res
end

function private.checkPath(field, data)
    if not private.checkType(field, data) then
        return false
    end

    -- Path correction.
    local sep = package.config:sub(1,1)
    if sep == '/' then data = data:gsub('\\', package.config:sub(1,1)) 
    elseif sep == '\\' then data = data:gsub('/', package.config:sub(1,1)) end

    local f = io.open(data, "r", private.checkType)
    if f ~= nil then 
        f:close()
    else
        msg = fmt('Wan not find file %s.',
                   field:getName(), data)
        Log(Log.Warn, field:getName(), msg)
        return false
    end
    return true
end

---@param tbl string[]
---@return string
function private.getPossibleValues(tbl)
    local msg = '' 
    for i = 1, #tbl do
        msg = msg..'\"'..tbl[i]..'\"'..', '
    end
    return string.sub(msg, 1, string.len(msg) - 2)
end

function private.checkPossibleValues(field, data, tbl)
    if not private.checkType(field, data) then
        return false
    end

    for i = 1, #tbl do
        if data == tbl[i] then
            return true
        end
    end

    msg = fmt('wrong data. Got: \"%s\"". Available: %s.',
               data, private.getPossibleValues(tbl))
    Log(Log.Warn, field:getName(), msg)
    return false
end

private.ArmorSoundsTypes = {'Ethereal', 'Flesh', 'Wood', 'Stone', 'Metal'}
function private.checkArmorSoundType(field, data)
    return private.checkPossibleValues(field, data, private.ArmorSoundsTypes)
end

private.ArmorTypes = {'normal', 'small', 'medium', 'large', 'fort', 'hero', 'divine', 'none'}
function private.checkArmorType(field, data)
    return private.checkPossibleValues(field, data, private.ArmorTypes)
end

private.AttackTypes = {'unknown', 'normal', 'pierce', 'siege', 'spells', 'chaos', 'magic', 'hero'}
function private.checkAttackType(field, data)
    return private.checkPossibleValues(field, data, private.AttackTypes)
end

private.AttackTargetsAllowed = {'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration',
'enemies', 'friend', 'ground', 'hero', 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient',
'none', 'nonhero', 'nonsapper', 'notself', 'organic', 'player', 'playerunits', 'sapper', 'self',
'structure', 'terrain', 'tree', 'vulnerable', 'wall'}
function private.checkAttackTargetsAllowed(field, data)
    return private.checkPossibleValues(field, data, private.AttackTargetsAllowed)
end

private.AttackWeaponSounds = {'Nothing', 'AxeMediumChop', 'MetalHeavyBash', 'MetalHeavyChop',
'MetalHeavySlice', 'MetalLightChop', 'MetalLightSlice', 'MetalMediumBash', 'MetalMediumChop',
'MetalMediumSlice', 'RockHeavyBash', 'WoodHeavyBash', 'WoodLightBash', 'WoodMediumBash'}
function private.checkAttackWeaponSounde(field, data)
    return private.checkPossibleValues(field, data, private.AttackWeaponSounds)
end

private.AttackWeaponTypes = {'normal', 'instant', 'artillery', 'aline', 'missile',
'msplash', 'mbounce', 'mline'}
function private.checkAttackWeaponType(field, data)
    return private.checkPossibleValues(field, data, private.AttackWeaponTypes)
end

private.MovementTypes = {'horse', 'fly', 'hover', 'float', 'amph'}
function private.checkMovementType(field, data)
    return private.checkPossibleValues(field, data, private.MovementTypes)
end

private.Races = {'commoner', 'creeps', 'critters', 'demon', 'human', 'naga', 'nightelf',
'orc', 'other', 'undead', 'unknown'}
function private.checkRace(field, data)
    return private.checkPossibleValues(field, data, private.Races)
end

--=============
-- Unit fields
--=============
static.AIPlacementRadius = WeField.new("uabr", 'real', "AIPlacementRadius", private.checkType)
static.AIPlacementType = WeField.new("uabt", 'string', "AIPlacementType", private.checkType)
static.AllowCustomTeamColor = WeField.new("utcc", 'bool', "AllowCustomTeamColor", private.checkType)
static.AnimationBlendTimeseconds = WeField.new("uble", 'real', "AnimationBlendTimeseconds", private.checkType)
static.AnimationCastBackswing = WeField.new("ucbs", 'real', "AnimationCastBackswing", private.checkType)
static.AnimationCastPoint = WeField.new("ucpt", 'real', "AnimationCastPoint", private.checkType)
static.AnimationRunSpeed = WeField.new("urun", 'real', "AnimationRunSpeed", private.checkType)
static.AnimationWalkSpeed = WeField.new("uwal", 'real', "AnimationWalkSpeed", private.checkType)
--- 'Ethereal', 'Flesh', 'Wood', 'Stone', 'Metal'
static.ArmorSoundType = WeField.new("uarm", 'string', "ArmorSoundType", private.checkArmorSoundType)
--- 'normal', 'small', 'medium', 'large', 'fort', 'hero', 'divine', 'none'
static.ArmorType = WeField.new("udty", 'string', "ArmorType", private.checkArmorType)
static.ArtSpecial = WeField.new("uspa", 'string', "ArtSpecial", private.checkType)
static.ArtTarget = WeField.new("utaa", 'string', "ArtTarget", private.checkType)
static.Attack1AnimationBackswingPoint = WeField.new("ubs1", 'real', "Attack1AnimationBackswingPoint", private.checkType)
static.Attack1AnimationDamagePoint = WeField.new("udp1", 'real', "Attack1AnimationDamagePoint", private.checkType)
static.Attack1AreaofEffectFullDamage = WeField.new("ua1f", 'int', "Attack1AreaofEffectFullDamage", private.checkType)
static.Attack1AreaofEffectMediumDamage = WeField.new("ua1h", 'int', "Attack1AreaofEffectMediumDamage", private.checkType)
static.Attack1AreaofEffectSmallDamage = WeField.new("ua1q", 'int', "Attack1AreaofEffectSmallDamage", private.checkType)
static.Attack1AreaofEffectTargets = WeField.new("ua1p", 'string', "Attack1AreaofEffectTargets", private.checkType)
--- 'unknown', 'normal', 'pierce', 'siege', 'spells', 'chaos', 'magic', 'hero'
static.Attack1AttackType = WeField.new("ua1t", 'string', "Attack1AttackType", private.AttackType)
static.Attack1CooldownTime = WeField.new("ua1c", 'real', "Attack1CooldownTime", private.checkType)
static.Attack1DamageBase = WeField.new("ua1b", 'int', "Attack1DamageBase", private.checkType)
static.Attack1DamageFactorMedium = WeField.new("uhd1", 'real', "Attack1DamageFactorMedium", private.checkType)
static.Attack1DamageFactorSmall = WeField.new("uqd1", 'real', "Attack1DamageFactorSmall", private.checkType)
static.Attack1DamageLossFactor = WeField.new("udl1", 'real', "Attack1DamageLossFactor", private.checkType)
static.Attack1DamageSidesperDie = WeField.new("ua1s", 'int', "Attack1DamageSidesperDie", private.checkType)
static.Attack1DamageSpillDistance = WeField.new("usd1", 'real', "Attack1DamageSpillDistance", private.checkType)
static.Attack1DamageSpillRadius = WeField.new("usr1", 'real', "Attack1DamageSpillRadius", private.checkType)
static.Attack1DamageUpgradeAmount = WeField.new("udu1", 'int', "Attack1DamageUpgradeAmount", private.checkType)
static.Attack1DamagebooleanofDice = WeField.new("ua1d", 'int', "Attack1DamagebooleanofDice", private.checkType)
static.Attack1MaximumbooleanofTargets = WeField.new("utc1", 'int', "Attack1MaximumbooleanofTargets", private.checkType)
static.Attack1ProjectileArc = WeField.new("uma1", 'real', "Attack1ProjectileArc", private.checkType)
static.Attack1ProjectileArt = WeField.new("ua1m", 'string', "Attack1ProjectileArt", private.checkType)
static.Attack1ProjectileHomingEnabled = WeField.new("umh1", 'bool', "Attack1ProjectileHomingEnabled", private.checkType)
static.Attack1ProjectileSpeed = WeField.new("ua1z", 'int', "Attack1ProjectileSpeed", private.checkType)
static.Attack1Range = WeField.new("ua1r", 'int', "Attack1Range", private.checkType)
static.Attack1RangeMotionBuffer = WeField.new("urb1", 'real', "Attack1RangeMotionBuffer", private.checkType)
static.Attack1ShowUI = WeField.new("uwu1", 'bool', "Attack1ShowUI", private.checkType)
--- 'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration', 'enemies', 'friend', 'ground', 'hero',
--- 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient', 'none', 'nonhero', 'nonsapper', 'notself',
--- 'organic', 'player', 'playerunits', 'sapper', 'self', 'structure', 'terrain', 'tree', 'vulnerable', 'wall'
static.Attack1TargetsAllowed = WeField.new("ua1g", 'string', "Attack1TargetsAllowed", private.AttackTargetsAllowed)
--- 'Nothing', 'AxeMediumChop', 'MetalHeavyBash', 'MetalHeavyChop',
--- 'MetalHeavySlice', 'MetalLightChop', 'MetalLightSlice', 'MetalMediumBash', 'MetalMediumChop',
--- 'MetalMediumSlice', 'RockHeavyBash', 'WoodHeavyBash', 'WoodLightBash', 'WoodMediumBash'
static.Attack1WeaponSound = WeField.new("ucs1", 'string', "Attack1WeaponSound", private.AttackWeaponSound)
--- 'normal', 'instant', 'artillery', 'aline', 'missile', 'msplash', 'mbounce', 'mline'
static.Attack1WeaponType = WeField.new("ua1w", 'string', "Attack1WeaponType", private.AttackWeaponType)
static.Attack2AnimationBackswingPoint = WeField.new("ubs2", 'real', "Attack2AnimationBackswingPoint", private.checkType)
static.Attack2AnimationDamagePoint = WeField.new("udp2", 'real', "Attack2AnimationDamagePoint", private.checkType)
static.Attack2AreaofEffectFullDamage = WeField.new("ua2f", 'int', "Attack2AreaofEffectFullDamage", private.checkType)
static.Attack2AreaofEffectMediumDamage = WeField.new("ua2h", 'int', "Attack2AreaofEffectMediumDamage", private.checkType)
static.Attack2AreaofEffectSmallDamage = WeField.new("ua2q", 'int', "Attack2AreaofEffectSmallDamage", private.checkType)
static.Attack2AreaofEffectTargets = WeField.new("ua2p", 'string', "Attack2AreaofEffectTargets", private.checkType)
--- 'unknown', 'normal', 'pierce', 'siege', 'spells', 'chaos', 'magic', 'hero'
static.Attack2AttackType = WeField.new("ua2t", 'string', "Attack2AttackType", private.AttackType)
static.Attack2CooldownTime = WeField.new("ua2c", 'real', "Attack2CooldownTime", private.checkType)
static.Attack2DamageBase = WeField.new("ua2b", 'int', "Attack2DamageBase", private.checkType)
static.Attack2DamageFactorMedium = WeField.new("uhd2", 'real', "Attack2DamageFactorMedium", private.checkType)
static.Attack2DamageFactorSmall = WeField.new("uqd2", 'real', "Attack2DamageFactorSmall", private.checkType)
static.Attack2DamageLossFactor = WeField.new("udl2", 'real', "Attack2DamageLossFactor", private.checkType)
static.Attack2DamageSidesperDie = WeField.new("ua2s", 'int', "Attack2DamageSidesperDie", private.checkType)
static.Attack2DamageSpillDistance = WeField.new("usd2", 'real', "Attack2DamageSpillDistance", private.checkType)
static.Attack2DamageSpillRadius = WeField.new("usr2", 'real', "Attack2DamageSpillRadius", private.checkType)
static.Attack2DamageUpgradeAmount = WeField.new("udu2", 'int', "Attack2DamageUpgradeAmount", private.checkType)
static.Attack2DamagebooleanofDice = WeField.new("ua2d", 'int', "Attack2DamagebooleanofDice", private.checkType)
static.Attack2MaximumbooleanofTargets = WeField.new("utc2", 'int', "Attack2MaximumbooleanofTargets", private.checkType)
static.Attack2ProjectileArc = WeField.new("uma2", 'real', "Attack2ProjectileArc", private.checkType)
static.Attack2ProjectileArt = WeField.new("ua2m", 'string', "Attack2ProjectileArt", private.checkType)
static.Attack2ProjectileHomingEnabled = WeField.new("umh2", 'bool', "Attack2ProjectileHomingEnabled", private.checkType)
static.Attack2ProjectileSpeed = WeField.new("ua2z", 'int', "Attack2ProjectileSpeed", private.checkType)
static.Attack2Range = WeField.new("ua2r", 'int', "Attack2Range", private.checkType)
static.Attack2RangeMotionBuffer = WeField.new("urb2", 'real', "Attack2RangeMotionBuffer", private.checkType)
static.Attack2ShowUI = WeField.new("uwu2", 'bool', "Attack2ShowUI", private.checkType)
--- 'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration', 'enemies', 'friend', 'ground', 'hero',
--- 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient', 'none', 'nonhero', 'nonsapper', 'notself',
--- 'organic', 'player', 'playerunits', 'sapper', 'self', 'structure', 'terrain', 'tree', 'vulnerable', 'wall'
static.Attack2TargetsAllowed = WeField.new("ua2g", 'string', "Attack2TargetsAllowed", private.AttackTargetsAllowed)
--- 'Nothing', 'AxeMediumChop', 'MetalHeavyBash', 'MetalHeavyChop',
--- 'MetalHeavySlice', 'MetalLightChop', 'MetalLightSlice', 'MetalMediumBash', 'MetalMediumChop',
--- 'MetalMediumSlice', 'RockHeavyBash', 'WoodHeavyBash', 'WoodLightBash', 'WoodMediumBash'
static.Attack2WeaponSound = WeField.new("ucs2", 'string', "Attack2WeaponSound", private.AttackWeaponSound)
--- 'unknown', 'normal', 'pierce', 'siege', 'spells', 'chaos', 'magic', 'hero'
static.Attack2WeaponType = WeField.new("ua2w", 'string', "Attack2WeaponType", private.AttackWeaponType)
static.AttacksEnabled = WeField.new("uaen", 'int', "AttacksEnabled", private.checkType)
static.BuildTime = WeField.new("ubld", 'int', "BuildTime", private.checkType)
static.ButtonPositionX = WeField.new("ubpx", 'int', "ButtonPositionX", private.checkType)
static.ButtonPositionY = WeField.new("ubpy", 'int', "ButtonPositionY", private.checkType)
static.CanDropItemsOnDeath = WeField.new("udro", 'bool', "CanDropItemsOnDeath", private.checkType)
static.CanFlee = WeField.new("ufle", 'bool', "CanFlee", private.checkType)
static.CategorizationCampaign = WeField.new("ucam", 'bool', "CategorizationCampaign", private.checkType)
static.CategorizationSpecial = WeField.new("uspe", 'bool', "CategorizationSpecial", private.checkType)
static.CollisionSize = WeField.new("ucol", 'real', "CollisionSize", private.checkType)
static.DeathTimeseconds = WeField.new("udtm", 'real', "DeathTimeseconds", private.checkType)
static.DeathType = WeField.new("udea", 'int', "DeathType", private.checkType)
static.DefaultActiveAbility = WeField.new("udaa", 'string', "DefaultActiveAbility", private.checkType)
static.DefenseBase = WeField.new("udef", 'int', "DefenseBase", private.checkType)
static.DefenseUpgradeBonus = WeField.new("udup", 'int', "DefenseUpgradeBonus", private.checkType)
static.DependencyEquivalents = WeField.new("udep", 'string', "DependencyEquivalents", private.checkType)
static.Description = WeField.new("ides", 'string', "Description", private.checkType)
static.DisplayasNeutralHostile = WeField.new("uhos", 'bool', "DisplayasNeutralHostile", private.checkType)
static.ElevationSamplePoints = WeField.new("uept", 'int', "ElevationSamplePoints", private.checkType)
static.ElevationSampleRadius = WeField.new("uerd", 'real', "ElevationSampleRadius", private.checkType)
static.FogOfWarSampleRadius = WeField.new("ufrd", 'real', "FogOfWarSampleRadius", private.checkType)
static.FoodCost = WeField.new("ufoo", 'int', "FoodCost", private.checkType)
static.FoodProduced = WeField.new("ufma", 'int', "FoodProduced", private.checkType)
static.GoldBountyAwardedBase = WeField.new("ubba", 'int', "GoldBountyAwardedBase", private.checkType)
static.GoldBountyAwardedSidesperDie = WeField.new("ubsi", 'int', "GoldBountyAwardedSidesperDie", private.checkType)
static.GoldBountyAwardedbooleanofDice = WeField.new("ubdi", 'int', "GoldBountyAwardedbooleanofDice", private.checkType)
static.GoldCost = WeField.new("ugol", 'int', "GoldCost", private.checkType)
static.HasTilesetSpecificData = WeField.new("utss", 'bool', "HasTilesetSpecificData", private.checkType)
static.HasWaterShadow = WeField.new("ushr", 'bool', "HasWaterShadow", private.checkType)
static.HideMinimapDisplay = WeField.new("uhom", 'bool', "HideMinimapDisplay", private.checkType)
static.HitPointsMaximumBase = WeField.new("uhpm", 'int', "HitPointsMaximumBase", private.checkType)
static.HitPointsRegenerationRate = WeField.new("uhpr", 'real', "HitPointsRegenerationRate", private.checkType)
static.HitPointsRegenerationType = WeField.new("uhrt", 'string', "HitPointsRegenerationType", private.checkType)
static.Hotkey = WeField.new("uhot", 'string', "Hotkey", private.checkType)
static.IconGameInterface = WeField.new("uico", 'string', "IconGameInterface", private.checkType)
static.IconScoreScreen = WeField.new("ussi", 'string', "IconScoreScreen", private.checkType)
static.IsaBuilding = WeField.new("ubdg", 'bool', "IsaBuilding", private.checkType)
static.ItemsSold = WeField.new("usei", 'string', "ItemsSold", private.checkType)
static.LumberBountyAwardedBase = WeField.new("ulba", 'int', "LumberBountyAwardedBase", private.checkType)
static.LumberBountyAwardedSidesperDie = WeField.new("ulbs", 'int', "LumberBountyAwardedSidesperDie", private.checkType)
static.LumberBountyAwardedbooleanofDice = WeField.new("ulbd", 'int', "LumberBountyAwardedbooleanofDice", private.checkType)
static.LumberCost = WeField.new("ulum", 'int', "LumberCost", private.checkType)
static.ManaInitialAmount = WeField.new("umpi", 'int', "ManaInitialAmount", private.checkType)
static.ManaMaximum = WeField.new("umpm", 'int', "ManaMaximum", private.checkType)
static.ManaRegeneration = WeField.new("umpr", 'real', "ManaRegeneration", private.checkType)
static.MaximumPitchAngledegrees = WeField.new("umxp", 'real', "MaximumPitchAngledegrees", private.checkType)
static.MaximumRollAngledegrees = WeField.new("umxr", 'real', "MaximumRollAngledegrees", private.checkType)
static.MinimumAttackRange = WeField.new("uamn", 'int', "MinimumAttackRange", private.checkType)
static.ModelFile = WeField.new("umdl", 'string', "ModelFile", private.checkPath)
static.ModelFileExtraVersions = WeField.new("uver", 'string', "ModelFileExtraVersions", private.checkType)
static.MovementHeight = WeField.new("umvh", 'real', "MovementHeight", private.checkType)
static.MovementHeightMinimum = WeField.new("umvf", 'real', "MovementHeightMinimum", private.checkType)
static.MovementSound = WeField.new("umsl", 'string', "MovementSound", private.checkType)
--- 'horse', 'fly', 'hover', 'float', 'amph'
static.MovementType = WeField.new("umvt", 'string', "MovementType", private.MovementType)
static.Name = WeField.new("unam", 'string', "Name", private.checkType)
static.NameEditorSuffix = WeField.new("unsf", 'string', "NameEditorSuffix", private.checkType)
static.NormalAbilities = WeField.new("uabi", 'string', "NormalAbilities", private.checkType)
static.OccluderHeight = WeField.new("uocc", 'real', "OccluderHeight", private.checkType)
static.OrientationInterpolation = WeField.new("uori", 'int', "OrientationInterpolation", private.checkType)
static.PlaceableInEditor = WeField.new("uine", 'bool', "PlaceableInEditor", private.checkType)
static.PointValue = WeField.new("upoi", 'int', "PointValue", private.checkType)
static.Priority = WeField.new("upri", 'int', "Priority", private.checkType)
static.ProjectileImpactZ = WeField.new("uimz", 'real', "ProjectileImpactZ", private.checkType)
static.ProjectileImpactZSwimming = WeField.new("uisz", 'real', "ProjectileImpactZSwimming", private.checkType)
static.ProjectileLaunchX = WeField.new("ulpx", 'real', "ProjectileLaunchX", private.checkType)
static.ProjectileLaunchY = WeField.new("ulpy", 'real', "ProjectileLaunchY", private.checkType)
static.ProjectileLaunchZ = WeField.new("ulpz", 'real', "ProjectileLaunchZ", private.checkType)
static.ProjectileLaunchZSwimming = WeField.new("ulsz", 'real', "ProjectileLaunchZSwimming", private.checkType)
static.PropulsionWindowdegrees = WeField.new("uprw", 'real', "PropulsionWindowdegrees", private.checkType)
--- 'commoner', 'creeps', 'critters', 'demon', 'human', 'naga', 'nightelf', 'orc', 'other', 'undead', 'unknown'
static.Race = WeField.new("urac", 'string', "Race", private.checkRace)
static.RandomSound = WeField.new("ursl", 'string', "RandomSound", private.checkType)
static.RepairGoldCost = WeField.new("ugor", 'int', "RepairGoldCost", private.checkType)
static.RepairLumberCost = WeField.new("ulur", 'int', "RepairLumberCost", private.checkType)
static.RepairTime = WeField.new("urtm", 'int', "RepairTime", private.checkType)
static.RequiredAnimationNames = WeField.new("uani", 'string', "RequiredAnimationNames", private.checkType)
static.RequiredAnimationNamesAttachments = WeField.new("uaap", 'string', "RequiredAnimationNamesAttachments", private.checkType)
static.RequiredAttachmentLinkNames = WeField.new("ualp", 'string', "RequiredAttachmentLinkNames", private.checkType)
static.RequiredBoneNames = WeField.new("ubpr", 'string', "RequiredBoneNames", private.checkType)
static.Requirements = WeField.new("ureq", 'string', "Requirements", private.checkType)
static.RequirementsLevels = WeField.new("urqa", 'string', "RequirementsLevels", private.checkType)
static.ScaleProjectiles = WeField.new("uscb", 'bool', "ScaleProjectiles", private.checkType)
static.ScalingValue = WeField.new("usca", 'real', "ScalingValue", private.checkType)
static.SelectionCircleHeight = WeField.new("uslz", 'real', "SelectionCircleHeight", private.checkType)
static.SelectionCircleOnWater = WeField.new("usew", 'bool', "SelectionCircleOnWater", private.checkType)
static.SelectionScale = WeField.new("ussc", 'real', "SelectionScale", private.checkType)
static.ShadowImageCenterX = WeField.new("ushx", 'real', "ShadowImageCenterX", private.checkType)
static.ShadowImageCenterY = WeField.new("ushy", 'real', "ShadowImageCenterY", private.checkType)
static.ShadowImageHeight = WeField.new("ushh", 'real', "ShadowImageHeight", private.checkType)
static.ShadowImageUnit = WeField.new("ushu", 'string', "ShadowImageUnit", private.checkType)
static.ShadowImageWidth = WeField.new("ushw", 'real', "ShadowImageWidth", private.checkType)
static.ShadowTextureBuilding = WeField.new("ushb", 'string', "ShadowTextureBuilding", private.checkType)
static.SightRadiusDay = WeField.new("usid", 'int', "SightRadiusDay", private.checkType)
static.SightRadiusNight = WeField.new("usin", 'int', "SightRadiusNight", private.checkType)
static.Sleeps = WeField.new("usle", 'bool', "Sleeps", private.checkType)
static.SoundLoopingFadeInRate = WeField.new("ulfi", 'int', "SoundLoopingFadeInRate", private.checkType)
static.SoundLoopingFadeOutRate = WeField.new("ulfo", 'int', "SoundLoopingFadeOutRate", private.checkType)
static.SpeedBase = WeField.new("umvs", 'int', "SpeedBase", private.checkType)
static.SpeedMaximum = WeField.new("umas", 'int', "SpeedMaximum", private.checkType)
static.SpeedMinimum = WeField.new("umis", 'int', "SpeedMinimum", private.checkType)
static.StockMaximum = WeField.new("usma", 'int', "StockMaximum", private.checkType)
static.StockReplenishInterval = WeField.new("usrg", 'int', "StockReplenishInterval", private.checkType)
static.StockStartDelay = WeField.new("usst", 'int', "StockStartDelay", private.checkType)
static.TargetedAs = WeField.new("utar", 'string', "TargetedAs", private.checkType)
static.TeamColor = WeField.new("utco", 'int', "TeamColor", private.checkType)
static.Tilesets = WeField.new("util", 'string', "Tilesets", private.checkType)
static.TintingColorBlue = WeField.new("uclb", 'int', "TintingColorBlue", private.checkType)
static.TintingColorGreen = WeField.new("uclg", 'int', "TintingColorGreen", private.checkType)
static.TintingColorRed = WeField.new("uclr", 'int', "TintingColorRed", private.checkType)
static.TooltipBasic = WeField.new("utip", 'string', "TooltipBasic", private.checkType)
static.TooltipExtended = WeField.new("utub", "string", "TooltipExtended", private.checkType)
static.TurnRate = WeField.new("umvr", 'real', "TurnRate", private.checkType)
static.UnitClassification = WeField.new("utyp", 'string', "UnitClassification", private.checkType)
static.UnitSoundSet = WeField.new("usnd", 'string', "UnitSoundSet", private.checkType)
static.UnitsSold = WeField.new("useu", 'string', "UnitsSold", private.checkType)
static.UpgradesUsed = WeField.new("upgr", 'string', "UpgradesUsed", private.checkType)
static.UseClickHelper = WeField.new("uuch", 'bool', "UseClickHelper", private.checkType)
static.UseExtendedLineofSight = WeField.new("ulos", 'bool', "UseExtendedLineofSight", private.checkType)

--=============
-- Hero fields
--=============
static.Hero_AgilityPerLevel = WeField.new("uagp", 'real', "AgilityPerLevel", private.checkType)
static.Hero_AgilityPerLevel = WeField.new("uagp", 'real', "AgilityPerLevel", private.checkType)
static.Hero_ConstructionSound = WeField.new("ubsl", 'string', "ConstructionSound", private.checkType)
static.Hero_FormationRank = WeField.new("ufor", 'int', "FormationRank", private.checkType)
static.Hero_GroundTexture = WeField.new("uubs", 'string', "GroundTexture", private.checkType)
static.Hero_GroupSeparationEnabled = WeField.new("urpo", 'bool', "GroupSeparationEnabled", private.checkType)
static.Hero_GroupSeparationGroupNumber = WeField.new("urpg", 'int', "GroupSeparationGroupNumber", private.checkType)
static.Hero_GroupSeparationParameter = WeField.new("urpp", 'int', "GroupSeparationParameter", private.checkType)
static.Hero_GroupSeparationPriority = WeField.new("urpr", 'int', "GroupSeparationPriority", private.checkType)
static.Hero_HeroAbilities = WeField.new("uhab", 'string', "HeroAbilities", private.checkType)
static.Hero_HeroAbilities = WeField.new("uhab", 'string', "HeroAbilities", private.checkType)
static.Hero_HeroRevivalLocations = WeField.new("urva", 'string', "HeroRevivalLocations", private.checkType)
static.Hero_HeroRevivalLocations = WeField.new("urva", 'string', "HeroRevivalLocations", private.checkType)
static.Hero_HideHeroDeathMsg = WeField.new("uhhd", 'bool', "HideHeroDeathMsg", private.checkType)
static.Hero_HideHeroInterfaceIcon = WeField.new("uhhb", 'bool', "HideHeroInterfaceIcon", private.checkType)
static.Hero_HideHeroMinimapDisplay = WeField.new("uhhm", 'bool', "HideHeroMinimapDisplay", private.checkType)
static.Hero_IntelligencePerLevel = WeField.new("uinp", 'real', "IntelligencePerLevel", private.checkType)
static.Hero_IntelligencePerLevel = WeField.new("uinp", 'real', "IntelligencePerLevel", private.checkType)
static.Hero_ItemsMade = WeField.new("umki", 'string', "ItemsMade", private.checkType)
static.Hero_Level = WeField.new("ulev", 'int', "Level", private.checkType)
static.Hero_NeutralBuildingShowsMinimapIcon = WeField.new("unbm", 'bool', "NeutralBuildingShowsMinimapIcon", private.checkType)
static.Hero_NeutralBuildingValidAsRandomBuilding = WeField.new("unbr", 'bool', "NeutralBuildingValidAsRandomBuilding", private.checkType)
static.Hero_PathingMap = WeField.new("upat", 'string', "PathingMap", private.checkType)
static.Hero_PlacementPreventedBy = WeField.new("upar", 'string', "PlacementPreventedBy", private.checkType)
static.Hero_PlacementRequires = WeField.new("upap", 'string', "PlacementRequires", private.checkType)
static.Hero_PlacementRequiresWaterRadius = WeField.new("upaw", 'real', "PlacementRequiresWaterRadius", private.checkType)
static.Hero_PrimaryAttribute = WeField.new("upra", 'string', "PrimaryAttribute", private.checkType)
static.Hero_PrimaryAttribute = WeField.new("upra", 'string', "PrimaryAttribute", private.checkType)
static.Hero_ProperNames = WeField.new("upro", 'string', "ProperNames", private.checkType)
static.Hero_ProperNames = WeField.new("upro", 'string', "ProperNames", private.checkType)
static.Hero_ProperNamesUsed = WeField.new("upru", 'int', "ProperNamesUsed", private.checkType)
static.Hero_ProperNamesUsed = WeField.new("upru", 'int', "ProperNamesUsed", private.checkType)
static.Hero_RequierementsForTier1 = WeField.new("urq0", 'string', "RequierementsForTier1", private.checkType)
static.Hero_RequierementsForTier2 = WeField.new("urq1", 'string', "RequierementsForTier2", private.checkType)
static.Hero_RequierementsForTier3 = WeField.new("urq2", 'string', "RequierementsForTier3", private.checkType)
static.Hero_RequierementsForTier4 = WeField.new("urq3", 'string', "RequierementsForTier4", private.checkType)
static.Hero_RequierementsForTier5 = WeField.new("urq4", 'string', "RequierementsForTier5", private.checkType)
static.Hero_RequierementsForTier6 = WeField.new("urq5", 'string', "RequierementsForTier6", private.checkType)
static.Hero_RequierementsForTier7 = WeField.new("urq6", 'string', "RequierementsForTier7", private.checkType)
static.Hero_RequierementsForTier8 = WeField.new("urq7", 'string', "RequierementsForTier8", private.checkType)
static.Hero_RequierementsForTier9 = WeField.new("urq8", 'string', "RequierementsForTier9", private.checkType)
static.Hero_ResearchesAvailable = WeField.new("ures", 'string', "ResearchesAvailable", private.checkType)
static.Hero_RevivesDeadHeros = WeField.new("urev", 'bool', "RevivesDeadHeros", private.checkType)
static.Hero_StartingAgility = WeField.new("uagi", 'int', "StartingAgility", private.checkType)
static.Hero_StartingAgility = WeField.new("uagi", 'int', "StartingAgility", private.checkType)
static.Hero_StartingIntelligence = WeField.new("uint", 'int', "StartingIntelligence", private.checkType)
static.Hero_StartingIntelligence = WeField.new("uint", 'int', "StartingIntelligence", private.checkType)
static.Hero_StartingStrength = WeField.new("ustr", 'int', "StartingStrength", private.checkType)
static.Hero_StartingStrength = WeField.new("ustr", 'int', "StartingStrength", private.checkType)
static.Hero_StrengthPerLevel = WeField.new("ustp", 'real', "StrengthPerLevel", private.checkType)
static.Hero_StrengthPerLevel = WeField.new("ustp", 'real', "StrengthPerLevel", private.checkType)
static.Hero_StructuresBuilt = WeField.new("ubui", 'string', "StructuresBuilt", private.checkType)
static.Hero_TooltipAwaken = WeField.new("uawt", 'string', "TooltipAwaken", private.checkType)
static.Hero_TooltipAwaken = WeField.new("uawt", 'string', "TooltipAwaken", private.checkType)
static.Hero_TooltipRevive = WeField.new("utpr", 'string', "TooltipRevive", private.checkType)
static.Hero_TooltipRevive = WeField.new("utpr", 'string', "TooltipRevive", private.checkType)
static.Hero_TransportedSize = WeField.new("ucar", 'int', "TransportedSize", private.checkType)
static.Hero_UnitsTrained = WeField.new("utra", 'string', "UnitsTrained", private.checkType)
static.Hero_UpgradesTo = WeField.new("uupt", 'string', "UpgradesTo", private.checkType)

--=================
-- Building fields
--=================
static.AgilityPerLevel = WeField.new("uagp", 'real', "AgilityPerLevel", private.checkType)
static.ConstructionSound = WeField.new("ubsl", 'string', "ConstructionSound", private.checkType)
static.ConstructionSound = WeField.new("ubsl", 'string', "ConstructionSound", private.checkType)
static.GroundTexture = WeField.new("uubs", 'string', "GroundTexture", private.checkType)
static.GroundTexture = WeField.new("uubs", 'string', "GroundTexture", private.checkType)
static.HeroAbilities = WeField.new("uhab", 'string', "HeroAbilities", private.checkType)
static.HeroRevivalLocations = WeField.new("urva", 'string', "HeroRevivalLocations", private.checkType)
static.IntelligencePerLevel = WeField.new("uinp", 'real', "IntelligencePerLevel", private.checkType)
static.ItemsMade = WeField.new("umki", 'string', "ItemsMade", private.checkType)
static.ItemsMade = WeField.new("umki", 'string', "ItemsMade", private.checkType)
static.NeutralBuildingShowsMinimapIcon = WeField.new("unbm", 'bool', "NeutralBuildingShowsMinimapIcon", private.checkType)
static.NeutralBuildingShowsMinimapIcon = WeField.new("unbm", 'bool', "NeutralBuildingShowsMinimapIcon", private.checkType)
static.NeutralBuildingValidAsRandomBuilding = WeField.new("unbr", 'bool', "NeutralBuildingValidAsRandomBuilding", private.checkType)
static.NeutralBuildingValidAsRandomBuilding = WeField.new("unbr", 'bool', "NeutralBuildingValidAsRandomBuilding", private.checkType)
static.PathingMap = WeField.new("upat", 'string', "PathingMap", private.checkType)
static.PathingMap = WeField.new("upat", 'string', "PathingMap", private.checkType)
static.PlacementPreventedBy = WeField.new("upar", 'string', "PlacementPreventedBy", private.checkType)
static.PlacementPreventedBy = WeField.new("upar", 'string', "PlacementPreventedBy", private.checkType)
static.PlacementRequires = WeField.new("upap", 'string', "PlacementRequires", private.checkType)
static.PlacementRequires = WeField.new("upap", 'string', "PlacementRequires", private.checkType)
static.PlacementRequiresWaterRadius = WeField.new("upaw", 'real', "PlacementRequiresWaterRadius", private.checkType)
static.PlacementRequiresWaterRadius = WeField.new("upaw", 'real', "PlacementRequiresWaterRadius", private.checkType)
static.PrimaryAttribute = WeField.new("upra", 'string', "PrimaryAttribute", private.checkType)
static.ProperNames = WeField.new("upro", 'string', "ProperNames", private.checkType)
static.ProperNamesUsed = WeField.new("upru", 'int', "ProperNamesUsed", private.checkType)
static.ResearchesAvailable = WeField.new("ures", 'string', "ResearchesAvailable", private.checkType)
static.ResearchesAvailable = WeField.new("ures", 'string', "ResearchesAvailable", private.checkType)
static.RevivesDeadHeros = WeField.new("urev", 'bool', "RevivesDeadHeros", private.checkType)
static.RevivesDeadHeros = WeField.new("urev", 'bool', "RevivesDeadHeros", private.checkType)
static.StartingAgility = WeField.new("uagi", 'int', "StartingAgility", private.checkType)
static.StartingIntelligence = WeField.new("uint", 'int', "StartingIntelligence", private.checkType)
static.StartingStrength = WeField.new("ustr", 'int', "StartingStrength", private.checkType)
static.StrengthPerLevel = WeField.new("ustp", 'real', "StrengthPerLevel", private.checkType)
static.TooltipAwaken = WeField.new("uawt", 'string', "TooltipAwaken", private.checkType)
static.TooltipRevive = WeField.new("utpr", 'string', "TooltipRevive", private.checkType)
static.UnitsTrained = WeField.new("utra", 'string', "UnitsTrained", private.checkType)
static.UnitsTrained = WeField.new("utra", 'string', "UnitsTrained", private.checkType)
static.UpgradesTo = WeField.new("uupt", 'string', "UpgradesTo", private.checkType)
static.UpgradesTo = WeField.new("uupt", 'string', "UpgradesTo", private.checkType)

return WeUnit