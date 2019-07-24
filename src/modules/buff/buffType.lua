local Debug = require('utils.debugMsg')

local BuffKeeper = {
    __callback_timer = nil
    __buff_data = {}
}

function BuffKeeper.init(callback_timer)
    if BuffKeeper.__callback_timer ~= nil then
        Debug.print('BuffKeeper initialized more then one time.')
        return
    end
    BuffKeeper.__callback_timer = callback_timer
end

-- compiletime function
function BuffKeeper.createBuffType(abil_id, buff_id, name, tooltip, icon, effect_path, attach_point)
    local buff = objEdit.AuraDummy.new(abil_id, buff_id,
                                       name, tooltip,
                                       icon, effect_path, attach_point)
end

function BuffKeeper.registerBuffType(abil_id, buff_id,
                                     start_cb, periodic_cb,
                                     dispell_cb, end_cb)
    local buff_data = {
        abil_id = abil_id,
        buff_id = buff_id,
        start_cb = start_cb,
        periodic_cb = periodic_cb,
        dispell_cb = dispell_cb,
        end_cb = end_cb
    }                                
    --setmetatable(buff_data, {__index = BuffMeta})
    table.insert(BuffKeeper.__buff_data, 1, buff_data)
    return buff_data
end

local BuffInstance = {}
function 

return BuffKeeper