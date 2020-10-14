---@class InputLib
local InputLibAPI = {}
Lib.start('Buff', {
    Class = Lib.load(LibList.ClassLib) or error(''),
    Damage = Lib.load(LibList.DamageLib) or error(''),
    Handle = Lib.load(LibList.HandleLib) or error(''),
    Parameter = Lib.load(LibList.ParameterLib) or error(''),
    Types = Lib.load(LibList.TypesLib) or error(''),
    Utils = Lib.load(LibList.UtilsLib) or error('')
})
local path = Lib.curPath()

--=====
-- API
--=====


Lib.finish()

return InputLibAPI