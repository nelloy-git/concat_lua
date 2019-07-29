---Warcraft object editing API
---@class ObjEdit
---@field Ability table @Abilities API
---@field Preset table @Presets API
---@field Unit table @Units API
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
    local WeFile = require('compiletime.objEdit.weFile')
    WeFile.init(src_path, dst_path)

    local utils = require(CurrentLib..'.utils')

    --Abilities
    ObjEdit.Ability = {}
    ObjEdit.Ability.RunedBracers = require('compiletime.objEdit.objects.ability.runedBracers')

    -- Units
    ObjEdit.Unit = {}
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