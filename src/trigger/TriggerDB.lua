---@class TriggerDB
local TriggerDB = {}

---@param trigger_obj userdata
---@param trigger Trigger
function TriggerDB.add(trigger_obj, trigger)
    TriggerDB[trigger_obj] = trigger
end

---@param trigger_obj userdata
function TriggerDB.rm(trigger_obj)
    TriggerDB[trigger_obj] = nil
end

---@param trigger_obj userdata
---@return Trigger
function TriggerDB.get(trigger_obj)
    return TriggerDB[trigger_obj]
end

return TriggerDB