LibManager = require('LibManager.API')

LibManager.init('Lib', false)

---@type Wc3Handle
local Wc3Handle = require(LibManager.load('https://github.com/nelloy-git/Wc3Handle.git'))

---@type AbilityList
local AbilityList = require(LibManager.load('https://github.com/nelloy-git/AbilityList.git'))
---@type UnitList
local UnitList = require(LibManager.load('https://github.com/nelloy-git/UnitList.git'))

if IsGame() then
    SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    InitBlizzard()

    UnitList.newCorruptedPriest(0, 0, Player(0))
    UnitList.newCorruptedPriest(0, 0, Player(1))
    return
end

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

local function isExist(path)
    local ok, err, code = os.rename(path, path)
    if not ok then
       if code == 13 then
          -- Permission denied, but it exists
          return true
       end
    end
    return ok, err
end

local files = scanDir('map_data')
for i = 1, #files do
    if sep == '\\' then
        os.execute('copy map_data'..sep..files[i]..' '..GetDst()..sep..files[i]..' > NUL')
    elseif sep == '/' then
        if isExist('map_data'..sep..files[i]) then
            os.execute('cp map_data'..sep..files[i]..' '..GetDst()..sep..files[i])
        end
    end
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