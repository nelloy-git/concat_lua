---@type WeField
local WeField = require('compiletime.objEdit.we_field')
---@type WeFile
local WeFile = require('compiletime.objEdit.weFile')
---@type WeObject
local WeObject = require('compiletime.objEdit.objects.we_object')

---@class WeBuff
local WeBuff = {}
setmetatable(WeBuff, {__index = WeObject})

---@param id string
---@param base_id string
---@return WeBuff
function WeBuff.new(id, base_id)
    local we_buff = WeObject.new(id, base_id, 'buff')
    setmetatable(we_buff, {__index = WeBuff})
    WeFile.buffs:add(we_buff)
    return we_buff
end

---@param data string
function WeBuff:setName(data) self:addField(WeField.new("fnam", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setEditorSuffix(data) self:addField(WeField.new("fnsf", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setRace(data) self:addField(WeField.new("frac", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setIconNormal(data) self:addField(WeField.new("fart", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setCaster(data) self:addField(WeField.new("fcat", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setArtTarget(data) self:addField(WeField.new("ftat", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setArtSpecial(data) self:addField(WeField.new("fsat", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setEffect(data) self:addField(WeField.new("feat", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setAreaEffect(data) self:addField(WeField.new("faea", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setMissileArt(data) self:addField(WeField.new("fmat", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setMissileSpeed(data) self:addField(WeField.new("fmsp", 'int', nil, nil, data)) end
---@param data number
function WeBuff:setMissileArc(data) self:addField(WeField.new("fmac", 'real', nil, nil, data)) end
---@param data boolean
function WeBuff:setMissileHomingEnabled(data) self:addField(WeField.new("fmho", 'bool', nil, nil, data)) end
---@param data string
function WeBuff:setTargetAttachments(data) self:addField(WeField.new("ftac", 'int', nil, nil, data)) end
---@param data string
function WeBuff:setTargetAttachmentPoint0(data) self:addField(WeField.new("fta0", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setTargetAttachmentPoint1(data) self:addField(WeField.new("fta1", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setTargetAttachmentPoint2(data) self:addField(WeField.new("fta2", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setTargetAttachmentPoint3(data) self:addField(WeField.new("fta3", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setTargetAttachmentPoint4(data) self:addField(WeField.new("fta4", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setTargetAttachmentPoint5(data) self:addField(WeField.new("fta5", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setCasterAttachments(data) self:addField(WeField.new("fcac", 'int', nil, nil, data)) end
---@param data string
function WeBuff:setSpecialAttachmentPoint(data) self:addField(WeField.new("fspt", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setTooltipNormal(data) self:addField(WeField.new("ftip", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setTooltipNormalExtended(data) self:addField(WeField.new("fube", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setEffectSound(data) self:addField(WeField.new("fefs", 'string', nil, nil, data)) end
---@param data string
function WeBuff:setEffectSoundLooping(data) self:addField(WeField.new("fefl", 'string', nil, nil, data)) end

return WeBuff