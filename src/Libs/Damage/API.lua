---@class ParameterLib
local DamageLibAPI = {}
local modname = Compiletime(Lib.getModname())
Lib.start(modname)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.Class),
    UtilsLib = require(LibList.Utils)
}

--=====
-- API
--=====

local Init = require(modname..'.Init')


Lib.finish()

return ParameterLibAPI