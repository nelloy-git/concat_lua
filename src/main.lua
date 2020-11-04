LibManager = require('LibManager.API')

if IsGame() then
    return
end

LibManager.init('Lib', false)
local LuaClass = require(LibManager.load('https://github.com/nelloy-git/LuaClass.git'))
local Wc3Utils = require(LibManager.load('https://github.com/nelloy-git/Wc3Utils.git'))
local Wc3Binary = require(LibManager.load('https://github.com/nelloy-git/Wc3Binary.git'))
local Wc3Input = require(LibManager.load('https://github.com/nelloy-git/Wc3Input.git'))
local Wc3Damage = require(LibManager.load('https://github.com/nelloy-git/Wc3Damage.git'))
local Wc3Parameter = require(LibManager.load('https://github.com/nelloy-git/Wc3Parameter.git'))

local sep = package.config:sub(1,1)

local function scanDir(path)
    local pfile
    if sep == '/' then
        pfile = io.popen('ls -a "'..path..'"')
    else
        pfile = io.popen('dir '..path..' /b/a')
    end

    local list = {}
    for filename in pfile:lines() do
        table.insert(list, filename)
    end
    pfile:close()
    return list
end

local files = scanDir('map_data')
for i = 1, #files do
    os.execute('copy map_data'..sep..files[i]..' '..GetDst()..sep..files[i]..' > NUL')
end


return
--[[
--local Class = require(LibList.ClassLib)

---@type ParameterLib
local ParameterLib = require(LibList.ParameterLib) or error('')
local Param = ParameterLib.ParamType or error('')
local UnitParam = ParameterLib.UnitContainer or error('')
local Value = ParameterLib.ValueType or error('')

local Input = require(LibList.InputLib) or error('')

---@type BuffLib
--local BuffLib = require(LibList.BuffLib)

---@type Interface
local Interface = require('Interface.Init')
---@type CorruptedPriest
local CorruptedPriest = require('Hero.CorruptedPriest.Unit')

if IsCompiletime() then
    return
end

u = CorruptedPriest.new(0, 0, Player(0))
u3 = CorruptedPriest.new(0, 0, Player(0))
u4 = CorruptedPriest.new(0, 0, Player(0))

u2 = CorruptedPriest.new(0, 0, Player(1))

local param_container2 = UnitParam.get(u2)
param_container2:add(Param.PATK, Value.BASE, 10)
param_container2:add(Param.MDEF, Value.BASE, 5)
param_container2:add(Param.LIFE, Value.BASE, 1000)
]]