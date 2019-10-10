--=========
-- Include
--=========

---@type DataBase
local DataBase = require('utils.DataBase')
---@type Settings
local Settings = require('utils.Settings')

--=======
-- Class
--=======

---@class Unit
local Unit = newClass('Unit')
local Unit_meta = newMeta(Unit)
Unit.__db = DataBase.new('userdata', 'Unit')
Unit.__unit_creation_funcs = {}
Unit.__unit_removal_funcs = {}

---@param player player
---@param id string | integer
---@param x number
---@param y number
---@param face number
---@param is_dead boolean|nil
---@return Unit
function Unit.new(player, id, x, y, face, is_dead)
    id = ID(id)
    local unit_obj
    if is_dead then
        unit_obj = CreateCorpse(player, id, x, y, face)
    else
        unit_obj = CreateUnit(player, id, x, y, face)
    end
    ---@type Unit
    local unit = {
        __id = id,
        __unit_obj = unit_obj,
        __owning_player = player
    }
    setmetatable(unit, Unit_meta)
    Unit.__db:add(unit.__unit_obj, unit)

    --- Run functions added by submodules.
    for i = 1, #Unit.__unit_creation_funcs do
        if Settings.Unit.DebugCreationFunctions then
            runFuncInDebug(Unit.__unit_creation_funcs[i], unit)
        else
            Unit.__unit_creation_funcs[i](unit)
        end
    end

    return unit
end

function Unit:destroy()
    --- Run functions added by submodules.
    for i = 0, #Unit.__unit_removal_funcs do
        if Settings.Unit.DebugRemovalFunctions then
            runFuncInDebug(Unit.__unit_removal_funcs[i], self)
        else
            Unit.__unit_removal_funcs[i](self)
        end
    end

    Unit.__db:rm(self.__unit_obj)
    RemoveUnit(self.__unit_obj)
    self.__unit_obj = nil
end

---@param unit unit
function Unit.get(unit)
    Unit.__db:get(unit)
end

---@param func fun(unit:Unit):boolean
function Unit.addCreationFunction(func)
    table.insert(Unit.__unit_creation_funcs, #Unit.__unit_creation_funcs + 1, func)
end

---@param func fun(unit:Unit):boolean
function Unit.addRemovalFunction(func)
    table.insert(Unit.__unit_removal_funcs, #Unit.__unit_removal_funcs + 1, func)
end

---@return unit
function Unit:getObj()
    return self.__unit_obj
end

---@return number
function Unit:getId()
    return self.__id
end

---@return player
function Unit:getOwner()
    return GetOwningPlayer(self.__unit_obj)
end

return Unit