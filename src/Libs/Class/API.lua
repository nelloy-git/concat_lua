local ClassLibAPI = {}
local modname = Compiletime(Lib.getModname())
Lib.start(modname)

--===========
-- Depencies
--===========

--=====
-- API
--=====

---@type ClassDeclare
local ClassDeclare = require(modname..'.Declare')
---@type ClassName
local ClassName = require(modname..'.Name')
---@type ClassParent
local ClassParent = require(modname..'.Parent')
ClassParent.init()
---@type ClassPublic
local ClassPublic = require(modname..'.Public')
---@type ClassInstance
local ClassInstance = require(modname..'.Instance')
---@type ClassOverride
local ClassOverride = require(modname..'.Override')

ClassLibAPI.new = ClassDeclare.register
ClassLibAPI.allocate = ClassInstance.allocate
ClassLibAPI.isClass = ClassName.isClass
ClassLibAPI.isInstance = ClassInstance.isInstance
ClassLibAPI.getClass = ClassInstance.getClass
ClassLibAPI.isChild = ClassParent.isChild
ClassLibAPI.getPublic = ClassPublic.get
ClassLibAPI.getOverride = ClassOverride.get
ClassLibAPI.type = ClassDeclare.type

require(modname..'.AllInOne')
ClassLibAPI = ClassAPI

Lib.finish()

return ClassLibAPI