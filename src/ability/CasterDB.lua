---@class CasterDB
local CasterDB = {}

---@param caster wc3_unit
---@param data SpellData
---@return nil
function CasterDB.add(caster, data)
    CasterDB[caster] = data
end

---@param caster wc3_unit
---@return nil
function CasterDB.rm(caster)
    CasterDB[caster] = nil
end

---@param caster wc3_unit
---@return SpellData
function CasterDB.get(caster)
    return CasterDB[caster]
end

return CasterDB