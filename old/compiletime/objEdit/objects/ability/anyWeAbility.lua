---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type WeFile
local WeFile = require('compiletime.objEdit.weFile')
---@type WeObject
local WeObject = require('compiletime.objEdit.objects.weObject')

---@class AnyWeAbility : WeObject
local AnyWeAbility = {}
setmetatable(AnyWeAbility, {__index = WeObject})

---@param id string
---@param base_id string
---@return AnyWeAbility
function AnyWeAbility.new(id, base_id)
    local we_ability = WeObject.new(id, base_id, 'ability')
    setmetatable(we_ability, {__index = AnyWeAbility})
    WeFile.abilities:add(we_ability)
    return we_ability
end

---@return string
function AnyWeAbility:getName()
    return self.__name
end

---@param data string
function AnyWeAbility:setName(data)
    self.__name = data
    self:addField(WeField.new("anam", 'string', 0, 0, data))
end
---@param data string
function AnyWeAbility:setEditorSuffix(data) self:addField(WeField.new("ansf", 'string', 0, 0, data)) end
---@param data boolean
function AnyWeAbility:setHeroAbility(data) self:addField(WeField.new("aher", 'bool', 0, 0, data)) end
---@param data boolean
function AnyWeAbility:setItemAbility(data) self:addField(WeField.new("aite", 'bool', 0, 0, data)) end
---@param data string|'commoner'|'creeps'|'critters'|'demon'|'human'|'naga'|'nightelf'|'orc'|'other'|'undead'|'unknown'
function AnyWeAbility:setRace(data) self:addField(WeField.new("arac", 'string', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setButtonPositionNormalX(data) self:addField(WeField.new("abpx", 'int', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setButtonPositionNormalY(data) self:addField(WeField.new("abpy", 'int', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setButtonPositionTurnOffX(data) self:addField(WeField.new("aubx", 'int', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setButtonPositionTurnOffY(data) self:addField(WeField.new("auby", 'int', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setButtonPositionResearchX(data) self:addField(WeField.new("arpx", 'int', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setButtonPositionResearchY(data) self:addField(WeField.new("arpy", 'int', 0, 0, data)) end
---@param data string
function AnyWeAbility:setIconNormal(data) self:addField(WeField.new("aart", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setIconTurnOff(data) self:addField(WeField.new("auar", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setIconResearch(data) self:addField(WeField.new("arar", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setArtCaster(data) self:addField(WeField.new("acat", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setArtTarget(data) self:addField(WeField.new("atat", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setArtSpecial(data) self:addField(WeField.new("asat", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setArtEffect(data) self:addField(WeField.new("aeat", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setAreaEffect(data) self:addField(WeField.new("aaea", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setLightningEffects(data) self:addField(WeField.new("alig", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setMissileArt(data) self:addField(WeField.new("amat", 'string', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setMissileSpeed(data) self:addField(WeField.new("amsp", 'int', 0, 0, data)) end
---@param data number
function AnyWeAbility:setMissileArc(data) self:addField(WeField.new("amac", 'unreal', 0, 0, data)) end
---@param data boolean
function AnyWeAbility:setMissileHomingEnabled(data) self:addField(WeField.new("amho", 'bool', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setTargetAttachments(data) self:addField(WeField.new("atac", 'int', 0, 0, data)) end
---@param data string
function AnyWeAbility:setTargetAttachmentPoint(data) self:addField(WeField.new("ata0", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setTargetAttachmentPoint1(data) self:addField(WeField.new("ata1", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setTargetAttachmentPoint2(data) self:addField(WeField.new("ata2", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setTargetAttachmentPoint3(data) self:addField(WeField.new("ata3", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setTargetAttachmentPoint4(data) self:addField(WeField.new("ata4", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setTargetAttachmentPoint5(data) self:addField(WeField.new("ata5", 'string', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setCasterAttachments(data) self:addField(WeField.new("acac", 'int', 0, 0, data)) end
---@param data string
function AnyWeAbility:setCasterAttachmentPoint(data) self:addField(WeField.new("acap", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setCasterAttachmentPoint1(data) self:addField(WeField.new("aca1", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setSpecialAttachmentPoint(data) self:addField(WeField.new("aspt", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setAnimationNames(data) self:addField(WeField.new("aani", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setTooltipLearn(data) self:addField(WeField.new("aret", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setTooltipLearnExtended(data) self:addField(WeField.new("arut", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setHotkeyLearn(data) self:addField(WeField.new("arhk", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setHotkeyNormal(data) self:addField(WeField.new("ahky", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setHotkeyTurnOff(data) self:addField(WeField.new("auhk", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setRequirements(data) self:addField(WeField.new("areq", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setRequirementsLevels(data) self:addField(WeField.new("arqa", 'string', 0, 0, data)) end
---@param data boolean
function AnyWeAbility:setCheckDependencies(data) self:addField(WeField.new("achd", 'bool', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setPriorityForSpellSteal(data) self:addField(WeField.new("apri", 'int', 0, 0, data)) end
---@param data string
function AnyWeAbility:setOrderStringUseTurnOn(data) self:addField(WeField.new("aord", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setOrderStringTurnOff(data) self:addField(WeField.new("aoru", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setOrderStringActivate(data) self:addField(WeField.new("aoro", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setOrderStringDeactivate(data) self:addField(WeField.new("aorf", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setEffectSound(data) self:addField(WeField.new("aefs", 'string', 0, 0, data)) end
---@param data string
function AnyWeAbility:setEffectSoundLooping(data) self:addField(WeField.new("aefl", 'string', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setLevels(data) self:addField(WeField.new("alev", 'int', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setRequiredLevel(data) self:addField(WeField.new("arlv", 'int', 0, 0, data)) end
---@param data integer
function AnyWeAbility:setLevelSkipRequirement(data) self:addField(WeField.new("alsk", 'int', 0, 0, data)) end
---@param data string
function AnyWeAbility:setTooltipNormal(data, lvl) self:addField(WeField.new("atp1", 'string', lvl, 0, data)) end
---@param data string
function AnyWeAbility:setTooltipTurnOff(data, lvl) self:addField(WeField.new("aut1", 'string', lvl, 0, data)) end
---@param data string
function AnyWeAbility:setTooltipNormalExtended(data, lvl) self:addField(WeField.new("aub1", 'string', lvl, 0, data)) end
---@param data string
function AnyWeAbility:setTooltipTurnOffExtended(data, lvl) self:addField(WeField.new("auu1", 'string', lvl, 0, data)) end
---@param data string
function AnyWeAbility:setTargetsAllowed(data, lvl) self:addField(WeField.new("atar", 'string', lvl, 0, data)) end
---@param data number
---@param lvl integer
function AnyWeAbility:setCastingTime(data, lvl) self:addField(WeField.new("acas", 'unreal', lvl, 0, data)) end
---@param data number
---@param lvl integer
function AnyWeAbility:setDurationNormal(data, lvl) self:addField(WeField.new("adur", 'unreal', lvl, 0, data)) end
---@param data number
---@param lvl integer
function AnyWeAbility:setDurationHero(data, lvl) self:addField(WeField.new("ahdu", 'unreal', lvl, 0, data)) end
---@param data number
---@param lvl integer
function AnyWeAbility:setCooldown(data, lvl) self:addField(WeField.new("acdn", 'unreal', lvl, 0, data)) end
---@param data integer
function AnyWeAbility:setManaCost(data, lvl) self:addField(WeField.new("amcs", 'int', lvl, 0, data)) end
---@param data number
---@param lvl integer
function AnyWeAbility:setAreaOfEffect(data, lvl) self:addField(WeField.new("aare", 'unreal', lvl, 0, data)) end
---@param data number
---@param lvl integer
function AnyWeAbility:setCastRange(data, lvl) self:addField(WeField.new("aran", 'unreal', lvl, 0, data)) end
---@param data string
function AnyWeAbility:setBuffs(data, lvl) self:addField(WeField.new("abuf", 'string', lvl, 0, data)) end
---@param data string
function AnyWeAbility:setEffects(data, lvl) self:addField(WeField.new("aeff", 'string', lvl, 0, data)) end

return AnyWeAbility