---@type Frame
local Frame = require('baseClasses.Frame.FrameData')
---@type ParameterFrame
local Parameter = require('baseClasses.Frame.Inventory.Parameter.Parameter')
---@type UnitParameterType
local UnitParameterType = require('baseClasses.Unit.Parameters.Type')

---@class ParametersAreaFrame
local ParametersAreaFrame = {
    __type = 'ParametersAreaFrameClass'
}
setmetatable(ParametersAreaFrame, {__index = Frame})

local ParametersAreaFrame_meta = {
    __type = 'ParametersAreaFrame',
    __index = ParametersAreaFrame,
}

local initialized = false
function ParametersAreaFrame.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end
    
    initialized = true
end

local offset_x = 0.002
local offset_y = 0.002

function ParametersAreaFrame.new(parent)
    local frame = Frame.new("ParametersAreaBackground", parent)
    setmetatable(frame, ParametersAreaFrame_meta)

    frame.__field = {}
    frame.__field[UnitParameterType.P_DMG] = Parameter.new(frame)
    frame.__field[UnitParameterType.ATKS_PER_SEC] = Parameter.new(frame)
    frame.__field[UnitParameterType.ARMOR] = Parameter.new(frame)
    frame.__field[UnitParameterType.P_DMG_REDUC] = Parameter.new(frame)
    frame.__field[UnitParameterType.M_DMG] = Parameter.new(frame)
    frame.__field[UnitParameterType.CAST_TIME_REDUC] = Parameter.new(frame)
    frame.__field[UnitParameterType.RESIST] = Parameter.new(frame)
    frame.__field[UnitParameterType.M_DMG_REDUC] = Parameter.new(frame)
    frame.__field[UnitParameterType.DODGE_CH] = Parameter.new(frame)
    frame.__field[UnitParameterType.CRIT_CH] = Parameter.new(frame)
    frame.__field[UnitParameterType.CRIT_DMG] = Parameter.new(frame)
    frame.__field[UnitParameterType.CD_REDUC] = Parameter.new(frame)
    frame.__field[UnitParameterType.HP] = Parameter.new(frame)
    frame.__field[UnitParameterType.REGEN] = Parameter.new(frame)
    frame.__field[UnitParameterType.MP] = Parameter.new(frame)
    frame.__field[UnitParameterType.RECOV] = Parameter.new(frame)
    frame.__field[UnitParameterType.STR] = Parameter.new(frame)
    frame.__field[UnitParameterType.AGI] = Parameter.new(frame)
    frame.__field[UnitParameterType.INT] = Parameter.new(frame)
    frame.__field[UnitParameterType.MS] = Parameter.new(frame)

    for param, _ in pairs(frame.__field) do
        frame.__field[param]:set(param:getIcon(), "0", param:getName(), param:getDescription(), 0.07)
    end

    frame:update()

    return frame
end

function ParametersAreaFrame:update()
    local w = self:getWidth()
    local h = self:getHeight()

    self:applyMainFramePos()

    local rows = 10
    local field_width = (w - 2 * offset_x) / 2
    local field_height = (h - 2 * offset_x) / rows
    
    --============
    -- Left side
    --============
    self.__field[UnitParameterType.P_DMG]:setPosition(offset_x, offset_y + 0 * field_height)
    self.__field[UnitParameterType.ATKS_PER_SEC]:setPosition(offset_x, offset_y + 1 * field_height)
    self.__field[UnitParameterType.ARMOR]:setPosition(offset_x, offset_y + 2 * field_height)
    self.__field[UnitParameterType.P_DMG_REDUC]:setPosition(offset_x, offset_y + 3 * field_height)
    self.__field[UnitParameterType.CRIT_CH]:setPosition(offset_x, offset_y + 4 * field_height)
    self.__field[UnitParameterType.DODGE_CH]:setPosition(offset_x, offset_y + 5 * field_height)
    self.__field[UnitParameterType.HP]:setPosition(offset_x, offset_y + 6 * field_height)
    self.__field[UnitParameterType.REGEN]:setPosition(offset_x, offset_y + 7 * field_height)
    self.__field[UnitParameterType.STR]:setPosition(offset_x, offset_y + 8 * field_height)
    self.__field[UnitParameterType.AGI]:setPosition(offset_x, offset_y + 9 * field_height)

    --============
    -- Right side
    --============
    self.__field[UnitParameterType.M_DMG]:setPosition(offset_x + field_width, offset_y + 0 * field_height)
    self.__field[UnitParameterType.CAST_TIME_REDUC]:setPosition(offset_x + field_width, offset_y + 1 * field_height)
    self.__field[UnitParameterType.RESIST]:setPosition(offset_x + field_width, offset_y + 2 * field_height)
    self.__field[UnitParameterType.M_DMG_REDUC]:setPosition(offset_x + field_width, offset_y + 3 * field_height)
    self.__field[UnitParameterType.CRIT_DMG]:setPosition(offset_x + field_width, offset_y + 4 * field_height)
    self.__field[UnitParameterType.CD_REDUC]:setPosition(offset_x + field_width, offset_y + 5 * field_height)
    self.__field[UnitParameterType.MP]:setPosition(offset_x + field_width, offset_y + 6 * field_height)
    self.__field[UnitParameterType.RECOV]:setPosition(offset_x + field_width, offset_y + 7 * field_height)
    self.__field[UnitParameterType.INT]:setPosition(offset_x + field_width, offset_y + 8 * field_height)
    self.__field[UnitParameterType.MS]:setPosition(offset_x + field_width, offset_y + 9 * field_height)

    --===========
    -- Set size.
    --===========
    self.__field[UnitParameterType.P_DMG]:setSize(field_width, field_height)
    self.__field[UnitParameterType.ATKS_PER_SEC]:setSize(field_width, field_height)
    self.__field[UnitParameterType.ARMOR]:setSize(field_width, field_height)
    self.__field[UnitParameterType.P_DMG_REDUC]:setSize(field_width, field_height)
    self.__field[UnitParameterType.M_DMG]:setSize(field_width, field_height)
    self.__field[UnitParameterType.CAST_TIME_REDUC]:setSize(field_width, field_height)
    self.__field[UnitParameterType.RESIST]:setSize(field_width, field_height)
    self.__field[UnitParameterType.M_DMG_REDUC]:setSize(field_width, field_height)
    self.__field[UnitParameterType.DODGE_CH]:setSize(field_width, field_height)
    self.__field[UnitParameterType.CRIT_CH]:setSize(field_width, field_height)
    self.__field[UnitParameterType.CRIT_DMG]:setSize(field_width, field_height)
    self.__field[UnitParameterType.CD_REDUC]:setSize(field_width, field_height)
    self.__field[UnitParameterType.HP]:setSize(field_width, field_height)
    self.__field[UnitParameterType.REGEN]:setSize(field_width, field_height)
    self.__field[UnitParameterType.MP]:setSize(field_width, field_height)
    self.__field[UnitParameterType.RECOV]:setSize(field_width, field_height)
    self.__field[UnitParameterType.STR]:setSize(field_width, field_height)
    self.__field[UnitParameterType.AGI]:setSize(field_width, field_height)
    self.__field[UnitParameterType.INT]:setSize(field_width, field_height)
    self.__field[UnitParameterType.MS]:setSize(field_width, field_height)
end

---@param unit Unit
function ParametersAreaFrame:setUnit(unit)
    self.__unit = unit
    self:setAttack(unit:getPhysicalDamage())
    self:setAttacksPerSec(unit:getAttacksPerSec())
    self:setArmor(unit:getArmor())
    self:setPhysicalDamageReduction(unit:getPhysicalDamageReduction())
    self:setCritChance(unit:getCriticalStrikeChance())
    self:setDodgeChance(unit:getDodgeChance())
    self:setHealth(unit:getHealth())
    self:setRegeneration(unit:getHealth())
    self:setStrength(unit:getStrength())
    self:setAgility(unit:getAgility())
    self:setSpellDamage(unit:getMagicalDamage())
    self:setCastingTimeReduction(unit:getCastingTimeReduction())
    self:setResistance(unit:getRecovery())
    self:setMagicalDamageReduction(unit:getMagicalDamageReductionPercent())
    self:setCritDamage(unit:getCriticalStrikeDamage())
    self:setCooldownReduction(unit:getCooldownReduction())
    self:setMana(unit:getMana())
    self:setRecovery(unit:getRecovery())
    self:setIntelligence(unit:getIntelligence())
    self:setMoveSpeed(unit:getMoveSpeed())
end

---@return Unit
function ParametersAreaFrame:getUnit()
    return self.__unit
end

--============
-- Left side
--============

---@param value number
function ParametersAreaFrame:setAttack(value)
    self.__field[UnitParameterType.P_DMG]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setAttacksPerSec(value)
    self.__field[UnitParameterType.ATKS_PER_SEC]:setValue(string.format("%0.3f sec", value))
end

---@param value number
function ParametersAreaFrame:setArmor(value)
    self.__field[UnitParameterType.ARMOR]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setPhysicalDamageReduction(value)
    self.__field[UnitParameterType.P_DMG_REDUC]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setCritChance(value)
    self.__field[UnitParameterType.CRIT_CH]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setDodgeChance(value)
    self.__field[UnitParameterType.DODGE_CH]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setHealth(value)
    self.__field[UnitParameterType.HP]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setRegeneration(value)
    self.__field[UnitParameterType.REGEN]:setValue(string.format("%0.2f", value))
end

---@param value number
function ParametersAreaFrame:setStrength(value)
    self.__field[UnitParameterType.STR]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setAgility(value)
    self.__field[UnitParameterType.AGI]:setValue(tostring(math.floor(value)))
end

--============
-- Right side
--============

---@param value number
function ParametersAreaFrame:setSpellDamage(value)
    self.__field[UnitParameterType.M_DMG]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setCastingTimeReduction(value)
    self.__field[UnitParameterType.CAST_TIME_REDUC]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setResistance(value)
    self.__field[UnitParameterType.RESIST]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setMagicalDamageReduction(value)
    self.__field[UnitParameterType.M_DMG_REDUC]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setCritDamage(value)
    self.__field[UnitParameterType.CRIT_DMG]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setCooldownReduction(value)
    self.__field[UnitParameterType.CD_REDUC]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setMana(value)
    self.__field[UnitParameterType.MP]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setRecovery(value)
    self.__field[UnitParameterType.RECOV]:setValue(string.format("%0.2f", value))
end

---@param value number
function ParametersAreaFrame:setIntelligence(value)
    self.__field[UnitParameterType.INT]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setMoveSpeed(value)
    self.__field[UnitParameterType.MS]:setValue(tostring(math.floor(value)))
end


return ParametersAreaFrame