---@type Frame
local Frame = require('baseClasses.Frame.FrameData')
---@type ParameterFrame
local Parameter = require('baseClasses.Frame.Inventory.Parameter.Parameter')

local Info = require('baseClasses.Frame.Inventory.Parameter.Info')

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
    frame.__field[UNIT_PARAMETER_ATTACK_DAMAGE] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_ATTACK_SPEED] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_ARMOR] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_PHYSICAL_DAMAGE_REDUCTION] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_SPELL_DAMAGE] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_CASTING_TIME_REDUCTION] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_RESISTANCE] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_MAGICAL_DAMAGE_REDUCTION] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_DODGE_CHANCE] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_CRIT_CHANCE] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_CRIT_DAMAGE] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_COOLDOWN_REDUCTION] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_HEALTH] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_REGENERATION] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_MANA] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_RECOVERY] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_STRENGTH] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_AGILITY] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_INTELLIGENCE] = Parameter.new(frame)
    frame.__field[UNIT_PARAMETER_MOVE_SPEED] = Parameter.new(frame)

    Debug(frame.__field[UNIT_PARAMETER_ATTACK_DAMAGE])
    for param, _ in pairs(Info.Icons) do
        frame.__field[param]:set(Info.Icons[param], "0", Info.Title[param], Info.Text[param], 0.07)
    end

    frame:update()

    return frame
end

function ParametersAreaFrame:update()
    local w = self:getWidth()
    local h = self:getHeight()

    self:applyMainFramePos()

    local count = Info.count
    local field_width = (w - 2 * offset_x) / 2
    local field_height = 2 * (h - 2 * offset_x) / Info.count
    
    --============
    -- Left side
    --============
    self.__field[UNIT_PARAMETER_ATTACK_DAMAGE]:setPosition(offset_x, offset_y + 0 * field_height)
    self.__field[UNIT_PARAMETER_ATTACK_SPEED]:setPosition(offset_x, offset_y + 1 * field_height)
    self.__field[UNIT_PARAMETER_ARMOR]:setPosition(offset_x, offset_y + 2 * field_height)
    self.__field[UNIT_PARAMETER_PHYSICAL_DAMAGE_REDUCTION]:setPosition(offset_x, offset_y + 3 * field_height)
    self.__field[UNIT_PARAMETER_CRIT_CHANCE]:setPosition(offset_x, offset_y + 4 * field_height)
    self.__field[UNIT_PARAMETER_DODGE_CHANCE]:setPosition(offset_x, offset_y + 5 * field_height)
    self.__field[UNIT_PARAMETER_HEALTH]:setPosition(offset_x, offset_y + 6 * field_height)
    self.__field[UNIT_PARAMETER_REGENERATION]:setPosition(offset_x, offset_y + 7 * field_height)
    self.__field[UNIT_PARAMETER_STRENGTH]:setPosition(offset_x, offset_y + 8 * field_height)
    self.__field[UNIT_PARAMETER_AGILITY]:setPosition(offset_x, offset_y + 9 * field_height)

    --============
    -- Right side
    --============
    self.__field[UNIT_PARAMETER_SPELL_DAMAGE]:setPosition(offset_x + field_width, offset_y + 0 * field_height)
    self.__field[UNIT_PARAMETER_CASTING_TIME_REDUCTION]:setPosition(offset_x + field_width, offset_y + 1 * field_height)
    self.__field[UNIT_PARAMETER_RESISTANCE]:setPosition(offset_x + field_width, offset_y + 2 * field_height)
    self.__field[UNIT_PARAMETER_MAGICAL_DAMAGE_REDUCTION]:setPosition(offset_x + field_width, offset_y + 3 * field_height)
    self.__field[UNIT_PARAMETER_CRIT_DAMAGE]:setPosition(offset_x + field_width, offset_y + 4 * field_height)
    self.__field[UNIT_PARAMETER_COOLDOWN_REDUCTION]:setPosition(offset_x + field_width, offset_y + 5 * field_height)
    self.__field[UNIT_PARAMETER_MANA]:setPosition(offset_x + field_width, offset_y + 6 * field_height)
    self.__field[UNIT_PARAMETER_RECOVERY]:setPosition(offset_x + field_width, offset_y + 7 * field_height)
    self.__field[UNIT_PARAMETER_INTELLIGENCE]:setPosition(offset_x + field_width, offset_y + 8 * field_height)
    self.__field[UNIT_PARAMETER_MOVE_SPEED]:setPosition(offset_x + field_width, offset_y + 9 * field_height)

    for param, _ in pairs(Info.Icons) do
        self.__field[param]:setSize(field_width, field_height)
    end
end


--============
-- Left side
--============

---@param value number
function ParametersAreaFrame:setAttack(value)
    self.__field[UNIT_PARAMETER_ATTACK_DAMAGE]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setAttacksCooldown(value)
    self.__field[UNIT_PARAMETER_ATTACK_SPEED]:setValue(string.format("%0.3f sec", value))
end

---@param value number
function ParametersAreaFrame:setArmor(value)
    self.__field[UNIT_PARAMETER_ARMOR]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setPhysicalDamageReduction(value)
    self.__field[UNIT_PARAMETER_PHYSICAL_DAMAGE_REDUCTION]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setCritChance(value)
    self.__field[UNIT_PARAMETER_CRIT_CHANCE]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setDodgeChance(value)
    self.__field[UNIT_PARAMETER_DODGE_CHANCE]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setHealth(value)
    self.__field[UNIT_PARAMETER_HEALTH]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setRegeneration(value)
    self.__field[UNIT_PARAMETER_REGENERATION]:setValue(string.format("%0.2f", value))
end

---@param value number
function ParametersAreaFrame:setStrength(value)
    self.__field[UNIT_PARAMETER_STRENGTH]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setAgility(value)
    self.__field[UNIT_PARAMETER_AGILITY]:setValue(tostring(math.floor(value)))
end

--============
-- Right side
--============

---@param value number
function ParametersAreaFrame:setSpellDamage(value)
    self.__field[UNIT_PARAMETER_SPELL_DAMAGE]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setCastingTimeReduction(value)
    self.__field[UNIT_PARAMETER_CASTING_TIME_REDUCTION]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setResistance(value)
    self.__field[UNIT_PARAMETER_RESISTANCE]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setMagicalDamageReduction(value)
    self.__field[UNIT_PARAMETER_MAGICAL_DAMAGE_REDUCTION]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setCritDamage(value)
    self.__field[UNIT_PARAMETER_CRIT_DAMAGE]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setCooldownReduction(value)
    self.__field[UNIT_PARAMETER_COOLDOWN_REDUCTION]:setValue(string.format("%0.2f%%", 100 * value))
end

---@param value number
function ParametersAreaFrame:setMana(value)
    self.__field[UNIT_PARAMETER_MANA]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setRecovery(value)
    self.__field[UNIT_PARAMETER_RECOVERY]:setValue(string.format("%0.2f", value))
end

---@param value number
function ParametersAreaFrame:setIntelligence(value)
    self.__field[UNIT_PARAMETER_INTELLIGENCE]:setValue(tostring(math.floor(value)))
end

---@param value number
function ParametersAreaFrame:setMoveSpeed(value)
    self.__field[UNIT_PARAMETER_MOVE_SPEED]:setValue(tostring(math.floor(value)))
end


return ParametersAreaFrame