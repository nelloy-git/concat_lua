-- Function return current dir path in 'require' function format
local function getModulePrefix()
    local path = debug.getinfo(1, "S").source:sub(3)
    local separator = package.config:sub(1,1)
    local dir = path:sub(1, #path - path:reverse():find(separator))
    return dir:gsub(separator, '.'):sub(2)
end

local ObjEdit = {
    utils = nil,

    Unit = nil,
    Ability = {},
    AuraDummy = nil,
}

function ObjEdit.init(src_path, dst_path)
    -- Save to restore later
    local prev_val = CurrentLib
    CurrentLib = getModulePrefix()

    local WeFile = require(CurrentLib..'.weFile')
    WeFile.init(src_path, dst_path)

    ObjEdit.utils = require(CurrentLib..'.utils')

    -- Units
    ObjEdit.Unit =  require(CurrentLib..'.objects.unit.unit')

    -- Ailities
    ObjEdit.Ability.BladeMasterCriticalStrike = require(CurrentLib..'.objects.ability.bladeMasterCriticalStrike')
    ObjEdit.Ability.Channel = require(CurrentLib..'.objects.ability.channel')
    ObjEdit.Ability.RunedBracers = require(CurrentLib..'.objects.ability.runedBracers')

    ObjEdit.AuraDummy = require(CurrentLib..'.presets.auraDummy')

    CurrentLib = prev_val
end

function ObjEdit.close()
    local prev_val = CurrentLib
    CurrentLib = getModulePrefix()

    local WeFile = require(CurrentLib..'.weFile')
    WeFile.close()
    
    CurrentLib = prev_val
end


-- Restore global var
return ObjEdit