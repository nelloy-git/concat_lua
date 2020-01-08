--=========
-- Include
--=========

local Class = require('utils.Class')

local Log = require('utils.Log')
---@type WeFieldClass
local WeField = require('compiletime.ObjectEdit.WeField')
---@type WeObjectClass
local WeObject = require('compiletime.ObjectEdit.WeObject')
---@type WeObjectFileClass
local WeObjectFile = require('compiletime.ObjectEdit.WeFile')
---@type WeUtils
local WeUtils = require('compiletime.Utils')

--=======
-- Class
--=======

local WeBuff = Class.newClass('WeBuff', WeObject)

---@class WeBuff
local public = WeBuff.public
---@class WeBuffClass
local static = WeBuff.static
---@type table
local override = WeBuff.override
---@type table(WeBuff, table)
local private = {}

private.path_sep = package.config:sub(1,1)
private.file_src = lua_wc3.GetSrcDir()..private.path_sep..'war3map.w3h'
private.file_dst = lua_wc3.GetDstDir()..private.path_sep..'war3map.w3h'

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return WeBuff
function override.new(id, base_id, name, instance_data)
    local instance = instance_data or Class.newInstanceData(WeBuff)
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
        local msg = fmt('wrong data type. Got %s. Need %s.',
                         type(data), data_type)
        Log(Log.Warn, field:getName(), msg)
    end
    return res
end

--=============
-- Buff fields
--=============
static.Name = WeField.new("fnam", 'string', 'Name', private.checkType)
static.EditorSuffix = WeField.new("fnsf", 'string', 'EditorSuffix', private.checkType)
static.Race = WeField.new("frac", 'string', 'Race', private.checkType)
static.IconNormal = WeField.new("fart", 'string', 'IconNormal', private.checkType)
static.Caster = WeField.new("fcat", 'string', 'Caster', private.checkType)
static.ArtTarget = WeField.new("ftat", 'string', 'ArtTarget', private.checkType)
static.ArtSpecial = WeField.new("fsat", 'string', 'ArtSpecial', private.checkType)
static.Effect = WeField.new("feat", 'string', 'Effect', private.checkType)
static.AreaEffect = WeField.new("faea", 'string', 'AreaEffect', private.checkType)
static.MissileArt = WeField.new("fmat", 'string', 'MissileArt', private.checkType)
static.MissileSpeed = WeField.new("fmsp", 'int', 'MissileSpeed', private.checkType)
static.MissileArc = WeField.new("fmac", 'real', 'MissileArc', private.checkType)
static.MissileHomingEnabled = WeField.new("fmho", 'bool', 'MissileHomingEnabled', private.checkType)
static.TargetAttachments = WeField.new("ftac", 'int', 'TargetAttachments', private.checkType)
static.TargetAttachmentPoint0 = WeField.new("fta0", 'string', 'TargetAttachmentPoint0', private.checkType)
static.TargetAttachmentPoint1 = WeField.new("fta1", 'string', 'TargetAttachmentPoint1', private.checkType)
static.TargetAttachmentPoint2 = WeField.new("fta2", 'string', 'TargetAttachmentPoint2', private.checkType)
static.TargetAttachmentPoint3 = WeField.new("fta3", 'string', 'TargetAttachmentPoint3', private.checkType)
static.TargetAttachmentPoint4 = WeField.new("fta4", 'string', 'TargetAttachmentPoint4', private.checkType)
static.TargetAttachmentPoint5 = WeField.new("fta5", 'string', 'TargetAttachmentPoint5', private.checkType)
static.CasterAttachments = WeField.new("fcac", 'int', 'CasterAttachments', private.checkType)
static.SpecialAttachmentPoint = WeField.new("fspt", 'string', 'SpecialAttachmentPoint', private.checkType)
static.TooltipNormal = WeField.new("ftip", 'string', 'TooltipNormal', private.checkType)
static.TooltipNormalExtended = WeField.new("fube", 'string', 'TooltipNormalExtended', private.checkType)
static.EffectSound = WeField.new("fefs", 'string', 'EffectSound', private.checkType)
static.EffectSoundLooping = WeField.new("fefl", 'string', 'EffectSoundLooping', private.checkType)

return WeBuff