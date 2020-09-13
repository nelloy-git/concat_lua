--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
local classType = Class.type or error('')
local isClass = Class.isClass or error('')
local getClass = Class.getClass or error('')
---@type UtilsSettings
local Settings = require(lib_path..'Settings') or error('')
local Log = Settings.default_logger or error('')

--========
-- Module
--========

---@class UtilsFunctions
local UtilsFunctions = {}

---@param var any
---@param need_type any
---@return boolean
function UtilsFunctions.checkType(var, need_type)
    local real_type = type(var)
    if real_type == 'userdata' then
        local wc3_type_string = tostring(var)
        local pos = wc3_type_string:find(':')
        local wc3_type = wc3_type_string:sub(1, pos - 1)
        if wc3_type ~= need_type then
            return false
        end
        return true
    end

    return classType(var, need_type)
end

---@param var any
---@param need_type any
---@param var_name string
---@param level number | nil
function UtilsFunctions.isTypeErr(var, need_type, var_name, level)
    if not Settings.debug or UtilsFunctions.checkType(var, need_type) then
        return
    end

    -- Print error
    local real_type = type(var)
    if real_type == 'userdata' then
        local wc3_type_string = tostring(var)
        local pos = wc3_type_string:find(':')
        local wc3_type = wc3_type_string:sub(1, pos - 1)
        Log:err('variable \''..(var_name or '')..'\'('..wc3_type..') is not of type '..tostring(need_type), level and level + 1 or 3)
    elseif real_type == 'table' and isClass(var) then
        local class_str = tostring(getClass(var))
        Log:err('variable \''..(var_name or '')..'\'('..class_str..') is not of type '..tostring(need_type), level and level + 1 or 3)
    else
        Log:err('variable \''..(var_name or '')..'\'('..real_type..') is not of type '..tostring(need_type), level and level + 1 or 3)
    end
end

---@param id string
---@return number
function UtilsFunctions.id2int(id)
    UtilsFunctions.isTypeErr(id, 'string', 'id')
    local res, _ = string.unpack(">I4", id)
    return res
end

local uniq_num = 0
---@return number
function UtilsFunctions.getUniqueNumber()
    uniq_num = uniq_num + 1
    return uniq_num
end

--- Function for iterating table
--- for k, v in pairsByKeys(t, f) do ... end
function UtilsFunctions.pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then return nil
      else return a[i], t[a[i]]
      end
    end
    return iter
end

return UtilsFunctions