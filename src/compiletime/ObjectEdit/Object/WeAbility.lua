--=========
-- Include
--=========

require('utils.Globals')
local Log = require('utils.Log')
---@type WeAbilityFieldClass
local WeAbilityField = require('compiletime.ObjectEdit.WeAbilityField')
---@type WeObjectClass
local WeObject = require('compiletime.ObjectEdit.WeObject')
---@type WeObjectFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeObjectFile')
---@type WeUtils
local WeUtils = require('compiletime.ObjectEdit.WeUtils')

--=======
-- Class
--=======

---@type WeAbilityClass : WeObjectClass
local WeAbility = newClass('WeAbility', WeObject)

---@class WeAbility : WeObject
local public = WeAbility.public
---@class WeAbilityClass
local static = WeAbility.static
---@type table
local override = WeAbility.override
---@type table(WeAbility, table)
local private = {}

private.path_sep = package.config:sub(1,1)
private.file_src = _G._src_dir..private.path_sep..'war3map.w3a'
private.file_dst = _G._dst_dir..private.path_sep..'war3map.w3a'

private.field_serial_end = '\0\0\0\0'

--=========
-- Methods
--=========

---@param id number | string
---@param base_id number | string
---@param name string
---@param instance_data table | nil
---@return WeAbility
function override.new(id, base_id, name, instance_data)
    local instance = instance_data or newInstanceData(WeAbility)
    instance = WeObject.new(id, base_id, name, instance)

    local priv = {
        fields = {}
    }
    private[instance] = priv

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

---@param field WeAbilityField
---@param data any
function public:setField(field, lvl, data)
    local priv = private[self]

    if field:checkData(lvl, data) then
        if not priv.fields[field] then
            priv.fields[field] = {}
        end
        priv.fields[field][lvl] = data
    end
end

---@param field WeAbilityField
---@return table(number, any)
function public:getField(field)
    local priv = private[self]
    return priv.fields[field]
end

---@return table(WeAbilityField, table(number, any))
function public:getAllChanges()
    local priv = private[self]

    local copy = {}
    for k,v in pairs(priv.fields) do
        copy[k] = v
    end

    return copy
end

---@return table(string, table(number, data))
function public:toRuntime()
    local priv = private[self]

    local copy = {}
    for k,v in pairs(priv.fields) do
        if v[0] ~= nil then
            copy[k:getName()] = v[0]
        else
            copy[k:getName()] = deepcopy(v)
        end
    end
    copy.id = WeObject.public.getId(self)
    copy.base_id = WeObject.public.getBaseId(self)
    return copy
end

---@return string
function public:serialize()
    local priv = private[self]

    local fields_serial = {}
    for field, lvl_and_data in pairs(priv.fields) do
        for lvl, data in pairs(lvl_and_data) do
            local field_bytes = field:serialize(lvl, data)
            table.insert(fields_serial, 1, field_bytes..private.field_serial_end)
        end
    end

    local res = WeObject.public.getBaseId(self) .. WeObject.public.getId(self) .. WeUtils.int2byte(#fields_serial)
    for i = 1, #fields_serial do
        res = res..fields_serial[i]
    end
    return res
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
        local msg = fmt('wrong data type. Got %s. Need %s.',
                         type(data), data_type)
        Log(Log.Warn, field:getName(), msg)
    end
    return res
end

---@param field WeAbilityField
---@param lvl number
---@param data number
---@return boolean
function private.requireLevel(field, lvl, data)
    local success = private.checkType(field, data)
    if not success then
        return false
    end

    if lvl == 0 then        
        msg = fmt('requires level.')
        Log(Log.Warn, field:getName(), msg)
        return false
    end

    return true
end

function private.noLevel(field, lvl, data)
    if not private.checkType(field, data) then
        return false
    end

    if lvl ~= 0 then
        msg = fmt('does not require level. Use 0')
        Log(Log.Warn, field:getName(), msg)
        return false
    end

    return true
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

private.TargetsAllowed = {'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration',
'enemies', 'friend', 'ground', 'hero', 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient',
'none', 'nonhero', 'nonsapper', 'notself', 'organic', 'player', 'playerunits', 'sapper', 'self',
'structure', 'terrain', 'tree', 'vulnerable', 'wall'}
function private.checkAttackTargetsAllowed(field, lvl, data)
    return private.checkPossibleValues(field, data, private.AttackTargetsAllowed)
end

--====================
-- Any ability fields
--====================
static.AnimationNames = WeAbilityField.new("aani", 'string', 0, "AnimationNames", private.noLevel)
static.AreaEffect = WeAbilityField.new("aaea", 'string', 0, "AreaEffect", private.noLevel)
static.AreaOfEffect = WeAbilityField.new("aare", 'unreal', 0, "AreaOfEffect", private.noLevel)
static.ArtCaster = WeAbilityField.new("acat", 'string', 0, "ArtCaster", private.noLevel)
static.ArtEffect = WeAbilityField.new("aeat", 'string', 0, "ArtEffect", private.noLevel)
static.ArtSpecial = WeAbilityField.new("asat", 'string', 0, "ArtSpecial", private.noLevel)
static.ArtTarget = WeAbilityField.new("atat", 'string', 0, "ArtTarget", private.noLevel)
static.Buffs = WeAbilityField.new("abuf", 'string', 0, "Buffs", private.requireLevel)
static.ButtonPositionNormalX = WeAbilityField.new("abpx", 'int', 0, "ButtonPositionNormalX", private.noLevel)
static.ButtonPositionNormalY = WeAbilityField.new("abpy", 'int', 0, "ButtonPositionNormalY", private.noLevel)
static.ButtonPositionResearchX = WeAbilityField.new("arpx", 'int', 0, "ButtonPositionResearchX", private.noLevel)
static.ButtonPositionResearchY = WeAbilityField.new("arpy", 'int', 0, "ButtonPositionResearchY", private.noLevel)
static.ButtonPositionTurnOffX = WeAbilityField.new("aubx", 'int', 0, "ButtonPositionTurnOffX", private.noLevel)
static.ButtonPositionTurnOffY = WeAbilityField.new("auby", 'int', 0, "ButtonPositionTurnOffY", private.noLevel)
static.CastRange = WeAbilityField.new("aran", 'unreal', 0, "CastRange", private.requireLevel)
static.CasterAttachmentPoint = WeAbilityField.new("acap", 'string', 0, "CasterAttachmentPoint", private.noLevel)
static.CasterAttachmentPoint1 = WeAbilityField.new("aca1", 'string', 0, "CasterAttachmentPoint1", private.noLevel)
static.CasterAttachments = WeAbilityField.new("acac", 'int', 0, "CasterAttachments", private.noLevel)
static.CastingTime = WeAbilityField.new("acas", 'unreal', 0, "CastingTime", private.requireLevel)
static.CheckDependencies = WeAbilityField.new("achd", 'bool', 0, "CheckDependencies", private.noLevel)
static.Cooldown = WeAbilityField.new("acdn", 'unreal', 0, "Cooldown", private.requireLevel)
static.DurationHero = WeAbilityField.new("ahdu", 'unreal', 0, "DurationHero", private.requireLevel)
static.DurationNormal = WeAbilityField.new("adur", 'unreal', 0, "DurationNormal", private.requireLevel)
static.EditorSuffix = WeAbilityField.new("ansf", 'string', 0, "EditorSuffix", private.noLevel)
static.EffectSound = WeAbilityField.new("aefs", 'string', 0, "EffectSound", private.noLevel)
static.EffectSoundLooping = WeAbilityField.new("aefl", 'string', 0, "EffectSoundLooping", private.noLevel)
static.Effects = WeAbilityField.new("aeff", 'string', 0, "Effects", private.requireLevel)
static.HeroAbility = WeAbilityField.new("aher", 'bool', 0, "HeroAbility", private.noLevel)
static.HotkeyLearn = WeAbilityField.new("arhk", 'string', 0, "HotkeyLearn", private.noLevel)
static.HotkeyNormal = WeAbilityField.new("ahky", 'string', 0, "HotkeyNormal", private.noLevel)
static.HotkeyTurnOff = WeAbilityField.new("auhk", 'string', 0, "HotkeyTurnOff", private.noLevel)
static.IconNormal = WeAbilityField.new("aart", 'string', 0, "IconNormal", private.noLevel)
static.IconResearch = WeAbilityField.new("arar", 'string', 0, "IconResearch", private.noLevel)
static.IconTurnOff = WeAbilityField.new("auar", 'string', 0, "IconTurnOff", private.noLevel)
static.ItemAbility = WeAbilityField.new("aite", 'bool', 0, "ItemAbility", private.noLevel)
static.LevelSkipRequirement = WeAbilityField.new("alsk", 'int', 0, "LevelSkipRequirement", private.noLevel)
static.Levels = WeAbilityField.new("alev", 'int', 0, "Levels", private.noLevel)
static.LightningEffects = WeAbilityField.new("alig", 'string', 0, "LightningEffects", private.noLevel)
static.ManaCost = WeAbilityField.new("amcs", 'int', 0, "ManaCost", private.requireLevel)
static.MissileArc = WeAbilityField.new("amac", 'unreal', 0, "MissileArc", private.noLevel)
static.MissileArt = WeAbilityField.new("amat", 'string', 0, "MissileArt", private.noLevel)
static.MissileHomingEnabled = WeAbilityField.new("amho", 'bool', 0, "MissileHomingEnabled", private.noLevel)
static.MissileSpeed = WeAbilityField.new("amsp", 'int', 0, "MissileSpeed", private.noLevel)
static.Name = WeAbilityField.new("anam", 'string', 0, "Name", private.noLevel)
static.OrderStringActivate = WeAbilityField.new("aoro", 'string', 0, "OrderStringActivate", private.noLevel)
static.OrderStringDeactivate = WeAbilityField.new("aorf", 'string', 0, "OrderStringDeactivate", private.noLevel)
static.OrderStringTurnOff = WeAbilityField.new("aoru", 'string', 0, "OrderStringTurnOff", private.noLevel)
static.OrderStringUseTurnOn = WeAbilityField.new("aord", 'string', 0, "OrderStringUseTurnOn", private.noLevel)
static.PriorityForSpellSteal = WeAbilityField.new("apri", 'int', 0, "PriorityForSpellSteal", private.noLevel)
static.Race = WeAbilityField.new("arac", 'string', 0, "Race", private.noLevel)
static.RequiredLevel = WeAbilityField.new("arlv", 'int', 0, "RequiredLevel", private.noLevel)
static.Requirements = WeAbilityField.new("areq", 'string', 0, "Requirements", private.noLevel)
static.RequirementsLevels = WeAbilityField.new("arqa", 'string', 0, "RequirementsLevels", private.noLevel)
static.SpecialAttachmentPoint = WeAbilityField.new("aspt", 'string', 0, "SpecialAttachmentPoint", private.noLevel)
static.TargetAttachmentPoint = WeAbilityField.new("ata0", 'string', 0, "TargetAttachmentPoint", private.noLevel)
static.TargetAttachmentPoint1 = WeAbilityField.new("ata1", 'string', 0, "TargetAttachmentPoint1", private.noLevel)
static.TargetAttachmentPoint2 = WeAbilityField.new("ata2", 'string', 0, "TargetAttachmentPoint2", private.noLevel)
static.TargetAttachmentPoint3 = WeAbilityField.new("ata3", 'string', 0, "TargetAttachmentPoint3", private.noLevel)
static.TargetAttachmentPoint4 = WeAbilityField.new("ata4", 'string', 0, "TargetAttachmentPoint4", private.noLevel)
static.TargetAttachmentPoint5 = WeAbilityField.new("ata5", 'string', 0, "TargetAttachmentPoint5", private.noLevel)
static.TargetAttachments = WeAbilityField.new("atac", 'int', 0, "TargetAttachments", private.noLevel)
--- 'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration', 'enemies', 'friend', 'ground', 'hero',
--- 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient', 'none', 'nonhero', 'nonsapper', 'notself',
--- 'organic', 'player', 'playerunits', 'sapper', 'self', 'structure', 'terrain', 'tree', 'vulnerable', 'wall'
static.TargetsAllowed = WeAbilityField.new("atar", 'string', 0, "TargetsAllowed", private.checkAttackTargetsAllowed)
static.TooltipLearn = WeAbilityField.new("aret", 'string', 0, "TooltipLearn", private.noLevel)
static.TooltipLearnExtended = WeAbilityField.new("arut", 'string', 0, "TooltipLearnExtended", private.noLevel)
static.TooltipNormal = WeAbilityField.new("atp1", 'string', 0, "TooltipNormal", private.requireLevel)
static.TooltipNormalExtended = WeAbilityField.new("aub1", 'string', 0, "TooltipNormalExtended", private.requireLevel)
static.TooltipTurnOff = WeAbilityField.new("aut1", 'string', 0, "TooltipTurnOff", private.requireLevel)
static.TooltipTurnOffExtended = WeAbilityField.new("auu1", 'string', 0, "TooltipTurnOffExtended", private.requireLevel)

--=====================
-- ANcl Channel fields
--=====================
static.ANcl_ArtDuration = WeAbilityField.new("Ncl4", 'unreal', 4, "ArtDuration", private.requireLevel)
static.ANcl_BaseOrderID = WeAbilityField.new("Ncl6", 'string', 6, "BaseOrderID", private.requireLevel)
static.ANcl_DisableOtherAbilities = WeAbilityField.new("Ncl5", 'bool', 5, "DisableOtherAbilities", private.requireLevel)
static.ANcl_FollowThroughTime = WeAbilityField.new("Ncl1", 'unreal', 1, "FollowThroughTime", private.requireLevel)

static.ANcl_TargetType_None = 0
static.ANcl_TargetType_Unit = 1
static.ANcl_TargetType_Point = 2
static.ANcl_TargetType_UnitOrPoint = 3
--- 0 - none; 1 - unit; 2 - point; 3 - point or unit
static.ANcl_TargetType = WeAbilityField.new("Ncl2", 'int', 2, "TargetType", private.requireLevel)

static.ANcl_Options_Visible = 1
static.ANcl_Options_AreaTarget = 2
static.ANcl_Options_Material = 4
static.ANcl_Options_Universal = 8
static.ANcl_Options_Group = 16
--- Summ of flags: visible - 1, area target - 2, material - 4, universal - 8, group - 16
static.ANcl_Options = WeAbilityField.new("Ncl3", 'int', 3, "Options", private.requireLevel)

--=======================
-- Aasl Slow Aura fields
--=======================
static.MovementSpeedFactor = WeAbilityField.new("Slo1", 'unreal', 1, "MovementSpeedFactor", private.requireLevel)
static.AlwaysAutocast = WeAbilityField.new("Slo3", 'bool', 3, "AlwaysAutocast", private.requireLevel)
static.AttackSpeedFactor = WeAbilityField.new("Slo2", 'unreal', 2, "AttackSpeedFactor", private.requireLevel)

return WeAbility