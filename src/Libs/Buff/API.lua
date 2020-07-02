---@class BuffLib
local BuffLibAPI = {}
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

Lib.finish()

return BuffLibAPI