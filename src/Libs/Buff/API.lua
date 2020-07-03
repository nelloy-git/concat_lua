---@class BuffLib
local BuffLibAPI = {}
local modname = Compiletime(Lib.getModname())
Lib.start(modname)

--===========
-- Depencies
--===========

Lib.current().depencies = {
    Class = require(LibList.ClassLib),
    UtilsLib = require(LibList.UtilsLib)
}

--=====
-- API
--=====

---@type BuffsContainerClass
BuffLibAPI.Container = require(modname..'.Container')
---@type BuffTypeClass
BuffLibAPI.Type = require(modname..'.Type')
---@type BuffType
BuffLibAPI.TestType = require(modname..'.TestType')

Lib.finish()

return BuffLibAPI