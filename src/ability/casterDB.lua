---@class CasterDB
local CasterDB = {}

---@param caster Unit
---@param data SpellInstance
---@return nil
function CasterDB.add(caster, data)
    CasterDB[caster] = data
end

---@param caster Unit
---@return nil
function CasterDB.rm(caster)
    CasterDB[caster] = nil
end

---@param caster Unit
---@return SpellInstance
function CasterDB.get(caster)
    return CasterDB[caster]
end

return CasterDB