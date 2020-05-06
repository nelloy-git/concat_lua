---@type ClassDeclare
local ClassDeclare = require('Utils.Class.Declare')
---@type ClassName
local ClassName = require('Utils.Class.Name')
---@type ClassParent
local ClassParent = require('Utils.Class.Parent')
---@type ClassPublic
local ClassPublic = require('Utils.Class.Public')
---@type ClassInstance
local ClassInstance = require('Utils.Class.Instance')
---@type ClassOverride
local ClassOverride = require('Utils.Class.Override')

---@class ClassAPI
ClassAPI = {}

ClassAPI.new = ClassDeclare.register
ClassAPI.allocate = ClassInstance.allocate
ClassAPI.isClass = ClassName.isClass
ClassAPI.isInstance = ClassInstance.isInstance
ClassAPI.getClass = ClassInstance.getClass
ClassAPI.isChild = ClassParent.isChild
ClassAPI.getPublic = ClassPublic.get
ClassAPI.getOverride = ClassOverride.get
ClassAPI.type = ClassDeclare.type

return ClassAPI