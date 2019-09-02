---@type DataBase
local DataBase = require('utils.DataBase')

---@class SpellData
local SpellData = {
    __type = 'SpellDataClass',
    __db = DataBase.new('userdata', 'SpellData')
}
local SpellData_meta = {
    __type = 'SpellData',
    __index = SpellData,
    __gc = SpellData.destroy
}

---@param ability Ability
---@param caster unit
---@param target unit|item|destructable|nil
---@param target_pos Vec2
---@return SpellData
function SpellData.new(ability, caster, target, target_pos)
    ---@type SpellData
    local data = {
        __ability = ability,
        __caster = caster,
        __target = target,
        __target_pos = target_pos,
        __cur_time = 0,
        __cast_time = 0
    }
    setmetatable(data, SpellData_meta)
    SpellData.__db:add(caster, data)

    data.__cast_time = ability:getCastingTime(data)

    return data
end

function SpellData:destroy()
    if SpellData.__db:get(self.__caster) == self then
        SpellData.__db:remove(self.__caster)
    end
end

---@param caster unit
---@return SpellData
function SpellData.get(caster)
    return SpellData.__db:get(caster)
end

---@param delta number
function SpellData:addTime(delta)
    self.__cur_time = self.__cur_time + delta
end

---@return boolean
function SpellData:isFinished()
    return (self.__cur_time >= self.__cast_time)
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

---@return unit
function SpellData:getCaster()
    return self.__caster
end

---@return unit|item|destructable|nil
function SpellData:getTarget()
    return self.__target
end

---@return Vec2
function SpellData:getTargetPos()
    return self.__target_pos
end

return SpellData