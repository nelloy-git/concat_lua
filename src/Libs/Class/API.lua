local ClassLibAPI = {}

__ClassLib = Compiletime(Lib.getSelf())

---@type ClassDeclare
local ClassDeclare = require(__ClassLib..'Declare')
---@type ClassName
local ClassName = require(__ClassLib..'Name')
---@type ClassParent
local ClassParent = require(__ClassLib..'Parent')
ClassParent.init()
---@type ClassPublic
local ClassPublic = require(__ClassLib..'Public')
---@type ClassInstance
local ClassInstance = require(__ClassLib..'Instance')
---@type ClassOverride
local ClassOverride = require(__ClassLib..'Override')

ClassLibAPI.new = ClassDeclare.register
ClassLibAPI.allocate = ClassInstance.allocate
ClassLibAPI.isClass = ClassName.isClass
ClassLibAPI.isInstance = ClassInstance.isInstance
ClassLibAPI.getClass = ClassInstance.getClass
ClassLibAPI.isChild = ClassParent.isChild
ClassLibAPI.getPublic = ClassPublic.get
ClassLibAPI.getOverride = ClassOverride.get
ClassLibAPI.type = ClassDeclare.type

__ClassLib = nil

return ClassLibAPI