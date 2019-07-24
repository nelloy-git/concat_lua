-- Function return current dir path in 'require' function format
local function getModulePrefix()
    local path = debug.getinfo(1, "S").source:sub(3)
    local separator = package.config:sub(1,1)
    local dir = path:sub(1, #path - path:reverse():find(separator))
    return dir:gsub(separator, '.'):sub(2)
end

local ObjEdit = {
    Unit = nil,
    ChannelAbility = nil,
    AuraDummy = nil,
}

function ObjEdit.init(src_path, dst_path)
    -- Save to restore later
    local prev_val = CurrentLib
    CurrentLib = getModulePrefix()

    local WeFile = require(CurrentLib..'.weFile')
    WeFile.init(src_path, dst_path)

    ObjEdit.Unit =  require(CurrentLib..'.objects.unit.unit')
    ObjEdit.ChannelAbility = require(CurrentLib..'.objects.ability.channel')
    ObjEdit.AuraDummy = require(CurrentLib..'.presets.auraDummy')
end

function ObjEdit.close()
    local WeFile = require(CurrentLib..'.weFile')
    WeFile.close()
end


-- Restore global var
CurrentLib = prev_val
return ObjEdit