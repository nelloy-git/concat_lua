local Class = require('Utils.Class.API')

---@type Unit
local Unit = require('Unit.Unit')

local static = Unit
local public = Class.getPublic(Unit)
local private = {}

--========
-- Static
--========



--========
-- Public
--========

function public:enableMove(flag)
    local priv = private.getData(self)
    if flag then
        if priv.disable_move_refs == 0 then
            Logger.error(self, 'move is already enabled.', 2)
        end

        priv.disable_move_refs = priv.disable_move_refs - 1

        if priv.disable_move_refs == 0 then
            UnitAddAbility(self:getObj(), ID('Amov'))
            SetUnitPathing(self:getObj(), true)
        end

        return
    end

    priv.disable_move_refs = priv.disable_move_refs + 1

    if priv.disable_move_refs == 1 then
        UnitRemoveAbility(self:getObj(), ID('Amov'))
        SetUnitPathing(self:getObj(), false)
    end
end

function public:enableAttack(flag)
    local priv = private.getData(self)
    if flag then
        if priv.disable_attack_refs == 0 then
            Logger.error(self, 'attack is already enabled.', 2)
        end

        priv.disable_attack_refs = priv.disable_attack_refs - 1

        if priv.disable_attack_refs == 0 then
            UnitRemoveAbility(self:getObj(), ID('Abun'))
        end

        return
    end

    priv.disable_attack_refs = priv.disable_attack_refs + 1

    if priv.disable_attack_refs == 1 then
        UnitAddAbility(self:getObj(), ID('Abun'))
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self Unit
function private.getData(self)
    if not private.data[self] then
        private.data[self] = {
            disable_move_refs = 0,
            disable_attack_refs = 0
        }
    end
    return private.data[self]
end