--=========
-- Include
--=========

require('utils.Globals')
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

---@type WeAbilityObjectClass : WeObjectClass
local WeAbilityObject = newClass('WeAbilityObject', WeObject)

---@class WeAbilityObject : WeObject
local public = WeAbilityObject.public
---@class WeAbilityObjectClass
local static = WeAbilityObject.static
---@type table
local override = WeAbilityObject.override
---@type table(WeAbilityObject, table)
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
---@return WeAbilityObject
function override.new(id, base_id, name, instance_data)
    local instance = instance_data or newInstanceData(WeAbilityObject)
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

    if not priv.fields[field] then
        priv.fields[field] = {}
    end
    priv.fields[field][lvl] = data
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
        copy[k:getName()] = deepcopy(v)
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

--====================
-- Any ability fields
--====================
static.AnimationNames = WeAbilityField.new("aani", 'string', 0, "AnimationNames")
static.AreaEffect = WeAbilityField.new("aaea", 'string', 0, "AreaEffect")
static.AreaOfEffect = WeAbilityField.new("aare", 'unreal', 0, "AreaOfEffect")
static.ArtCaster = WeAbilityField.new("acat", 'string', 0, "ArtCaster")
static.ArtEffect = WeAbilityField.new("aeat", 'string', 0, "ArtEffect")
static.ArtSpecial = WeAbilityField.new("asat", 'string', 0, "ArtSpecial")
static.ArtTarget = WeAbilityField.new("atat", 'string', 0, "ArtTarget")
static.Buffs = WeAbilityField.new("abuf", 'string', 0, "Buffs")
static.ButtonPositionNormalX = WeAbilityField.new("abpx", 'int', 0, "ButtonPositionNormalX")
static.ButtonPositionNormalY = WeAbilityField.new("abpy", 'int', 0, "ButtonPositionNormalY")
static.ButtonPositionResearchX = WeAbilityField.new("arpx", 'int', 0, "ButtonPositionResearchX")
static.ButtonPositionResearchY = WeAbilityField.new("arpy", 'int', 0, "ButtonPositionResearchY")
static.ButtonPositionTurnOffX = WeAbilityField.new("aubx", 'int', 0, "ButtonPositionTurnOffX")
static.ButtonPositionTurnOffY = WeAbilityField.new("auby", 'int', 0, "ButtonPositionTurnOffY")
static.CastRange = WeAbilityField.new("aran", 'unreal', 0, "CastRange")
static.CasterAttachmentPoint = WeAbilityField.new("acap", 'string', 0, "CasterAttachmentPoint")
static.CasterAttachmentPoint1 = WeAbilityField.new("aca1", 'string', 0, "CasterAttachmentPoint1")
static.CasterAttachments = WeAbilityField.new("acac", 'int', 0, "CasterAttachments")
static.CastingTime = WeAbilityField.new("acas", 'unreal', 0, "CastingTime")
static.CheckDependencies = WeAbilityField.new("achd", 'bool', 0, "CheckDependencies")
static.Cooldown = WeAbilityField.new("acdn", 'unreal', 0, "Cooldown")
static.DurationHero = WeAbilityField.new("ahdu", 'unreal', 0, "DurationHero")
static.DurationNormal = WeAbilityField.new("adur", 'unreal', 0, "DurationNormal")
static.EditorSuffix = WeAbilityField.new("ansf", 'string', 0, "EditorSuffix")
static.EffectSound = WeAbilityField.new("aefs", 'string', 0, "EffectSound")
static.EffectSoundLooping = WeAbilityField.new("aefl", 'string', 0, "EffectSoundLooping")
static.Effects = WeAbilityField.new("aeff", 'string', 0, "Effects")
static.HeroAbility = WeAbilityField.new("aher", 'bool', 0, "HeroAbility")
static.HotkeyLearn = WeAbilityField.new("arhk", 'string', 0, "HotkeyLearn")
static.HotkeyNormal = WeAbilityField.new("ahky", 'string', 0, "HotkeyNormal")
static.HotkeyTurnOff = WeAbilityField.new("auhk", 'string', 0, "HotkeyTurnOff")
static.IconNormal = WeAbilityField.new("aart", 'string', 0, "IconNormal")
static.IconResearch = WeAbilityField.new("arar", 'string', 0, "IconResearch")
static.IconTurnOff = WeAbilityField.new("auar", 'string', 0, "IconTurnOff")
static.ItemAbility = WeAbilityField.new("aite", 'bool', 0, "ItemAbility")
static.LevelSkipRequirement = WeAbilityField.new("alsk", 'int', 0, "LevelSkipRequirement")
static.Levels = WeAbilityField.new("alev", 'int', 0, "Levels")
static.LightningEffects = WeAbilityField.new("alig", 'string', 0, "LightningEffects")
static.ManaCost = WeAbilityField.new("amcs", 'int', 0, "ManaCost")
static.MissileArc = WeAbilityField.new("amac", 'unreal', 0, "MissileArc")
static.MissileArt = WeAbilityField.new("amat", 'string', 0, "MissileArt")
static.MissileHomingEnabled = WeAbilityField.new("amho", 'bool', 0, "MissileHomingEnabled")
static.MissileSpeed = WeAbilityField.new("amsp", 'int', 0, "MissileSpeed")
static.Name = WeAbilityField.new("anam", 'string', 0, "Name")
static.OrderStringActivate = WeAbilityField.new("aoro", 'string', 0, "OrderStringActivate")
static.OrderStringDeactivate = WeAbilityField.new("aorf", 'string', 0, "OrderStringDeactivate")
static.OrderStringTurnOff = WeAbilityField.new("aoru", 'string', 0, "OrderStringTurnOff")
static.OrderStringUseTurnOn = WeAbilityField.new("aord", 'string', 0, "OrderStringUseTurnOn")
static.PriorityForSpellSteal = WeAbilityField.new("apri", 'int', 0, "PriorityForSpellSteal")
static.Race = WeAbilityField.new("arac", 'string', 0, "Race")
static.RequiredLevel = WeAbilityField.new("arlv", 'int', 0, "RequiredLevel")
static.Requirements = WeAbilityField.new("areq", 'string', 0, "Requirements")
static.RequirementsLevels = WeAbilityField.new("arqa", 'string', 0, "RequirementsLevels")
static.SpecialAttachmentPoint = WeAbilityField.new("aspt", 'string', 0, "SpecialAttachmentPoint")
static.TargetAttachmentPoint = WeAbilityField.new("ata0", 'string', 0, "TargetAttachmentPoint")
static.TargetAttachmentPoint1 = WeAbilityField.new("ata1", 'string', 0, "TargetAttachmentPoint1")
static.TargetAttachmentPoint2 = WeAbilityField.new("ata2", 'string', 0, "TargetAttachmentPoint2")
static.TargetAttachmentPoint3 = WeAbilityField.new("ata3", 'string', 0, "TargetAttachmentPoint3")
static.TargetAttachmentPoint4 = WeAbilityField.new("ata4", 'string', 0, "TargetAttachmentPoint4")
static.TargetAttachmentPoint5 = WeAbilityField.new("ata5", 'string', 0, "TargetAttachmentPoint5")
static.TargetAttachments = WeAbilityField.new("atac", 'int', 0, "TargetAttachments")
static.TargetsAllowed = WeAbilityField.new("atar", 'string', 0, "TargetsAllowed")
static.TooltipLearn = WeAbilityField.new("aret", 'string', 0, "TooltipLearn")
static.TooltipLearnExtended = WeAbilityField.new("arut", 'string', 0, "TooltipLearnExtended")
static.TooltipNormal = WeAbilityField.new("atp1", 'string', 0, "TooltipNormal")
static.TooltipNormalExtended = WeAbilityField.new("aub1", 'string', 0, "TooltipNormalExtended")
static.TooltipTurnOff = WeAbilityField.new("aut1", 'string', 0, "TooltipTurnOff")
static.TooltipTurnOffExtended = WeAbilityField.new("auu1", 'string', 0, "TooltipTurnOffExtended")

--================
-- Channel fields
--================
static.ANcl_ArtDuration = WeAbilityField.new("Ncl4", 'unreal', 4, "ArtDuration")
static.ANcl_BaseOrderID = WeAbilityField.new("Ncl6", 'string', 6, "BaseOrderID")
static.ANcl_DisableOtherAbilities = WeAbilityField.new("Ncl5", 'bool', 5, "DisableOtherAbilities")
static.ANcl_FollowThroughTime = WeAbilityField.new("Ncl1", 'unreal', 1, "FollowThroughTime")

static.ANcl_TargetType_None = 0
static.ANcl_TargetType_Unit = 1
static.ANcl_TargetType_Point = 2
static.ANcl_TargetType_UnitOrPoint = 3
--- 0 - none; 1 - unit; 2 - point; 3 - point or unit
static.ANcl_TargetType = WeAbilityField.new("Ncl2", 'int', 2, "TargetType")

static.ANcl_Options_Visible = 1
static.ANcl_Options_AreaTarget = 2
static.ANcl_Options_Material = 4
static.ANcl_Options_Universal = 8
static.ANcl_Options_Group = 16
--- Summ of flags: visible - 1, area target - 2, material - 4, universal - 8, group - 16
static.ANcl_Options = WeAbilityField.new("Ncl3", 'int', 3, "Options")

return WeAbilityObject