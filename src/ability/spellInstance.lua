---@class SpellInstance
local SpellInstance = {}
local SpellInstance_meta = {
    __index = SpellInstance
}

---@param ability Ability
---@param caster Unit
---@param target SpellTarget
---@param x number
---@param y number
---@param full_time number
---@return SpellInstance
function SpellInstance.new(ability, caster, target, x, y, full_time)
    local data = {
        _ability = ability,
        _caster = caster,
        _target = target,
        _x = x,
        _y = y,
        _time = 0,
        _full_time = full_time
    }
    setmetatable(data, SpellInstance_meta)
    return data
end

---@return Ability, Unit, SpellTarget, number, number, number, number
function SpellInstance:getAll()
    return self._ability, self._caster, self._target, self._x, self._y, self._time, self._full_time
end

---@param delta number
---@return nil
function SpellInstance:addTime(delta)
    self._time = self._time + delta
end

---@return number
function SpellInstance:getTime()
    return self._time
end

---@return number
function SpellInstance:getFullTime()
    return self._full_time
end

---@return Ability
function SpellInstance:getAbility()
    return self._ability
end

---@return Unit
function SpellInstance:getCaster()
    return self._caster
end

---@return SpellTarget
function SpellInstance:getTarget()
    return self._target
end

---@return number
function SpellInstance:getX()
    return self._x
end

---@return number
function SpellInstance:getY()
    return self._y
end

return SpellInstance