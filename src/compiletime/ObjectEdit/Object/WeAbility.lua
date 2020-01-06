--=========
-- Include
--=========

local Class = require('utils.Class')
local Log = require('utils.Log')
local WeObject = require('compiletime.ObjectEdit.WeObject')

local WeAbilityField = require('compiletime.ObjectEdit.WeAbilityField')
---@type WeFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeFile')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeAbility = Class.newClass('WeAbility', WeObject)
---@class WeAbility
local public = WeAbility.public
---@class WeAbilityClass
local static = WeAbility.static
local override = WeAbility.override
local private = {}

--========
-- Static
--========

---@param id number | string
---@param base_id number | string
---@param name string
---@param child_data WeAbility | nil
---@return WeAbility
function override.new(id, base_id, name, child_data)
    local instance = Class.newInstanceData(WeAbility, child_data)
    instance = WeObject.new(id, base_id, name, instance)
    private.newData(instance)

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

static.AnimationNames = WeAbilityField.new("aani", 'string', 0, "AnimationNames", false)
static.AreaEffect = WeAbilityField.new("aaea", 'string', 0, "AreaEffect", false)
static.AreaOfEffect = WeAbilityField.new("aare", 'unreal', 0, "AreaOfEffect", false)
static.ArtCaster = WeAbilityField.new("acat", 'string', 0, "ArtCaster", false)
static.ArtEffect = WeAbilityField.new("aeat", 'string', 0, "ArtEffect", false)
static.ArtSpecial = WeAbilityField.new("asat", 'string', 0, "ArtSpecial", false)
static.ArtTarget = WeAbilityField.new("atat", 'string', 0, "ArtTarget", false)
static.Buffs = WeAbilityField.new("abuf", 'string', 0, "Buffs", true)
static.ButtonPositionNormalX = WeAbilityField.new("abpx", 'int', 0, "ButtonPositionNormalX", false)
static.ButtonPositionNormalY = WeAbilityField.new("abpy", 'int', 0, "ButtonPositionNormalY", false)
static.ButtonPositionResearchX = WeAbilityField.new("arpx", 'int', 0, "ButtonPositionResearchX", false)
static.ButtonPositionResearchY = WeAbilityField.new("arpy", 'int', 0, "ButtonPositionResearchY", false)
static.ButtonPositionTurnOffX = WeAbilityField.new("aubx", 'int', 0, "ButtonPositionTurnOffX", false)
static.ButtonPositionTurnOffY = WeAbilityField.new("auby", 'int', 0, "ButtonPositionTurnOffY", false)
static.CastRange = WeAbilityField.new("aran", 'unreal', 0, "CastRange", true)
static.CasterAttachmentPoint = WeAbilityField.new("acap", 'string', 0, "CasterAttachmentPoint", false)
static.CasterAttachmentPoint1 = WeAbilityField.new("aca1", 'string', 0, "CasterAttachmentPoint1", false)
static.CasterAttachments = WeAbilityField.new("acac", 'int', 0, "CasterAttachments", false)
static.CastingTime = WeAbilityField.new("acas", 'unreal', 0, "CastingTime", true)
static.CheckDependencies = WeAbilityField.new("achd", 'bool', 0, "CheckDependencies", false)
static.Cooldown = WeAbilityField.new("acdn", 'unreal', 0, "Cooldown", true)
static.DurationHero = WeAbilityField.new("ahdu", 'unreal', 0, "DurationHero", true)
static.DurationNormal = WeAbilityField.new("adur", 'unreal', 0, "DurationNormal", true)
static.EditorSuffix = WeAbilityField.new("ansf", 'string', 0, "EditorSuffix", false)
static.EffectSound = WeAbilityField.new("aefs", 'string', 0, "EffectSound", false)
static.EffectSoundLooping = WeAbilityField.new("aefl", 'string', 0, "EffectSoundLooping", false)
static.Effects = WeAbilityField.new("aeff", 'string', 0, "Effects", true)
static.HeroAbility = WeAbilityField.new("aher", 'bool', 0, "HeroAbility", false)
static.HotkeyLearn = WeAbilityField.new("arhk", 'string', 0, "HotkeyLearn", false)
static.HotkeyNormal = WeAbilityField.new("ahky", 'string', 0, "HotkeyNormal", false)
static.HotkeyTurnOff = WeAbilityField.new("auhk", 'string', 0, "HotkeyTurnOff", false)
static.IconNormal = WeAbilityField.new("aart", 'string', 0, "IconNormal", false)
static.IconResearch = WeAbilityField.new("arar", 'string', 0, "IconResearch", false)
static.IconTurnOff = WeAbilityField.new("auar", 'string', 0, "IconTurnOff", false)
static.ItemAbility = WeAbilityField.new("aite", 'bool', 0, "ItemAbility", false)
static.LevelSkipRequirement = WeAbilityField.new("alsk", 'int', 0, "LevelSkipRequirement", false)
static.Levels = WeAbilityField.new("alev", 'int', 0, "Levels", false)
static.LightningEffects = WeAbilityField.new("alig", 'string', 0, "LightningEffects", false)
static.ManaCost = WeAbilityField.new("amcs", 'int', 0, "ManaCost", true)
static.MissileArc = WeAbilityField.new("amac", 'unreal', 0, "MissileArc", false)
static.MissileArt = WeAbilityField.new("amat", 'string', 0, "MissileArt", false)
static.MissileHomingEnabled = WeAbilityField.new("amho", 'bool', 0, "MissileHomingEnabled", false)
static.MissileSpeed = WeAbilityField.new("amsp", 'int', 0, "MissileSpeed", false)
static.Name = WeAbilityField.new("anam", 'string', 0, "Name", false)
static.OrderStringActivate = WeAbilityField.new("aoro", 'string', 0, "OrderStringActivate", false)
static.OrderStringDeactivate = WeAbilityField.new("aorf", 'string', 0, "OrderStringDeactivate", false)
static.OrderStringTurnOff = WeAbilityField.new("aoru", 'string', 0, "OrderStringTurnOff", false)
static.OrderStringUseTurnOn = WeAbilityField.new("aord", 'string', 0, "OrderStringUseTurnOn", false)
static.PriorityForSpellSteal = WeAbilityField.new("apri", 'int', 0, "PriorityForSpellSteal", false)
static.Race = WeAbilityField.new("arac", 'string', 0, "Race", false)
static.RequiredLevel = WeAbilityField.new("arlv", 'int', 0, "RequiredLevel", false)
static.Requirements = WeAbilityField.new("areq", 'string', 0, "Requirements", false)
static.RequirementsLevels = WeAbilityField.new("arqa", 'string', 0, "RequirementsLevels", false)
static.SpecialAttachmentPoint = WeAbilityField.new("aspt", 'string', 0, "SpecialAttachmentPoint", false)
static.TargetAttachmentPoint = WeAbilityField.new("ata0", 'string', 0, "TargetAttachmentPoint", false)
static.TargetAttachmentPoint1 = WeAbilityField.new("ata1", 'string', 0, "TargetAttachmentPoint1", false)
static.TargetAttachmentPoint2 = WeAbilityField.new("ata2", 'string', 0, "TargetAttachmentPoint2", false)
static.TargetAttachmentPoint3 = WeAbilityField.new("ata3", 'string', 0, "TargetAttachmentPoint3", false)
static.TargetAttachmentPoint4 = WeAbilityField.new("ata4", 'string', 0, "TargetAttachmentPoint4", false)
static.TargetAttachmentPoint5 = WeAbilityField.new("ata5", 'string', 0, "TargetAttachmentPoint5", false)
static.TargetAttachments = WeAbilityField.new("atac", 'int', 0, "TargetAttachments", false)
--- 'air', 'alive', 'allies', 'ancient', 'dead', 'debris', 'decoration', 'enemies', 'friend', 'ground', 'hero',
--- 'invulnerable', 'item', 'mechanical', 'neutral', 'nonancient', 'none', 'nonhero', 'nonsapper', 'notself',
--- 'organic', 'player', 'playerunits', 'sapper', 'self', 'structure', 'terrain', 'tree', 'vulnerable', 'wall'
static.TargetsAllowed = WeAbilityField.new("atar", 'string', 0, "TargetsAllowed", true, function(field, data) WeAbilityField.compareWithList(field, data, private.TargetsAllowed) end)
static.TooltipLearn = WeAbilityField.new("aret", 'string', 0, "TooltipLearn", false)
static.TooltipLearnExtended = WeAbilityField.new("arut", 'string', 0, "TooltipLearnExtended", false)
static.TooltipNormal = WeAbilityField.new("atp1", 'string', 0, "TooltipNormal", true)
static.TooltipNormalExtended = WeAbilityField.new("aub1", 'string', 0, "TooltipNormalExtended", true)
static.TooltipTurnOff = WeAbilityField.new("aut1", 'string', 0, "TooltipTurnOff", true)
static.TooltipTurnOffExtended = WeAbilityField.new("auu1", 'string', 0, "TooltipTurnOffExtended", true)

--=====================
-- ANcl Channel fields
--=====================
static.ANcl_ArtDuration = WeAbilityField.new("Ncl4", 'unreal', 4, "ArtDuration", true)
static.ANcl_BaseOrderID = WeAbilityField.new("Ncl6", 'string', 6, "BaseOrderID", true)
static.ANcl_DisableOtherAbilities = WeAbilityField.new("Ncl5", 'bool', 5, "DisableOtherAbilities", true)
static.ANcl_FollowThroughTime = WeAbilityField.new("Ncl1", 'unreal', 1, "FollowThroughTime", true)

static.ANcl_TargetType_None = 0
static.ANcl_TargetType_Unit = 1
static.ANcl_TargetType_Point = 2
static.ANcl_TargetType_UnitOrPoint = 3
--- 0 - none; 1 - unit; 2 - point; 3 - point or unit
static.ANcl_TargetType = WeAbilityField.new("Ncl2", 'int', 2, "TargetType", true)

static.ANcl_Options_Visible = 1
static.ANcl_Options_AreaTarget = 2
static.ANcl_Options_Material = 4
static.ANcl_Options_Universal = 8
static.ANcl_Options_Group = 16
--- Summ of flags: visible - 1, area target - 2, material - 4, universal - 8, group - 16
static.ANcl_Options = WeAbilityField.new("Ncl3", 'int', 3, "Options", true)

--=======================
-- Aasl Slow Aura fields
--=======================
static.MovementSpeedFactor = WeAbilityField.new("Slo1", 'unreal', 1, "MovementSpeedFactor", true)
static.AlwaysAutocast = WeAbilityField.new("Slo3", 'bool', 3, "AlwaysAutocast", true)
static.AttackSpeedFactor = WeAbilityField.new("Slo2", 'unreal', 2, "AttackSpeedFactor", true)

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
private.file_src = _G._src_dir..private.path_sep..'war3map.w3a'
private.file_dst = _G._dst_dir..private.path_sep..'war3map.w3a'

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

return WeAbility