local Buff = {}

---Function generates new buff and caring ability in compile time.
---@param name string
---@param tooltip string
---@param icon string
---@param effect_path string
---@param attach_point string
---@return string, string
function Buff.new(name, tooltip, icon, effect_path, attach_point)
    local id = {
        ability = WeObjEdit.Utils.nextAbilityId(),
        buff = WeObjEdit.Utils.nextBuffId()
    }
    local objEdit = require('compiletime.objEdit.objEdit')
    local buff = objEdit.AuraDummy.new(id.ability, id.buff,
                                       name, tooltip,
                                       icon, effect_path, attach_point)
    return id.ability, id.buff
end

-- Callback function takes buff_userdata, buff_type_userdata returns boolean
function Buff.register(abil_id, buff_id,
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
    setmetatable(buff_type, {__index = Buff})
    Buff[abil_id] = buff_type
    return buff_type
end

function Buff:start(target, instance_userdata)
    return self.start_cb(target, instance_userdata, self.type_userdata)
end

function Buff:period(target, instance_userdata)
    return self.periodic_cb(target, instance_userdata, self.type_userdata)
end

function Buff:dispell(target, instance_userdata)
    return self.dispell_cb(target, instance_userdata, self.type_userdata)
end

function Buff:finish(target, instance_userdata)
    return self.end_cb(target, instance_userdata, self.type_userdata)
end

function Buff:setStartCallback(start_callback)
    self.start_cb = start_callback
end

function Buff:setPeriodicCallback(periodic_callback)
    self.periodic_cb = periodic_callback
end

function Buff:setDispellCallback(dispell_callback)
    self.dispell_cb = dispell_callback
end

function Buff:setStartCallback(start_callback)
    self.start_callback = start_callback
end

return Buff