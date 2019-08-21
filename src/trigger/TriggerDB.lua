---@class TriggerDB
local TriggerDB = {}

---@param wc3_trigger wc3_Trigger
---@param trigger Trigger
function TriggerDB.add(wc3_trigger, trigger)
    TriggerDB[wc3_trigger] = trigger
end

---@param wc3_trigger wc3_Trigger
function TriggerDB.rm(wc3_trigger)
    TriggerDB[wc3_trigger] = nil
end

---@param wc3_trigger wc3_Trigger
---@return Trigger
function TriggerDB.get(wc3_trigger)
    return TriggerDB[wc3_trigger]
end

return TriggerDB