-- Get and save lib path
local prev_val = CurrentLib
local path = debug.getinfo(1, "S").source:sub(3)
local separator = package.config:sub(1,1)
local dir = path:sub(1, #path - path:reverse():find(separator))
CurrentLib = dir:gsub(separator, '.'):sub(2)

local WeFile = require(CurrentLib..'.we_edit_file')
local WeUnit = require(CurrentLib..'.objects.unit.unit')
local WeChannelAbil = require(CurrentLib..'.objects.ability.channel')
local utils = require(CurrentLib..'.utils')


local foo = WeUnit.new('h001', 'hpea')
foo:setName('Test footman')

local w3u = WeFile.readFromSrc('unit')
w3u:add(foo)
w3u:writeToDst()

local ch = WeChannelAbil.new('A001')
ch:setName('Test channel')
ch:setOptions(1, 1)

local w3a = WeFile.readFromSrc('ability')
w3a:add(ch)
w3a:writeToDst()

-- Restore global var
CurrentLib = prev_val
return nil