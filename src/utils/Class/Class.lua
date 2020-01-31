local ClassDeclare = require('utils.Class.Declare')
local ClassName = require('utils.Class.Name')
local ClassParent = require('utils.Class.Parent')
local ClassPublic = require('utils.Class.Public')
local ClassInstance = require('utils.Class.Instance')

local ClassAPI = {}

---@type fun(name:string, vararg:any):Class
ClassAPI.new = ClassDeclare.register

---@type fun(class:any):any
ClassAPI.allocate = ClassInstance.allocate

---@type fun(class:any):boolean
ClassAPI.isClass = ClassName.isClass

---@type fun(instance:any):boolean
ClassAPI.isInstance = ClassInstance.isInstance

---@type fun(instance:any):any
ClassAPI.getClass = ClassInstance.getClass

---@type fun(child_class:any, parent_class:any):boolean
ClassAPI.isChild = ClassParent.isChild

---@type fun(class:any):any
ClassAPI.getPublic = ClassPublic.get

---@param value1 any
---@param value2 any
---@return boolean
---@overload fun(value:any):string
---@overload fun(child_class:any, parent_class:any):boolean
---@overload fun(child_instance:any, parent_class:any):boolean
---@overload fun(child_instance:any, parent_instance:any):boolean
ClassAPI.type = ClassDeclare.type

return ClassAPI