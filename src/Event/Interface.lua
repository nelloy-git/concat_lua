--=========
-- Include
--=========

---@type SelectionControllerClass
local Selection = require('Controller.Selection')
---@type InterfaceAPI
local InterfaceAPI = require('Interface.API')
local setInterfaceTarget = InterfaceAPI.setTarget
---@type UnitAPI
local UnitAPI = require('Unit.API')
local Unit = UnitAPI.Unit
local getUnitInstance = Unit.getInstance

--================
-- Show unit info
--================

local ShowUnitInfo = {}

---@param player player
---@param selected boolean
---@param unit_obj unit
function ShowUnitInfo.selectCallback(player, selected, unit_obj)
    local unit = getUnitInstance(unit_obj)
    setInterfaceTarget(unit)
end

if not IsCompiletime() then
    Selection.addAction(GetLocalPlayer(), true, ShowUnitInfo.selectCallback)
end