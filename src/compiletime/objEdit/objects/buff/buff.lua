local WeBuff = {}

local WeField = require(CurrentLib..'.we_field')
local WeFile = require(CurrentLib..'.weFile')
local WeObject = require(CurrentLib..'.objects.we_object')
setmetatable(WeBuff, {__index = WeObject})

function WeBuff.new(id, base_id)
    local we_buff = WeObject.new(id, base_id, 'buff')
    setmetatable(we_buff, {__index = WeBuff})
    WeFile.buffs:add(we_buff)
    return we_buff
end

function WeBuff:setName(string_data)
    self:addField(WeField.new("fnam", 'string', nil, nil, string_data))
end

function WeBuff:setEditorSuffix(string_data)
    self:addField(WeField.new("fnsf", 'string', nil, nil, string_data))
end

function WeBuff:setRace(string_data)
    self:addField(WeField.new("frac", 'string', nil, nil, string_data))
end

function WeBuff:setIconNormal(string_data)
    self:addField(WeField.new("fart", 'string', nil, nil, string_data))
end

function WeBuff:setCaster(string_data)
    self:addField(WeField.new("fcat", 'string', nil, nil, string_data))
end

function WeBuff:setArtTarget(string_data)
    self:addField(WeField.new("ftat", 'string', nil, nil, string_data))
end

function WeBuff:setArtSpecial(string_data)
    self:addField(WeField.new("fsat", 'string', nil, nil, string_data))
end

function WeBuff:setEffect(string_data)
    self:addField(WeField.new("feat", 'string', nil, nil, string_data))
end

function WeBuff:setAreaEffect(string_data)
    self:addField(WeField.new("faea", 'string', nil, nil, string_data))
end

function WeBuff:setMissileArt(string_data)
    self:addField(WeField.new("fmat", 'string', nil, nil, string_data))
end

function WeBuff:setMissileSpeed(int_data)
    self:addField(WeField.new("fmsp", 'int', nil, nil, int_data))
end

function WeBuff:setMissileArc(real_data)
    self:addField(WeField.new("fmac", 'real', nil, nil, real_data))
end

function WeBuff:setMissileHomingEnabled(bool_data)
    self:addField(WeField.new("fmho", 'bool', nil, nil, bool_data))
end

function WeBuff:setTargetAttachments(int_data)
    self:addField(WeField.new("ftac", 'int', nil, nil, int_data))
end

function WeBuff:setTargetAttachmentPoint0(string_data)
    self:addField(WeField.new("fta0", 'string', nil, nil, string_data))
end

function WeBuff:setTargetAttachmentPoint1(string_data)
    self:addField(WeField.new("fta1", 'string', nil, nil, string_data))
end

function WeBuff:setTargetAttachmentPoint2(string_data)
    self:addField(WeField.new("fta2", 'string', nil, nil, string_data))
end

function WeBuff:setTargetAttachmentPoint3(string_data)
    self:addField(WeField.new("fta3", 'string', nil, nil, string_data))
end

function WeBuff:setTargetAttachmentPoint4(string_data)
    self:addField(WeField.new("fta4", 'string', nil, nil, string_data))
end

function WeBuff:setTargetAttachmentPoint5(string_data)
    self:addField(WeField.new("fta5", 'string', nil, nil, string_data))
end

function WeBuff:setCasterAttachments(int_data)
    self:addField(WeField.new("fcac", 'int', nil, nil, int_data))
end

function WeBuff:setSpecialAttachmentPoint(string_data)
    self:addField(WeField.new("fspt", 'string', nil, nil, string_data))
end

function WeBuff:setTooltipNormal(string_data)
    self:addField(WeField.new("ftip", 'string', nil, nil, string_data))
end

function WeBuff:setTooltipNormalExtended(string_data)
    self:addField(WeField.new("fube", 'string', nil, nil, string_data))
end

function WeBuff:setEffectSound(string_data)
    self:addField(WeField.new("fefs", 'string', nil, nil, string_data))
end

function WeBuff:setEffectSoundLooping(string_data)
    self:addField(WeField.new("fefl", 'string', nil, nil, string_data))
end

return WeBuff