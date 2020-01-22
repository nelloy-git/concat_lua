local ClassDeclare = require('utils.Class.ClassDeclare')
local ClassName = require('utils.Class.ClassName')
local ClassParent = require('utils.Class.ClassParent')
local ClassPublic = require('utils.Class.ClassPublic')
local ClassInstance = require('utils.Class.ClassInstance')

local Class = {}

---@type fun(name:string, vararg:any):any
Class.new = ClassDeclare.register
---@type fun(class:any):any
Class.allocate = ClassInstance.allocate
---@type fun(instance:any)
Class.free = ClassInstance.free
---@type fun(class:any):boolean
Class.isClass = ClassName.isClass
---@type fun(instance:any):boolean
Class.isInstance = ClassInstance.isInstance
---@type fun(instance:any):any
Class.getClass = ClassInstance.getClass
---@type fun(child_class:any, parent_class:any):boolean
Class.isChild = ClassParent.isChild
---@type fun(class:any):any
Class.getPublic = ClassPublic.get
---@param value1 any
---@param value2 any
---@return boolean
---@overload fun(value:any):string
---@overload fun(child_class:any, parent_class:any):boolean
---@overload fun(child_instance:any, parent_class:any):boolean
---@overload fun(child_instance:any, parent_instance:any):boolean
Class.type = ClassDeclare.type


return Class