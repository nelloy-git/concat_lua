--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type WeObjectClass
local WeObject = require('compiletime.ObjectEdit.WeObject')
---@type WeAbilityFieldClass
local WeAbilityField = require('compiletime.ObjectEdit.WeAbilityField')
---@type WeFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeFile')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeAbility = Class.new('WeAbility', WeObject)
---@class WeAbility
local public = WeAbility.public
---@class WeAbilityClass
local static = WeAbility.static
---@type WeAbilityClass
local override = WeAbility.override
local private = {}

--========
-- Static
--========

---@param id number | string
---@param base_id number | string
---@param name string
---@param child_instance WeAbility | nil
---@return WeAbility
function override.new(id, base_id, name, child_instance)
    local instance = child_instance or Class.allocate(WeAbility, child_instance)

    instance = WeObject.new(id, base_id, name, instance)
    private.newData(instance)

    if not private.we_file then
        private.we_file = WeObjectFile.new(private.file_src, private.file_dst)
        AddCompileFinal(function() private.we_file:update() end)
    end
    private.we_file:addObject(instance)

    return instance
end

static.Field = {}
static.Field.AnimationNames = WeAbilityField.new("aani", 'string', 0, "AnimationNames", false)
static.Field.AreaEffect = WeAbilityField.new("aaea", 'string', 0, "AreaEffect", false)
static.Field.AreaOfEffect = WeAbilityField.new("aare", 'unreal', 0, "AreaOfEffect", false)
static.Field.ArtCaster = WeAbilityField.new("acat", 'string', 0, "ArtCaster", false)
static.Field.ArtEffect = WeAbilityField.new("aeat", 'string', 0, "ArtEffect", false)
static.Field.ArtSpecial = WeAbilityField.new("asat", 'string', 0, "ArtSpecial", false)
static.Field.ArtTarget = WeAbilityField.new("atat", 'string', 0, "ArtTarget", false)
static.Field.Buffs = WeAbilityField.new("abuf", 'string', 0, "Buffs", true)
static.Field.ButtonPositionNormalX = WeAbilityField.new("abpx", 'int', 0, "ButtonPositionNormalX", false)
static.Field.ButtonPositionNormalY = WeAbilityField.new("abpy", 'int', 0, "ButtonPositionNormalY", false)
static.Field.ButtonPositionResearchX = WeAbilityField.new("arpx", 'int', 0, "ButtonPositionResearchX", false)
static.Field.ButtonPositionResearchY = WeAbilityField.new("arpy", 'int', 0, "ButtonPositionResearchY", false)
static.Field.ButtonPositionTurnOffX = WeAbilityField.new("aubx", 'int', 0, "ButtonPositionTurnOffX", false)
static.Field.ButtonPositionTurnOffY = WeAbilityField.new("auby", 'int', 0, "ButtonPositionTurnOffY", false)
static.Field.CastRange = WeAbilityField.new("aran", 'unreal', 0, "CastRange", true)
static.Field.CasterAttachmentPoint = WeAbilityField.new("acap", 'string', 0, "CasterAttachmentPoint", false)
static.Field.CasterAttachmentPoint1 = WeAbilityField.new("aca1", 'string', 0, "CasterAttachmentPoint1", false)
static.Field.CasterAttachments = WeAbilityField.new("acac", 'int', 0, "CasterAttachments", false)
static.Field.CastingTime = WeAbilityField.new("acas", 'unreal', 0, "CastingTime", true)
static.Field.CheckDependencies = WeAbilityField.new("achd", 'bool', 0, "CheckDependencies", false)
static.Field.Cooldown = WeAbilityField.new("acdn", 'unreal', 0, "Cooldown", true)
static.Field.DurationHero = WeAbilityField.new("ahdu", 'unreal', 0, "DurationHero", true)
static.Field.DurationNormal = WeAbilityField.new("adur", 'unreal', 0, "DurationNormal", true)
static.Field.EditorSuffix = WeAbilityField.new("ansf", 'string', 0, "EditorSuffix", false)
static.Field.EffectSound = WeAbilityField.new("aefs", 'string', 0, "EffectSound", false)
static.Field.EffectSoundLooping = WeAbilityField.new("aefl", 'string', 0, "EffectSoundLooping", false)
static.Field.Effects = WeAbilityField.new("aeff", 'string', 0, "Effects", true)
static.Field.HeroAbility = WeAbilityField.new("aher", 'bool', 0, "HeroAbility", false)
static.Field.HotkeyLearn = WeAbilityField.new("arhk", 'string', 0, "HotkeyLearn", false)
static.Field.HotkeyNormal = WeAbilityField.new("ahky", 'string', 0, "HotkeyNormal", false)
static.Field.HotkeyTurnOff = WeAbilityField.new("auhk", 'string', 0, "HotkeyTurnOff", false)
static.Field.IconNormal = WeAbilityField.new("aart", 'string', 0, "IconNormal", false)
static.Field.IconResearch = WeAbilityField.new("arar", 'string', 0, "IconResearch", false)
static.Field.IconTurnOff = WeAbilityField.new("auar", 'string', 0, "IconTurnOff", false)
static.Field.ItemAbility = WeAbilityField.new("aite", 'bool', 0, "ItemAbility", false)
static.Field.LevelSkipRequirement = WeAbilityField.new("alsk", 'int', 0, "LevelSkipRequirement", false)
static.Field.Levels = WeAbilityField.new("alev", 'int', 0, "Levels", false)
static.Field.LightningEffects = WeAbilityField.new("alig", 'string', 0, "LightningEffects", false)
static.Field.ManaCost = WeAbilityField.new("amcs", 'int', 0, "ManaCost", true)
static.Field.MissileArc = WeAbilityField.new("amac", 'unreal', 0, "MissileArc", false)
static.Field.MissileArt = WeAbilityField.new("amat", 'string', 0, "MissileArt", false)
static.Field.MissileHomingEnabled = WeAbilityField.new("amho", 'bool', 0, "MissileHomingEnabled", false)
static.Field.MissileSpeed = WeAbilityField.new("amsp", 'int', 0, "MissileSpeed", false)
static.Field.Name = WeAbilityField.new("anam", 'string', 0, "Name", false)
static.Field.OrderStringActivate = WeAbilityField.new("aoro", 'string', 0, "OrderStringActivate", false)
static.Field.OrderStringDeactivate = WeAbilityField.new("aorf", 'string', 0, "OrderStringDeactivate", false)
static.Field.OrderStringTurnOff = WeAbilityField.new("aoru", 'string', 0, "OrderStringTurnOff", false)
static.Field.OrderStringUseTurnOn = WeAbilityField.new("aord", 'string', 0, "OrderStringUseTurnOn", false)
static.Field.PriorityForSpellSteal = WeAbilityField.new("apri", 'int', 0, "PriorityForSpellSteal", false)
static.Field.Race = WeAbilityField.new("arac", 'string', 0, "Race", false)
static.Field.RequiredLevel = WeAbilityField.new("arlv", 'int', 0, "RequiredLevel", false)
static.Field.Requirements = WeAbilityField.new("areq", 'string', 0, "Requirements", false)
static.Field.RequirementsLevels = WeAbilityField.new("arqa", 'string', 0, "RequirementsLevels", false)
static.Field.SpecialAttachmentPoint = WeAbilityField.new("aspt", 'string', 0, "SpecialAttachmentPoint", false)
static.Field.TargetAttachmentPoint = WeAbilityField.new("ata0", 'string', 0, "TargetAttachmentPoint", false)
static.Field.TargetAttachmentPoint1 = WeAbilityField.new("ata1", 'string', 0, "TargetAttachmentPoint1", false)
static.Field.TargetAttachmentPoint2 = WeAbilityField.new("ata2", 'string', 0, "TargetAttachmentPoint2", false)
static.Field.TargetAttachmentPoint3 = WeAbilityField.new("ata3", 'string', 0, "TargetAttachmentPoint3", false)
static.Field.TargetAttachmentPoint4 = WeAbilityField.new("ata4", 'string', 0, "TargetAttachmentPoint4", false)
static.Field.TargetAttachmentPoint5 = WeAbilityField.new("ata5", 'string', 0, "TargetAttachmentPoint5", false)
static.Field.TargetAttachments = WeAbilityField.new("atac", 'int', 0, "TargetAttachments", false)
--- 'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration', 'enemies', 'friend', 'ground', 'hero',
--- 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient', 'none', 'nonhero', 'nonsapper', 'notself',
--- 'organic', 'player', 'playerunits', 'sapper', 'self', 'structure', 'terrain', 'tree', 'vulnerable', 'wall'
static.Field.TargetsAllowed = WeAbilityField.new("atar", 'string', 0, "TargetsAllowed", true, function(field, data) WeAbilityField.compareWithList(field, data, private.TargetsAllowed) end)
static.Field.TooltipLearn = WeAbilityField.new("aret", 'string', 0, "TooltipLearn", false)
static.Field.TooltipLearnExtended = WeAbilityField.new("arut", 'string', 0, "TooltipLearnExtended", false)
static.Field.TooltipNormal = WeAbilityField.new("atp1", 'string', 0, "TooltipNormal", true)
static.Field.TooltipNormalExtended = WeAbilityField.new("aub1", 'string', 0, "TooltipNormalExtended", true)
static.Field.TooltipTurnOff = WeAbilityField.new("aut1", 'string', 0, "TooltipTurnOff", true)
static.Field.TooltipTurnOffExtended = WeAbilityField.new("auu1", 'string', 0, "TooltipTurnOffExtended", true)

--=====================
-- ANcl Channel fields
--=====================
static.Field.ANcl_ArtDuration = WeAbilityField.new("Ncl4", 'unreal', 4, "ArtDuration", true)
static.Field.ANcl_BaseOrderID = WeAbilityField.new("Ncl6", 'string', 6, "BaseOrderID", true)
static.Field.ANcl_DisableOtherAbilities = WeAbilityField.new("Ncl5", 'bool', 5, "DisableOtherAbilities", true)
static.Field.ANcl_FollowThroughTime = WeAbilityField.new("Ncl1", 'unreal', 1, "FollowThroughTime", true)

static.Field.ANcl_TargetType_None = 0
static.Field.ANcl_TargetType_Unit = 1
static.Field.ANcl_TargetType_Point = 2
static.Field.ANcl_TargetType_UnitOrPoint = 3
--- 0 - none; 1 - unit; 2 - point; 3 - point or unit
static.Field.ANcl_TargetType = WeAbilityField.new("Ncl2", 'int', 2, "TargetType", true)

static.Field.ANcl_Options_Visible = 1
static.Field.ANcl_Options_AreaTarget = 2
static.Field.ANcl_Options_Material = 4
static.Field.ANcl_Options_Universal = 8
static.Field.ANcl_Options_Group = 16
--- Summ of flags: visible - 1, area target - 2, material - 4, universal - 8, group - 16
static.Field.ANcl_Options = WeAbilityField.new("Ncl3", 'int', 3, "Options", true)

--=======================
-- Aasl Slow Aura fields
--=======================
static.Field.MovementSpeedFactor = WeAbilityField.new("Slo1", 'unreal', 1, "MovementSpeedFactor", true)
static.Field.AlwaysAutocast = WeAbilityField.new("Slo3", 'bool', 3, "AlwaysAutocast", true)
static.Field.AttackSpeedFactor = WeAbilityField.new("Slo2", 'unreal', 2, "AttackSpeedFactor", true)

--========
-- Public
--========

---@param field WeAbilityField
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

---@param field WeAbilityField
---@return table(number, any)
function public:getField(field)
    return private[self].fields[field]
end

---@return table<WeAbilityField, table<number, any>>
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
    copy.id = WeObject.public.getId(self)
    copy.base_id = WeObject.public.getBaseId(self)
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

    local res = WeObject.public.getBaseId(self) .. WeObject.public.getId(self) .. WeUtils.int2byte(#fields_serial)
    for i = 1, #fields_serial do
        res = res..fields_serial[i]
    end
    return res
end

function public:free()
    private.freeData(self)
    WeObject.public.free(self)
end

--=========
-- Private
--=========

private.path_sep = package.config:sub(1,1)
private.file_src = GetSrcDir()..private.path_sep..'war3map.w3a'
private.file_dst = GetDstDir()..private.path_sep..'war3map.w3a'

private.field_serial_end = '\0\0\0\0'

private.TargetsAllowed = {'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration',
'enemies', 'friend', 'ground', 'hero', 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient',
'none', 'nonhero', 'nonsapper', 'notself', 'organic', 'player', 'playerunits', 'sapper', 'self',
'structure', 'terrain', 'tree', 'vulnerable', 'wall'}

---@param self WeAbility
function private.newData(self)
    local priv = {
        fields = {}
    }
    private[self] = priv
end

---@param self WeAbility
function private.freeData(self)
    private[self] = nil
end

return WeAbility.static