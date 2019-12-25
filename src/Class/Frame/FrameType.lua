--=========
-- Include
--=========

--=======
-- Class
--=======

---@type FrameTypeClass
local FrameType = newClass('FrameType')

---@class FrameType
local public = FrameType.public
---@class FrameTypeClass
local static = FrameType.static
---@type table
local override = FrameType.override
---@type table(FrameType, table)
local private = {}

--=========
-- Static
--=========

---@param name string
---@param base_name string
---@param is_simpleframe boolean
---@param instance_data table | nil
---@return FrameType
function static.new(name, base_name, is_simpleframe, instance_data)
    local instance = instance_data or newInstanceData(FrameType)
    local priv = private.new(instance, name, base_name, is_simpleframe)

    return instance
end

---@param data FdfObjectRuntime
---@param is_simpleframe boolean
---@param instance_data table | nil
---@return FrameType
function static.load(data, is_simpleframe, instance_data)
    local instance = instance_data or newInstanceData(FrameType)
    local priv = private.load(instance, data, is_simpleframe)

    return instance
end

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end

---@return string
function public:getName()
    return private.get(self).name
end

---@return boolean
function public:isSimple()
    return private.get(self).is_simpleframe
end

--=========
-- Private
--=========

local private_data = {}
---@param self FrameType
---@param name string
---@param base_name string
---@param is_simpleframe boolean
---@return FrameTypePrivate
function private.new(self, name, base_name, is_simpleframe)
    ---@type FrameTypePrivate
    local priv = {
        name = name,
        base_name = base_name,
        is_simpleframe = is_simpleframe
    }

    private_data[self] = priv
    return priv
end

---@param self FrameType
---@param data FdfObjectRuntime
---@return FrameTypePrivate
function private.load(self, data, is_simpleframe)
    ---@class FrameTypePrivate
    local priv = data
    priv.is_simpleframe = is_simpleframe

    private_data[self] = priv
    return priv
end

---@param self FrameType
---@return FrameTypePrivate
function private.get(self)
    return private_data[self]
end

---@param self FrameType
function private.free(self)
    private_data[self] = nil
end

return FrameType