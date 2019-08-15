---@class SpellInstance
local SpellInstance = {}

---@param ability Ability
---@param caster Unit
---@param target SpellTarget
---@param x number
---@param y number
---@param full_time number
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
end

---@return Ability
function SpellInstance:getAbility()
    return self._ability
end

---@return Unit
function SpellInstance:getCaster()
    return self._caster
end

---@return Unit|Item|userdata|nil
function SpellInstance:getTarget()
    return self._target
end

---@return number
function SpellInstance:getTime()
    return self._time
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