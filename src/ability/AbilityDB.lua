---@class AbilityDB
local AbilityDB = {}

---@param ability_id integer
---@param ability Ability
---@return nil
function AbilityDB.add(ability_id, ability)
    AbilityDB[ability_id] = ability
end

---@param ability_id integer
---@return nil
function AbilityDB.rm(ability_id)
    AbilityDB[ability_id] = nil
end

---@param ability_id integer
---@return Ability
function AbilityDB.get(ability_id)
    return AbilityDB[ability_id]
end

return AbilityDB