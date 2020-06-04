---@class FdfEditLib
local FdfEditLib = {}
local lib_modname = Compiletime(Lib.getModname())
Lib.start()

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
return FdfEditLib