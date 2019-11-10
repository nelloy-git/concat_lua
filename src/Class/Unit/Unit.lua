--=========
-- Include
--=========

---@type DataBase
local DataBase = require('Class.DataBase')

--=======
-- Class
--=======

---@type UnitClass
local Unit = newClass('Unit', Timer)

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

    return instance
end

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


return Unit