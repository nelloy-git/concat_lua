---@class DestructableDB
local DestructableDB = {}

---@param destructable_obj userdata
---@param destructable Destructable
---@return nil
function DestructableDB.add(destructable_obj, destructable)
    DestructableDB[destructable_obj] = destructable
end

---@param destructable_obj userdata
---@return nil
function DestructableDB.rm(destructable_obj)
    DestructableDB[destructable_obj] = nil
end

---@param destructable_obj userdata
---@return Destructable
function DestructableDB.get(destructable_obj)
    return DestructableDB[destructable_obj]
end

return DestructableDB