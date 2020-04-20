--=========
-- Include
--=========

local Class = require('Utils.Class.Class')
local Log = require('Utils.Log')

---@type WeObjectClass
local WeObject = require('compiletime.ObjectEdit.WeObject')
---@type WeAbilityOldFieldClass
local WeAbilityOldField = require('compiletime.ObjectEdit.WeAbilityOldField')
---@type WeFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeFile')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeAbilityOld = Class.new('WeAbilityOld', WeObject)
---@class WeAbilityOld : WeObject
local public = WeAbilityOld.public
---@class WeAbilityOldClass : WeObjectClass
local static = WeAbilityOld.static
---@type WeAbilityOldClass
local override = WeAbilityOld.override
local private = {}

--========
-- Static
--========

---@param id number | string
---@param base_id number | string
---@param name string
---@param child_instance WeAbilityOld | nil
---@return WeAbilityOld
function override.new(id, base_id, name, child_instance)
    local instance = child_instance or Class.allocate(WeAbilityOld, child_instance)

    instance = WeObject.new(id, base_id, name, instance)
    private.newData(instance)

    if not private.we_file then
        private.we_file = WeObjectFile.new(private.file_src, private.file_dst)
    end
    private.we_file:addObject(instance)

    return instance
end

static.Field = {}
static.Field.AnimationNames = WeAbilityOldField.new("aani", 'string', 0, "AnimationNames", false)
static.Field.AreaEffect = WeAbilityOldField.new("aaea", 'string', 0, "AreaEffect", false)
static.Field.AreaOfEffect = WeAbilityOldField.new("aare", 'unreal', 0, "AreaOfEffect", false)
static.Field.ArtCaster = WeAbilityOldField.new("acat", 'string', 0, "ArtCaster", false)
static.Field.ArtEffect = WeAbilityOldField.new("aeat", 'string', 0, "ArtEffect", false)
static.Field.ArtSpecial = WeAbilityOldField.new("asat", 'string', 0, "ArtSpecial", false)
static.Field.ArtTarget = WeAbilityOldField.new("atat", 'string', 0, "ArtTarget", false)
static.Field.Buffs = WeAbilityOldField.new("abuf", 'string', 0, "Buffs", true)
static.Field.ButtonPositionNormalX = WeAbilityOldField.new("abpx", 'int', 0, "ButtonPositionNormalX", false)
static.Field.ButtonPositionNormalY = WeAbilityOldField.new("abpy", 'int', 0, "ButtonPositionNormalY", false)
static.Field.ButtonPositionResearchX = WeAbilityOldField.new("arpx", 'int', 0, "ButtonPositionResearchX", false)
static.Field.ButtonPositionResearchY = WeAbilityOldField.new("arpy", 'int', 0, "ButtonPositionResearchY", false)
static.Field.ButtonPositionTurnOffX = WeAbilityOldField.new("aubx", 'int', 0, "ButtonPositionTurnOffX", false)
static.Field.ButtonPositionTurnOffY = WeAbilityOldField.new("auby", 'int', 0, "ButtonPositionTurnOffY", false)
static.Field.CastRange = WeAbilityOldField.new("aran", 'unreal', 0, "CastRange", true)
static.Field.CasterAttachmentPoint = WeAbilityOldField.new("acap", 'string', 0, "CasterAttachmentPoint", false)
static.Field.CasterAttachmentPoint1 = WeAbilityOldField.new("aca1", 'string', 0, "CasterAttachmentPoint1", false)
static.Field.CasterAttachments = WeAbilityOldField.new("acac", 'int', 0, "CasterAttachments", false)
static.Field.CastingTime = WeAbilityOldField.new("acas", 'unreal', 0, "CastingTime", true)
static.Field.CheckDependencies = WeAbilityOldField.new("achd", 'bool', 0, "CheckDependencies", false)
static.Field.Cooldown = WeAbilityOldField.new("acdn", 'unreal', 0, "Cooldown", true)
static.Field.DurationHero = WeAbilityOldField.new("ahdu", 'unreal', 0, "DurationHero", true)
static.Field.DurationNormal = WeAbilityOldField.new("adur", 'unreal', 0, "DurationNormal", true)
static.Field.EditorSuffix = WeAbilityOldField.new("ansf", 'string', 0, "EditorSuffix", false)
static.Field.EffectSound = WeAbilityOldField.new("aefs", 'string', 0, "EffectSound", false)
static.Field.EffectSoundLooping = WeAbilityOldField.new("aefl", 'string', 0, "EffectSoundLooping", false)
static.Field.Effects = WeAbilityOldField.new("aeff", 'string', 0, "Effects", true)
static.Field.HeroAbilityOld = WeAbilityOldField.new("aher", 'bool', 0, "HeroAbilityOld", false)
static.Field.HotkeyLearn = WeAbilityOldField.new("arhk", 'string', 0, "HotkeyLearn", false)
static.Field.HotkeyNormal = WeAbilityOldField.new("ahky", 'string', 0, "HotkeyNormal", false)
static.Field.HotkeyTurnOff = WeAbilityOldField.new("auhk", 'string', 0, "HotkeyTurnOff", false)
static.Field.IconNormal = WeAbilityOldField.new("aart", 'string', 0, "IconNormal", false)
static.Field.IconResearch = WeAbilityOldField.new("arar", 'string', 0, "IconResearch", false)
static.Field.IconTurnOff = WeAbilityOldField.new("auar", 'string', 0, "IconTurnOff", false)
static.Field.ItemAbilityOld = WeAbilityOldField.new("aite", 'bool', 0, "ItemAbilityOld", false)
static.Field.LevelSkipRequirement = WeAbilityOldField.new("alsk", 'int', 0, "LevelSkipRequirement", false)
static.Field.Levels = WeAbilityOldField.new("alev", 'int', 0, "Levels", false)
static.Field.LightningEffects = WeAbilityOldField.new("alig", 'string', 0, "LightningEffects", false)
static.Field.ManaCost = WeAbilityOldField.new("amcs", 'int', 0, "ManaCost", true)
static.Field.MissileArc = WeAbilityOldField.new("amac", 'unreal', 0, "MissileArc", false)
static.Field.MissileArt = WeAbilityOldField.new("amat", 'string', 0, "MissileArt", false)
static.Field.MissileHomingEnabled = WeAbilityOldField.new("amho", 'bool', 0, "MissileHomingEnabled", false)
static.Field.MissileSpeed = WeAbilityOldField.new("amsp", 'int', 0, "MissileSpeed", false)
static.Field.Name = WeAbilityOldField.new("anam", 'string', 0, "Name", false)
static.Field.OrderStringActivate = WeAbilityOldField.new("aoro", 'string', 0, "OrderStringActivate", false)
static.Field.OrderStringDeactivate = WeAbilityOldField.new("aorf", 'string', 0, "OrderStringDeactivate", false)
static.Field.OrderStringTurnOff = WeAbilityOldField.new("aoru", 'string', 0, "OrderStringTurnOff", false)
static.Field.OrderStringUseTurnOn = WeAbilityOldField.new("aord", 'string', 0, "OrderStringUseTurnOn", false)
static.Field.PriorityForSpellSteal = WeAbilityOldField.new("apri", 'int', 0, "PriorityForSpellSteal", false)
static.Field.Race = WeAbilityOldField.new("arac", 'string', 0, "Race", false)
static.Field.RequiredLevel = WeAbilityOldField.new("arlv", 'int', 0, "RequiredLevel", false)
static.Field.Requirements = WeAbilityOldField.new("areq", 'string', 0, "Requirements", false)
static.Field.RequirementsLevels = WeAbilityOldField.new("arqa", 'string', 0, "RequirementsLevels", false)
static.Field.SpecialAttachmentPoint = WeAbilityOldField.new("aspt", 'string', 0, "SpecialAttachmentPoint", false)
static.Field.TargetAttachmentPoint = WeAbilityOldField.new("ata0", 'string', 0, "TargetAttachmentPoint", false)
static.Field.TargetAttachmentPoint1 = WeAbilityOldField.new("ata1", 'string', 0, "TargetAttachmentPoint1", false)
static.Field.TargetAttachmentPoint2 = WeAbilityOldField.new("ata2", 'string', 0, "TargetAttachmentPoint2", false)
static.Field.TargetAttachmentPoint3 = WeAbilityOldField.new("ata3", 'string', 0, "TargetAttachmentPoint3", false)
static.Field.TargetAttachmentPoint4 = WeAbilityOldField.new("ata4", 'string', 0, "TargetAttachmentPoint4", false)
static.Field.TargetAttachmentPoint5 = WeAbilityOldField.new("ata5", 'string', 0, "TargetAttachmentPoint5", false)
static.Field.TargetAttachments = WeAbilityOldField.new("atac", 'int', 0, "TargetAttachments", false)
--- 'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration', 'enemies', 'friend', 'ground', 'hero',
--- 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient', 'none', 'nonhero', 'nonsapper', 'notself',
--- 'organic', 'player', 'playerunits', 'sapper', 'self', 'structure', 'terrain', 'tree', 'vulnerable', 'wall'
static.Field.TargetsAllowed = WeAbilityOldField.new("atar", 'string', 0, "TargetsAllowed", true, function(field, data) return WeAbilityOldField.compareWithList(field, data, private.TargetsAllowed) end)
static.Field.TooltipLearn = WeAbilityOldField.new("aret", 'string', 0, "TooltipLearn", false)
static.Field.TooltipLearnExtended = WeAbilityOldField.new("arut", 'string', 0, "TooltipLearnExtended", false)
static.Field.TooltipNormal = WeAbilityOldField.new("atp1", 'string', 0, "TooltipNormal", true)
static.Field.TooltipNormalExtended = WeAbilityOldField.new("aub1", 'string', 0, "TooltipNormalExtended", true)
static.Field.TooltipTurnOff = WeAbilityOldField.new("aut1", 'string', 0, "TooltipTurnOff", true)
static.Field.TooltipTurnOffExtended = WeAbilityOldField.new("auu1", 'string', 0, "TooltipTurnOffExtended", true)

--=====================
-- ANcl Channel fields
--=====================
static.Field.ANcl_ArtDuration = WeAbilityOldField.new("Ncl4", 'unreal', 4, "ArtDuration", true)
static.Field.ANcl_BaseOrderID = WeAbilityOldField.new("Ncl6", 'string', 6, "BaseOrderID", true)
static.Field.ANcl_DisableOtherAbilities = WeAbilityOldField.new("Ncl5", 'bool', 5, "DisableOtherAbilities", true)
static.Field.ANcl_FollowThroughTime = WeAbilityOldField.new("Ncl1", 'unreal', 1, "FollowThroughTime", true)

static.ANcl_Target = {}
static.ANcl_Target.None = 0
static.ANcl_Target.Unit = 1
static.ANcl_Target.Point = 2
static.ANcl_Target.UnitOrPoint = 3
--- 0 - none; 1 - unit; 2 - point; 3 - point or unit
static.Field.ANcl_TargetType = WeAbilityOldField.new("Ncl2", 'int', 2, "TargetType", true)

static.ANcl_Option = {}
static.ANcl_Option.Visible = 1
static.ANcl_Option.AreaTarget = 2
static.ANcl_Option.Material = 4
static.ANcl_Option.Universal = 8
static.ANcl_Option.Group = 16
--- Summ of flags: visible - 1, area target - 2, material - 4, universal - 8, group - 16
static.Field.ANcl_Options = WeAbilityOldField.new("Ncl3", 'int', 3, "Options", true)

--=======================
-- Aasl Slow Aura fields
--=======================
static.Field.Aasl_MovementSpeedFactor = WeAbilityOldField.new("Slo1", 'unreal', 1, "MovementSpeedFactor", true)
static.Field.Aasl_AlwaysAutocast = WeAbilityOldField.new("Slo3", 'bool', 3, "AlwaysAutocast", true)
static.Field.Aasl_AttackSpeedFactor = WeAbilityOldField.new("Slo2", 'unreal', 2, "AttackSpeedFactor", true)

--========
-- Public
--========

---@param field WeAbilityOldField
---@param data any
function public:setField(field, lvl, data)
    local priv = private[self]

    if field:isValid(data, lvl) then
        if not priv.fields[field] then
            priv.fields[field] = {}
        end
        priv.fields[field][lvl] = data
    end
end

---@param field WeAbilityOldField
---@return table(number, any)
function public:getField(field)
    return private[self].fields[field]
end

---@return table<WeAbilityOldField, table<number, any>>
function public:getAllChanges()
    local priv = private[self]

    local copy = {}
    for k,v in pairs(priv.fields) do
        copy[k] = v
    end

    return copy
end

---@return table<string, table<number, any>>
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
    copy.id = private.WeObjectPublic.getId(self)
    copy.base_id = private.WeObjectPublic.getBaseId(self)
    return copy
end

---@return string
function public:printChanges()
    local priv = private[self]

    local str_changes = ''
    for field, list in pairs(priv.fields) do
        local str_lvls = ''
        for lvl, data in pairs(list) do
            local q = ''
            if type(data) == 'string' then
                q = '\"'
            end
            str_lvls = str_lvls..string.format('\t\t%d - %s%s%s\n', lvl, q, tostring(data), q)
        end
        str_changes = str_changes..string.format('\t%s:\n%s', field:getName(), str_lvls)
    end

    return str_changes
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

    local res = private.WeObjectPublic.getBaseId(self) .. private.WeObjectPublic.getId(self) .. WeUtils.int2byte(#fields_serial)
    for i = 1, #fields_serial do
        res = res..fields_serial[i]
    end
    return res
end

function public:free()
    private.freeData(self)
    private.WeObjectPublic.free(self)
end

--=========
-- Private
--=========

private.WeObjectPublic = Class.getPublic(WeObject)
private.path_sep = package.config:sub(1,1)
private.file_src = GetSrcDir()..private.path_sep..'war3map.w3a'
private.file_dst = GetDstDir()..private.path_sep..'war3map.w3a'

private.field_serial_end = '\0\0\0\0'

private.TargetsAllowed = {'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration',
'enemies', 'friend', 'ground', 'hero', 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient',
'none', 'nonhero', 'nonsapper', 'notself', 'organic', 'player', 'playerunits', 'sapper', 'self',
'structure', 'terrain', 'tree', 'vulnerable', 'wall'}

---@param self WeAbilityOld
function private.newData(self)
    local priv = {
        fields = {}
    }
    private[self] = priv
end

---@param self WeAbilityOld
function private.freeData(self)
    private[self] = nil
end

return WeAbilityOld.static