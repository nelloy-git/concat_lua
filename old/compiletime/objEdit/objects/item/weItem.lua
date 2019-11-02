---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type WeFile
local WeFile = require('compiletime.objEdit.weFile')
---@type WeObject
local WeObject = require('compiletime.objEdit.objects.weObject')

---@class WeItem : WeObject
local AnyWeItem = {}
setmetatable(AnyWeItem, {__index = WeObject})

---@param id string
---@param base_id string
---@return WeItem
function AnyWeItem.new(id, base_id)
    local we_item = WeObject.new(id, base_id, 'item')
    setmetatable(we_item, {__index = AnyWeItem})
    WeFile.items:add(we_item)
    return we_item
end

---@return string
function AnyWeItem:getName()
    return self.__name
end
---@param data string
function AnyWeItem:setName(data)
    self.__name = data
    self:addField(WeField.new("unam", 'string', nil, nil, data))
end
---@param data string
function AnyWeItem:setTooltipExtended(data) self:addField(WeField.new("utub", "string", nil, nil, data)) end
---@param data string
function AnyWeItem:setTooltipBasic(data) self:addField(WeField.new("utip", "string", nil, nil, data)) end
---@param data string
function AnyWeItem:setRequirementsLevels(data) self:addField(WeField.new("urqa", "string", nil, nil, data)) end
---@param data string
function AnyWeItem:setRequirements(data) self:addField(WeField.new("ureq", "string", nil, nil, data)) end
---@param data string
function AnyWeItem:setHotkey(data) self:addField(WeField.new("uhot", "string", nil, nil, data)) end
---@param data string
function AnyWeItem:setDescription(data) self:addField(WeField.new("ides", "string", nil, nil, data)) end
---@param data integer
function AnyWeItem:setButtonPositionY(data) self:addField(WeField.new("ubpy", "int", nil, nil, data)) end
---@param data integer
function AnyWeItem:setButtonPositionX(data) self:addField(WeField.new("ubpx", "int", nil, nil, data)) end
---@param data string
function AnyWeItem:setAbilities(data) self:addField(WeField.new("iabi", "string", nil, nil, data)) end
---@param data string|'"normal"'|'"small"'|'"medium"'|'"large"'|'"fort"'|'"hero"'|'"divine"'|'"none"'
function AnyWeItem:setArmorType(data) self:addField(WeField.new("iarm", "ArmorType", nil, nil, data)) end
---@param data string
function AnyWeItem:setClassification(data) self:addField(WeField.new("icla", "string", nil, nil, data)) end
---@param data integer
function AnyWeItem:setTintingColor3Blue(data) self:addField(WeField.new("iclb", "int", nil, nil, data)) end
---@param data integer
function AnyWeItem:setTintingColor2Green(data) self:addField(WeField.new("iclg", "int", nil, nil, data)) end
---@param data integer
function AnyWeItem:setTintingColor1Red(data) self:addField(WeField.new("iclr", "int", nil, nil, data)) end
---@param data string
function AnyWeItem:setCooldownGroup(data) self:addField(WeField.new("icid", "string", nil, nil, data)) end
---@param data boolean
function AnyWeItem:setDroppedWhenCarrierDies(data) self:addField(WeField.new("idrp", "bool", nil, nil, data)) end
---@param data boolean
function AnyWeItem:setCanBeDropped(data) self:addField(WeField.new("idro", "bool", nil, nil, data)) end
---@param data string
function AnyWeItem:setModelUsed(data) self:addField(WeField.new("ifil", "string", nil, nil, data)) end
---@param data integer
function AnyWeItem:setGoldCost(data) self:addField(WeField.new("igol", "int", nil, nil, data)) end
---@param data integer
function AnyWeItem:setHitPoints(data) self:addField(WeField.new("ihtp", "int", nil, nil, data)) end
---@param data boolean
function AnyWeItem:setIgnoreCooldown(data) self:addField(WeField.new("iicd", "bool", nil, nil, data)) end
---@param data integer
function AnyWeItem:setLevel(data) self:addField(WeField.new("ilev", "int", nil, nil, data)) end
---@param data integer
function AnyWeItem:setLumberCost(data) self:addField(WeField.new("ilum", "int", nil, nil, data)) end
---@param data boolean
function AnyWeItem:setValidTargetForTransformation(data) self:addField(WeField.new("imor", "bool", nil, nil, data)) end
---@param data integer
function AnyWeItem:setLevelUnclassified(data) self:addField(WeField.new("ilvo", "int", nil, nil, data)) end
---@param data boolean
function AnyWeItem:setPerishable(data) self:addField(WeField.new("iper", "bool", nil, nil, data)) end
---@param data boolean
function AnyWeItem:setIncludeAsRandomChoice(data) self:addField(WeField.new("iprn", "bool", nil, nil, data)) end
---@param data boolean
function AnyWeItem:setUseAutomaticallyWhenAcquired(data) self:addField(WeField.new("ipow", "bool", nil, nil, data)) end
---@param data integer
function AnyWeItem:setPriority(data) self:addField(WeField.new("ipri", "int", nil, nil, data)) end
---@param data number
function AnyWeItem:setScalingValue(data) self:addField(WeField.new("isca", "real", nil, nil, data)) end
---@param data boolean
function AnyWeItem:setCanBeSoldByMerchants(data) self:addField(WeField.new("isel", "bool", nil, nil, data)) end
---@param data boolean
function AnyWeItem:setCanBeSoldToMerchants(data) self:addField(WeField.new("ipaw", "bool", nil, nil, data)) end
---@param data integer
function AnyWeItem:setStockMaximum(data) self:addField(WeField.new("isto", "int", nil, nil, data)) end
---@param data integer
function AnyWeItem:setStockReplenishInterval(data) self:addField(WeField.new("istr", "int", nil, nil, data)) end
---@param data integer
function AnyWeItem:setStockStartDelay(data) self:addField(WeField.new("isst", "int", nil, nil, data)) end
---@param data boolean
function AnyWeItem:setActivelyUsed(data) self:addField(WeField.new("iusa", "bool", nil, nil, data)) end
---@param data integer
function AnyWeItem:setNumberofCharges(data) self:addField(WeField.new("iuse", "int", nil, nil, data)) end
---@param data string
function AnyWeItem:setInterfaceIcon(data) self:addField(WeField.new("iico", "string", nil, nil, data)) end

return AnyWeItem