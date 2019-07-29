local BuffType = {
    __callback_timer = nil,
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

function BuffType:start(target, instance_userdata)
    return self.start_cb(target, instance_userdata, self.type_userdata)
end

function BuffType:period(target, instance_userdata)
    return self.periodic_cb(target, instance_userdata, self.type_userdata)
end

function BuffType:dispell(target, instance_userdata)
    return self.dispell_cb(target, instance_userdata, self.type_userdata)
end

function BuffType:finish(target, instance_userdata)
    return self.end_cb(target, instance_userdata, self.type_userdata)
end

function BuffType:setStartCallback(start_callback)
    self.start_cb = start_callback
end

function BuffType:setPeriodicCallback(periodic_callback)
    self.periodic_cb = periodic_callback
end

function BuffType:setDispellCallback(dispell_callback)
    self.dispell_cb = dispell_callback
end

function BuffType:setStartCallback(start_callback)
    self.start_callback = start_callback
end

return BuffType