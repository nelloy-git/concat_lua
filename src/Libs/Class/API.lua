ClassAPI = {}

__ClassLib = Compiletime(Lib.getSelf())
Log.error(__ClassLib)

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

ClassAPI.new = ClassDeclare.register
ClassAPI.allocate = ClassInstance.allocate
ClassAPI.isClass = ClassName.isClass
ClassAPI.isInstance = ClassInstance.isInstance
ClassAPI.getClass = ClassInstance.getClass
ClassAPI.isChild = ClassParent.isChild
ClassAPI.getPublic = ClassPublic.get
ClassAPI.getOverride = ClassOverride.get
ClassAPI.type = ClassDeclare.type

__ClassLib = nil

return ClassAPI