--=========
-- Include
--=========

local Class = require(Lib.Class)


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
---@param child WeBuff | nil
---@return WeBuff
function override.new(id, base_id, name, child)
    local instance = child or Class.allocate(WeBuff)
    instance = WeObject.new(id, base_id, name, instance)

    if not private.we_file then
        private.we_file = WeObjectFile.new(private.file_dst)
    end
    private.we_file:addObject(instance)

    return instance
end

static.Field = {}
static.Field.Name = WeField.new("fnam", 'string', 'Name')
static.Field.EditorSuffix = WeField.new("fnsf", 'string', 'EditorSuffix')
static.Field.Race = WeField.new("frac", 'string', 'Race')
static.Field.IconNormal = WeField.new("fart", 'string', 'IconNormal')
static.Field.Caster = WeField.new("fcat", 'string', 'Caster')
static.Field.ArtTarget = WeField.new("ftat", 'string', 'ArtTarget')
static.Field.ArtSpecial = WeField.new("fsat", 'string', 'ArtSpecial')
static.Field.Effect = WeField.new("feat", 'string', 'Effect')
static.Field.AreaEffect = WeField.new("faea", 'string', 'AreaEffect')
static.Field.MissileArt = WeField.new("fmat", 'string', 'MissileArt')
static.Field.MissileSpeed = WeField.new("fmsp", 'int', 'MissileSpeed')
static.Field.MissileArc = WeField.new("fmac", 'real', 'MissileArc')
static.Field.MissileHomingEnabled = WeField.new("fmho", 'bool', 'MissileHomingEnabled')
static.Field.TargetAttachments = WeField.new("ftac", 'int', 'TargetAttachments')
static.Field.TargetAttachmentPoint0 = WeField.new("fta0", 'string', 'TargetAttachmentPoint0')
static.Field.TargetAttachmentPoint1 = WeField.new("fta1", 'string', 'TargetAttachmentPoint1')
static.Field.TargetAttachmentPoint2 = WeField.new("fta2", 'string', 'TargetAttachmentPoint2')
static.Field.TargetAttachmentPoint3 = WeField.new("fta3", 'string', 'TargetAttachmentPoint3')
static.Field.TargetAttachmentPoint4 = WeField.new("fta4", 'string', 'TargetAttachmentPoint4')
static.Field.TargetAttachmentPoint5 = WeField.new("fta5", 'string', 'TargetAttachmentPoint5')
static.Field.CasterAttachments = WeField.new("fcac", 'int', 'CasterAttachments')
static.Field.SpecialAttachmentPoint = WeField.new("fspt", 'string', 'SpecialAttachmentPoint')
static.Field.TooltipNormal = WeField.new("ftip", 'string', 'TooltipNormal')
static.Field.TooltipNormalExtended = WeField.new("fube", 'string', 'TooltipNormalExtended')
static.Field.EffectSound = WeField.new("fefs", 'string', 'EffectSound')
static.Field.EffectSoundLooping = WeField.new("fefl", 'string', 'EffectSoundLooping')

--=========
-- Private
--=========

private.path_sep = package.config:sub(1,1)
private.file_src = GetSrcDir()..private.path_sep..'war3map.w3h'
private.file_dst = GetDstDir()..private.path_sep..'war3map.w3h'

return WeBuff.static