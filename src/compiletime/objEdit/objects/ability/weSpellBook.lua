---@type WeField
local WeField = require('compiletime.objEdit.weField')
---@type AnyWeAbility
local AnyWeAbility = require('compiletime.objEdit.objects.ability.anyWeAbility')

---@class SpellBookWeAbility : AnyWeAbility
local SpellBook = {}
setmetatable(SpellBook, {__index = AnyWeAbility})

---@param id string
---@return RunedBracersWeAbility
function SpellBook.new(id)
    local we_ability = AnyWeAbility.new(id, 'Aspb')
    setmetatable(we_ability, {__index = SpellBook})
    return we_ability
end

---@param data integer
---@param lvl integer
function SpellBook:setMaximumSpells(data, lvl)
    self:addField(WeField.new("spb4", "int", lvl, 4, data))
end

---@param data boolean
---@param lvl integer
function SpellBook:setSharedSpellCooldown(data, lvl)
    self:addField(WeField.new("spb2", "bool", lvl, 2, data))
end

---@param data string
---@param lvl integer
function SpellBook:setSpellList(data, lvl)
    self:addField(WeField.new("spb1", "string", lvl, 1, data))
end

---@param data integer
---@param lvl integer
function SpellBook:setMinimumSpells(data, lvl)
    self:addField(WeField.new("spb3", "int", lvl, 3, data))
end

---@param data string
---@param lvl integer
function SpellBook:setBaseOrderID(data, lvl)
    self:addField(WeField.new("spb5", "string", lvl, 5, data))
end

return SpellBook