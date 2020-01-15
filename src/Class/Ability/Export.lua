local Type = require('Class.Ability.Type')

local AbilityExport = {}

---@type fun(id:string|number):Ability
AbilityExport.newType = Type.new
--- Compiletime only
AbilityExport.newWeDummyType = 

return AbilityExport