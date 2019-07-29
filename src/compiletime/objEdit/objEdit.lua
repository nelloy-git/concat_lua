---Warcraft object editing API
---@class ObjEdit
local ObjEdit = {}

---Function return current dir path in 'require' function format
---@return
local function getModulePrefix()
    local path = debug.getinfo(1, "S").source:sub(3)
    local separator = package.config:sub(1,1)
    local dir = path:sub(1, #path - path:reverse():find(separator))
    return dir:gsub(separator, '.'):sub(2)
end

---Function initialize object editing
---@param src_path string
---@param dst_path string
function ObjEdit.init(src_path, dst_path)
    --Save to restore later
    local prev_val = CurrentLib
    CurrentLib = getModulePrefix()

    --Initialize object files
    ---@type WeFile
    local WeFile = require('compiletime.objEdit.weFile')
    WeFile.init(src_path, dst_path)

    ObjEdit.Utils = require(CurrentLib..'.utils')

    --Abilities
    ObjEdit.Ability = {}
    ObjEdit.Ability.BladeMasterCriticalStrike = require(CurrentLib..'.objects.ability.bladeMasterCriticalStrike')
    ObjEdit.Ability.RunedBracers = require(CurrentLib..'.objects.ability.runedBracers')

    -- Units
    ObjEdit.Unit = {}
    ---@type WeUnit
    ObjEdit.Unit.Unit = require('compiletime.objEdit.objects.unit.unit')

    CurrentLib = prev_val
end

---Function closes object files
function ObjEdit.close()
    local prev_val = CurrentLib
    CurrentLib = getModulePrefix()

    local WeFile = require('compiletime.objEdit.weFile')
    WeFile.close()
    
    CurrentLib = prev_val
end


-- Restore global var
return ObjEdit