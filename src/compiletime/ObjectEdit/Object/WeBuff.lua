--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type WeObjectClass
local WeObject = require('compiletime.ObjectEdit.WeObject')
---@type WeFieldClass
local WeField = require('compiletime.ObjectEdit.WeField')
---@type WeFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeFile')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeBuff = Class.new('WeBuff', WeObject)
---@class WeBuff
local public = WeBuff.public
---@class WeBuffClass
local static = WeBuff.static
---@type WeBuffClass
local override = WeBuff.override
local private = {}

--========
-- Static
--========

---@param id string | number
---@param base_id string | number
---@param name string
---@param child_instance WeBuff | nil
---@return WeBuff
function override.new(id, base_id, name, child_instance)
    local instance = child_instance or Class.allocate(WeBuff)
    instance = WeObject.new(id, base_id, name, instance)

    if not private.we_file then
        private.we_file = WeObjectFile.new(private.file_src, private.file_dst)
    end
    private.we_file:addObject(instance)

    return instance
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
        local msg = fmt('wrong data type. Got %s. Need %s.',
                         type(data), data_type)
        Log(Log.Warn, field:getName(), msg)
    end
    return res
end

static.Field = {}
static.Field.Name = WeField.new("fnam", 'string', 'Name', private.checkType)
static.Field.EditorSuffix = WeField.new("fnsf", 'string', 'EditorSuffix', private.checkType)
static.Field.Race = WeField.new("frac", 'string', 'Race', private.checkType)
static.Field.IconNormal = WeField.new("fart", 'string', 'IconNormal', private.checkType)
static.Field.Caster = WeField.new("fcat", 'string', 'Caster', private.checkType)
static.Field.ArtTarget = WeField.new("ftat", 'string', 'ArtTarget', private.checkType)
static.Field.ArtSpecial = WeField.new("fsat", 'string', 'ArtSpecial', private.checkType)
static.Field.Effect = WeField.new("feat", 'string', 'Effect', private.checkType)
static.Field.AreaEffect = WeField.new("faea", 'string', 'AreaEffect', private.checkType)
static.Field.MissileArt = WeField.new("fmat", 'string', 'MissileArt', private.checkType)
static.Field.MissileSpeed = WeField.new("fmsp", 'int', 'MissileSpeed', private.checkType)
static.Field.MissileArc = WeField.new("fmac", 'real', 'MissileArc', private.checkType)
static.Field.MissileHomingEnabled = WeField.new("fmho", 'bool', 'MissileHomingEnabled', private.checkType)
static.Field.TargetAttachments = WeField.new("ftac", 'int', 'TargetAttachments', private.checkType)
static.Field.TargetAttachmentPoint0 = WeField.new("fta0", 'string', 'TargetAttachmentPoint0', private.checkType)
static.Field.TargetAttachmentPoint1 = WeField.new("fta1", 'string', 'TargetAttachmentPoint1', private.checkType)
static.Field.TargetAttachmentPoint2 = WeField.new("fta2", 'string', 'TargetAttachmentPoint2', private.checkType)
static.Field.TargetAttachmentPoint3 = WeField.new("fta3", 'string', 'TargetAttachmentPoint3', private.checkType)
static.Field.TargetAttachmentPoint4 = WeField.new("fta4", 'string', 'TargetAttachmentPoint4', private.checkType)
static.Field.TargetAttachmentPoint5 = WeField.new("fta5", 'string', 'TargetAttachmentPoint5', private.checkType)
static.Field.CasterAttachments = WeField.new("fcac", 'int', 'CasterAttachments', private.checkType)
static.Field.SpecialAttachmentPoint = WeField.new("fspt", 'string', 'SpecialAttachmentPoint', private.checkType)
static.Field.TooltipNormal = WeField.new("ftip", 'string', 'TooltipNormal', private.checkType)
static.Field.TooltipNormalExtended = WeField.new("fube", 'string', 'TooltipNormalExtended', private.checkType)
static.Field.EffectSound = WeField.new("fefs", 'string', 'EffectSound', private.checkType)
static.Field.EffectSoundLooping = WeField.new("fefl", 'string', 'EffectSoundLooping', private.checkType)

--=========
-- Private
--=========

private.path_sep = package.config:sub(1,1)
private.file_src = GetSrcDir()..private.path_sep..'war3map.w3h'
private.file_dst = GetDstDir()..private.path_sep..'war3map.w3h'

return WeBuff.static