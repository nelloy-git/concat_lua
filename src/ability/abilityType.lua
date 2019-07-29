local AbilType = {
    __buff_data = {}
}

-- compiletime function
function BuffType.new(abil_id, buff_id, name, tooltip, icon, effect_path, attach_point)
    local objEdit = require('compiletime.objEdit.objEdit')
    local buff = objEdit.AuraDummy.new(abil_id, buff_id,
                                       name, tooltip,
                                       icon, effect_path, attach_point)
end

-- Callback function takes buff_userdata, buff_type_userdata returns boolean
function BuffType.register(abil_id, buff_id,
                           start_callback, periodic_callback,
                           dispell_callback, end_callback,
                           buff_type_userdata)
    local buff_type = {
        abil_id = abil_id,
        buff_id = buff_id,
        start_cb = start_callback,
        periodic_cb = periodic_callback,
        dispell_cb = dispell_callback,
        end_cb = end_callback,
        type_userdata = buff_type_userdata
    }
    setmetatable(buff_type, {__index = BuffType})
    BuffType[abil_id] = buff_type
    return buff_type
end