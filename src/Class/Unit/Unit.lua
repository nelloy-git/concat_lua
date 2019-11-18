--=========
-- Include
--=========

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type UnitParametersContainerClass
local UnitParametersContainer = require('Class.Unit.UnitParametersContainer')

--=======
-- Class
--=======

---@type UnitClass
local Unit = newClass('Unit')

---@class UnitClass
local static = Unit.static
---@type table
local override = Unit.override
---@class Unit
local public = Unit.public
---@type table(Unit, table)
local private = {}

local db = DataBase.new('userdata', getClassName(Unit))

--=========
-- Methods
--=========

---@param player player
---@param id string | number
---@param x number
---@param y number
---@param face number
---@param instance_data table | nil
function static.new(player, id, x, y, face, instance_data)
    id = ID(id)

    local instance = instance_data or newInstanceData(Unit)
    local priv = {
        id = id,
        owner = player,
        wc3_unit = CreateUnit(player, id, x, y, face)
    }
    private[instance] = priv

    db:set(priv.wc3_unit, instance)

    private.initComponents(instance)

    return instance
end

public.parameters = 0

function public:free()
    local priv = private[self]
    RemoveUnit(priv.wc3_unit)
    private[self] = nil
    freeInstanceData(self)
end

---@return number
function public:getId()
    local priv = private[self]
    return priv.id
end

---@return player
function public:getOwner()
    local priv = private[self]
    return priv.owner
end

---@return unit
function public:getWc3Unit()
    local priv = private[self]
    return priv.wc3_unit
end

---@param self Unit
function private.initComponents(self)
    local priv = private[self]

    self.parameters = UnitParametersContainer.new(priv.wc3_unit)
end


return Unit