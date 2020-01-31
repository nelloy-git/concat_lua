--=========
-- Include
--=========

local Class = require('utils.Class.Class')
local Log = require('utils.Log')

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type UnitParametersContainerClass
local UnitParametersContainer = require('Class.Unit.Parameters.Container')

--=======
-- Class
--=======

local Unit = Class.new('Unit')
---@class Unit
local public = Unit.public
---@class UnitClass
local static = Unit.static
---@type UnitClass
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
---@param child_instance Unit | nil
---@return Unit
function static.new(player, id, x, y, face, child_instance)
    local instance = child_instance or Class.allocate(Unit)
    private.newData(instance, id, player, x, y, face)
    private.initComponents(instance)

    return instance
end

---@param wc3_unit unit
---@return Unit
function static.get(wc3_unit)
    return private.DB:get(wc3_unit)
end

--========
-- Public
--========

public.parameters = 'UnitParametersContainer'

---@return number
function public:getId()
    return private.data[self].id
end

---@return player
function public:getOwner()
    return private.data[self].owner
end

---@return unit
function public:getWc3Unit()
    return private.data[self].wc3_unit
end

function public:free()
    private.freeComponents(self)
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

private.DB = DataBase.new('userdata', Unit)
private.data = setmetatable({}, {__mode = 'kv'})

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

    private.data[self] = setmetatable(priv, private.metatable)
    private.DB:set(priv.wc3_unit, self)
end

private.metatable = {
    __gc = function(self) RemoveUnit(private.data[self].wc3_unit) end
}

---@param self Unit
function private.freeData(self)
    local priv = private.data[self]
    private.DB:remove(priv.wc3_unit)
    RemoveUnit(priv.wc3_unit)

    private.data[self] = nil
end

---@param self Unit
function private.initComponents(self)
    local priv = private.data[self]

    ---@type UnitParametersContainer
    self.parameters = UnitParametersContainer.new(priv.wc3_unit)
end

---@param self Unit
function private.freeComponents(self)
    self.parameters:free()
end


return static