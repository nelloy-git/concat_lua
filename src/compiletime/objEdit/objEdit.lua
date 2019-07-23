-- Get and save lib path
local prev_val = CurrentLib
local path = debug.getinfo(1, "S").source:sub(3)
local separator = package.config:sub(1,1)
local dir = path:sub(1, #path - path:reverse():find(separator))
CurrentLib = dir:gsub(separator, '.'):sub(2)

local WeFile = require(CurrentLib..'.weFile')
WeFile.init()

ObjEdit = {
    Unit =  require(CurrentLib..'.objects.unit.unit'),
    ChannelAbility = require(CurrentLib..'.objects.ability.channel'),
    AuraDummy = require(CurrentLib..'.presets.auraDummy')
}

function ObjEdit.close()
    WeFile.close()
end


-- Restore global var
CurrentLib = prev_val
return nil