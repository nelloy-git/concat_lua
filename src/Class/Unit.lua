--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type UnitParametersContainerClass
local UnitParametersContainer = require('Class.Unit.UnitParametersContainer')
---@type UnitAbilitiesContainerClass
local UnitAbilitiesContainer = require('Class.Unit.UnitAbilitiesContainer')

--=======
-- Class
--=======

local Unit = Class.new('Unit')
---@class Unit
local public = Unit.public
---@class UnitClass
local static = Unit.static
local override = Unit.override
local private = {}

--========
-- Static
--========

---@param player player
---@param id string | number
---@param x number
---@param y number
---@param face number
---@param child_data table | nil
function static.new(player, id, x, y, face, child_data)
    local instance = child_data or Class.allocate(Unit, child_data)
    private.newData(instance, id, player, x, y, face)

    private.initComponents(instance)

    return instance
end

---@param wc3_unit unit
---@return Unit
function Unit.static.get(wc3_unit)
    return private.DB:get(wc3_unit)
end

--========
-- Public
--========

public.parameters = 'UnitParametersContainer'

function public:free()
    private.freeComponents(self)
    private.freeData(self)
    Class.freeInstanceData(self)
end

---@return number
function public:getId()
    return private[self].id
end

---@return player
function public:getOwner()
    return private[self].owner
end

---@return unit
function public:getWc3Unit()
    return private[self].wc3_unit
end

--=========
-- Private
--=========

private.DB = DataBase.new('userdata', Unit)

---@param self Unit
---@param id string | number
---@param player player
---@param x number
---@param y number
---@param face number
function private.newData(self, id, player, x, y, face)
    local num_id = ID(id)
    local priv = {
        id = num_id,
        owner = player,
        wc3_unit = CreateUnit(player, num_id, x, y, face)
    }
    private[self] = priv
    if not private.DB:set(priv.wc3_unit, self) then
        error('Can not add Unit to DataBase.')
    end
end

---@param self Unit
function private.freeData(self)
    local priv = private[self]
    private.DB:remove(priv.wc3_unit)
    RemoveUnit(priv.wc3_unit)

    private[self] = nil
end

---@param self Unit
function private.initComponents(self)
    local priv = private[self]

    ---@type UnitParametersContainer
    self.parameters = UnitParametersContainer.new(priv.wc3_unit)
end

---@param self Unit
function private.freeComponents(self)
    self.parameters:free()
end


return static