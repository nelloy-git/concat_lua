-- Get and save lib path
local prev_val = CurrentLib
local path = debug.getinfo(1, "S").source:sub(3)
local separator = package.config:sub(1,1)
local dir = path:sub(1, #path - path:reverse():find(separator))
CurrentLib = dir:gsub(separator, '.'):sub(2)

local WeFile = require(CurrentLib..'.weFile')
WeFile.init()
local WeUnit = require(CurrentLib..'.objects.unit.unit')
local WeChannelAbil = require(CurrentLib..'.objects.ability.channel')
local utils = require(CurrentLib..'.utils')

ObjEdit = {}

function ObjEdit.close()
    WeFile.close()
end

function ObjEdit.createUnit(id, base_id)
    WeUnit.new(id, base_id)
end

-- Restore global var
CurrentLib = prev_val
return nil