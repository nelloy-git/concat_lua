WeEveryAbility = {}

local WeField = require(CurrentLib..'.we_field')
local WeFile = require(CurrentLib..'.weFile')
local WeObject = require(CurrentLib..'.objects.we_object')
setmetatable(WeEveryAbility, {__index = WeObject})

function WeEveryAbility.new(id, base_id)
    local we_ability = WeObject.new(id, base_id, 'ability')
    setmetatable(we_ability, {__index = WeEveryAbility})
    WeFile.abilities:add(we_ability)
    return we_ability
end

function WeEveryAbility:setName(string_data)
    self:addField(WeField.new("anam", 'string', 0, 0, string_data))
end

function WeEveryAbility:setEditorSuffix(string_data)
    self:addField(WeField.new("ansf", 'string', 0, 0, string_data))
end

function WeEveryAbility:setHeroAbility(bool_data)
    self:addField(WeField.new("aher", 'bool', 0, 0, bool_data))
end

function WeEveryAbility:setItemAbility(bool_data)
    self:addField(WeField.new("aite", 'bool', 0, 0, bool_data))
end

--function WeEveryAbility:setRace(Race_data)
--    self:addField(WeField.new("arac", 'Race', 0, 0, rce.toObjectStringRace_data))
--end

function WeEveryAbility:setButtonPositionNormalX(int_data)
    self:addField(WeField.new("abpx", 'int', 0, 0, int_data))
end

function WeEveryAbility:setButtonPositionNormalY(int_data)
    self:addField(WeField.new("abpy", 'int', 0, 0, int_data))
end

function WeEveryAbility:setButtonPositionTurnOffX(int_data)
    self:addField(WeField.new("aubx", 'int', 0, 0, int_data))
end

function WeEveryAbility:setButtonPositionTurnOffY(int_data)
    self:addField(WeField.new("auby", 'int', 0, 0, int_data))
end

function WeEveryAbility:setButtonPositionResearchX(int_data)
    self:addField(WeField.new("arpx", 'int', 0, 0, int_data))
end

function WeEveryAbility:setButtonPositionResearchY(int_data)
    self:addField(WeField.new("arpy", 'int', 0, 0, int_data))
end

function WeEveryAbility:setIconNormal(string_data)
    self:addField(WeField.new("aart", 'string', 0, 0, string_data))
end

function WeEveryAbility:setIconTurnOff(string_data)
    self:addField(WeField.new("auar", 'string', 0, 0, string_data))
end

function WeEveryAbility:setIconResearch(string_data)
    self:addField(WeField.new("arar", 'string', 0, 0, string_data))
end

function WeEveryAbility:setArtCaster(string_data)
    self:addField(WeField.new("acat", 'string', 0, 0, string_data))
end

function WeEveryAbility:setArtTarget(string_data)
    self:addField(WeField.new("atat", 'string', 0, 0, string_data))
end

function WeEveryAbility:setArtSpecial(string_data)
    self:addField(WeField.new("asat", 'string', 0, 0, string_data))
end

function WeEveryAbility:setArtEffect(string_data)
    self:addField(WeField.new("aeat", 'string', 0, 0, string_data))
end

function WeEveryAbility:setAreaEffect(string_data)
    self:addField(WeField.new("aaea", 'string', 0, 0, string_data))
end

function WeEveryAbility:setLightningEffects(string_data)
    self:addField(WeField.new("alig", 'string', 0, 0, string_data))
end

function WeEveryAbility:setMissileArt(string_data)
    self:addField(WeField.new("amat", 'string', 0, 0, string_data))
end

function WeEveryAbility:setMissileSpeed(int_data)
    self:addField(WeField.new("amsp", 'int', 0, 0, int_data))
end

function WeEveryAbility:setMissileArc(real_data)
    self:addField(WeField.new("amac", 'real', 0, 0, real_data))
end

function WeEveryAbility:setMissileHomingEnabled(bool_data)
    self:addField(WeField.new("amho", 'bool', 0, 0, bool_data))
end

function WeEveryAbility:setTargetAttachments(int_data)
    self:addField(WeField.new("atac", 'int', 0, 0, int_data))
end

function WeEveryAbility:setTargetAttachmentPoint(string_data)
    self:addField(WeField.new("ata0", 'string', 0, 0, string_data))
end

function WeEveryAbility:setTargetAttachmentPoint1(string_data)
    self:addField(WeField.new("ata1", 'string', 0, 0, string_data))
end

function WeEveryAbility:setTargetAttachmentPoint2(string_data)
    self:addField(WeField.new("ata2", 'string', 0, 0, string_data))
end

function WeEveryAbility:setTargetAttachmentPoint3(string_data)
    self:addField(WeField.new("ata3", 'string', 0, 0, string_data))
end

function WeEveryAbility:setTargetAttachmentPoint4(string_data)
    self:addField(WeField.new("ata4", 'string', 0, 0, string_data))
end

function WeEveryAbility:setTargetAttachmentPoint5(string_data)
    self:addField(WeField.new("ata5", 'string', 0, 0, string_data))
end

function WeEveryAbility:setCasterAttachments(int_data)
    self:addField(WeField.new("acac", 'int', 0, 0, int_data))
end

function WeEveryAbility:setCasterAttachmentPoint(string_data)
    self:addField(WeField.new("acap", 'string', 0, 0, string_data))
end

function WeEveryAbility:setCasterAttachmentPoint1(string_data)
    self:addField(WeField.new("aca1", 'string', 0, 0, string_data))
end

function WeEveryAbility:setSpecialAttachmentPoint(string_data)
    self:addField(WeField.new("aspt", 'string', 0, 0, string_data))
end

function WeEveryAbility:setAnimationNames(string_data)
    self:addField(WeField.new("aani", 'string', 0, 0, string_data))
end

function WeEveryAbility:setTooltipNormal(string_data, lvl)
    self:addField(WeField.new("atp1", 'string', lvl, 0, string_data))
end

function WeEveryAbility:setTooltipTurnOff(string_data, lvl)
    self:addField(WeField.new("aut1", 'string', lvl, 0, string_data))
end

function WeEveryAbility:setTooltipNormalExtended(string_data, lvl)
    self:addField(WeField.new("aub1", 'string', lvl, 0, string_data))
end

function WeEveryAbility:setTooltipTurnOffExtended(string_data, lvl)
    self:addField(WeField.new("auu1", 'string', lvl, 0, string_data))
end

function WeEveryAbility:setTooltipLearn(string_data)
    self:addField(WeField.new("aret", 'string', 0, 0, string_data))
end

function WeEveryAbility:setTooltipLearnExtended(string_data)
    self:addField(WeField.new("arut", 'string', 0, 0, string_data))
end

function WeEveryAbility:setHotkeyLearn(string_data)
    self:addField(WeField.new("arhk", 'string', 0, 0, string_data))
end

function WeEveryAbility:setHotkeyNormal(string_data)
    self:addField(WeField.new("ahky", 'string', 0, 0, string_data))
end

function WeEveryAbility:setHotkeyTurnOff(string_data)
    self:addField(WeField.new("auhk", 'string', 0, 0, string_data))
end

function WeEveryAbility:setRequirements(string_data)
    self:addField(WeField.new("areq", 'string', 0, 0, string_data))
end

function WeEveryAbility:setRequirementsLevels(string_data)
    self:addField(WeField.new("arqa", 'string', 0, 0, string_data))
end

function WeEveryAbility:setCheckDependencies(bool_data)
    self:addField(WeField.new("achd", 'bool', 0, 0, bool_data))
end

function WeEveryAbility:setPriorityforSpellSteal(int_data)
    self:addField(WeField.new("apri", 'int', 0, 0, int_data))
end

function WeEveryAbility:setOrderStringUseTurnOn(string_data)
    self:addField(WeField.new("aord", 'string', 0, 0, string_data))
end

function WeEveryAbility:setOrderStringTurnOff(string_data)
    self:addField(WeField.new("aoru", 'string', 0, 0, string_data))
end

function WeEveryAbility:setOrderStringActivate(string_data)
    self:addField(WeField.new("aoro", 'string', 0, 0, string_data))
end

function WeEveryAbility:setOrderStringDeactivate(string_data)
    self:addField(WeField.new("aorf", 'string', 0, 0, string_data))
end

function WeEveryAbility:setEffectSound(string_data)
    self:addField(WeField.new("aefs", 'string', 0, 0, string_data))
end

function WeEveryAbility:setEffectSoundLooping(string_data)
    self:addField(WeField.new("aefl", 'string', 0, 0, string_data))
end

function WeEveryAbility:setLevels(int_data)
    self:addField(WeField.new("ale 'int',v", 0, 0, int_data))
end

function WeEveryAbility:setRequiredLevel(int_data)
    self:addField(WeField.new("arlv", 'int', 0, 0, int_data))
end

function WeEveryAbility:setLevelSkipRequirement(int_data)
    self:addField(WeField.new("alsk", 'int', 0, 0, int_data))
end

function WeEveryAbility:setTargetsAllowed(string_data, lvl)
    self:addField(WeField.new("atar", 'string', lvl, 0, string_data))
end

function WeEveryAbility:setCastingTime(real_data, lvl)
    self:addField(WeField.new("acas", 'real', lvl, 0, real_data))
end

function WeEveryAbility:setDurationNormal(real_data, lvl)
    self:addField(WeField.new("adur", 'real', lvl, 0, real_data))
end

function WeEveryAbility:setDurationHero(real_data, lvl)
    self:addField(WeField.new("ahdu", 'real', lvl, 0, real_data))
end

function WeEveryAbility:setCooldown(real_data, lvl)
    self:addField(WeField.new("acdn", 'real', lvl, 0, real_data))
end

function WeEveryAbility:setManaCost(int_data, lvl)
    self:addField(WeField.new("amcs", 'int', lvl, 0, int_data))
end

function WeEveryAbility:setAreaofEffect(real_data, lvl)
    self:addField(WeField.new("aare", 'real', lvl, 0, real_data))
end

function WeEveryAbility:setCastRange(real_data, lvl)
    self:addField(WeField.new("aran", 'real', lvl, 0, real_data))
end

function WeEveryAbility:setBuffs(string_data, lvl)
    self:addField(WeField.new("abuf", 'string', lvl, 0, string_data))
end

function WeEveryAbility:setEffects(string_data, lvl)
    self:addField(WeField.new("aeff", 'string', lvl, 0, string_data))
end

return WeEveryAbility