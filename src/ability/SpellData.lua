---@class SpellData
local SpellData = {}
local SpellData_meta = {
    __index = SpellData
}

---@param ability Ability
---@param caster wc3_Unit
---@param target wc3_Unit|wc3_Item|wc3_Destructable|nil
---@param x number
---@param y number
---@return SpellData
function SpellData.new(ability, caster, target, x, y)
    ---@type SpellData
    local data = {
        __ability = ability,
        __caster = caster,
        __target = target,
        __x = x,
        __y = y,
        __cur_time = 0,
        __cast_time = 0
    }
    setmetatable(data, SpellData_meta)
    return data
end

---@return Ability, wc3_Unit, SpellTarget, number, number, number, number
function SpellData:getAll()
    return self.__ability, self.__caster, self.__target, self.__x, self.__y, self.__cur_time, self.__full_time
end

---@param delta number
function SpellData:addTime(delta)
    self.__cur_time = self.__cur_time + delta
end

---@return boolean
function SpellData:isFinished()
    return (self.__cur_time >= self.__cast_time)
end

---@param time number
function SpellData:setCastTime(time)
    self.__cast_time = time
end

---@return number
function SpellData:getTime()
    return self.__cur_time
end

---@return number
function SpellData:getCastTime()
    return self.__cast_time
end

---@return Ability
function SpellData:getAbility()
    return self.__ability
end

---@return wc3_Unit
function SpellData:getCaster()
    return self.__caster
end

---@return wc3_Unit|wc3_Item|wc3_Destructable|nil
function SpellData:getTarget()
    return self.__target
end

---@return number
function SpellData:getX()
    return self.__x
end

---@return number
function SpellData:getY()
    return self.__y
end

return SpellData