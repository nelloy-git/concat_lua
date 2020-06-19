---@class UtilsFunctions
local UtilsFunctions = {}


local lib_modname = Lib.current().modname
local Class = Lib.current().depencies.Class
local classType = Class.type

---@type LoggerClass
local Logger = require(lib_modname..'.Logger')
local Log = Logger.getDefault()

local debug = true

---@param var any
---@param need_type any
---@param var_name string
---@param level number | nil
function UtilsFunctions.checkType(var, need_type, var_name, level)
    if debug and not classType(var, need_type) then
        Log:err('variable '..(var_name or '')..' is not of type '..tostring(need_type), level or 3)
    end
end

return UtilsFunctions