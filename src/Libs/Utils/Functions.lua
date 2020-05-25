---@class UtilsFunctions
local UtilsFunctions = {}

local Class = require(Lib.Class)
local classType = Class.type

---@type LoggerClass
local Logger = require(__UtilsLib..'Logger')
local Log = Logger.getDefault()

---@param var any
---@param type any
---@param var_name string
function UtilsFunctions.checkType(var, type, var_name, level)
    if not classType(var, type) then
        Log:err('variable '..(var_name or '')..' is not of type '..tostring(type), level or 3)
    end
end

return UtilsFunctions