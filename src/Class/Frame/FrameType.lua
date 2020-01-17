--=========
-- Include
--=========

local Class = require('utils.Class.Class')

--=======
-- Class
--=======

local FrameType = Class.new('FrameType')
---@class FrameType
local public = FrameType.public
---@class FrameTypeClass
local static = FrameType.static
local override = FrameType.override
local private = {}

--=========
-- Static
--=========

---@param name string
---@param base_name string
---@param is_simpleframe boolean
---@param child_data any
---@return FrameType
function static.new(name, base_name, is_simpleframe, child_data)
    local instance = child_data or Class.allocate(FrameType, child_data)
    private.new(instance, name, base_name, is_simpleframe)

    return instance
end

---@param data table
---@param is_simpleframe boolean
---@return FrameType
function static.load(data, is_simpleframe, child_data)
    local instance = child_data or Class.allocate(FrameType, child_data)
    private.load(instance, data, is_simpleframe)

    return instance
end

--========
-- Public
--========

function public:free()
    private.free(self)
    Class.freeInstanceData(self)
end

---@return string
function public:getName()
    return private.get(self).name
end

---@return boolean
function public:isSimple()
    return private.get(self).is_simpleframe
end

---@return string
function public:getTextureFramehandleName()
    local priv = private.get(self)
    if not priv.is_simpleframe then
        return priv.name
    end
    return priv.fields.Texture.name
end

---@return string
function public:getStringFramehandleName()
    local priv = private.get(self)
    if not priv.is_simpleframe then
        return priv.name
    end
    return priv.fields.String.name
end

--=========
-- Private
--=========

---@param self FrameType
---@param name string
---@param base_name string
---@param is_simpleframe boolean
function private.new(self, name, base_name, is_simpleframe)
    local priv = {
        name = name,
        base_name = base_name,
        is_simpleframe = is_simpleframe
    }

    private[self] = priv
end

---@param self FrameType
---@param data any
---@param is_simpleframe boolean
function private.load(self, data, is_simpleframe)
    local priv = data
    priv.is_simpleframe = is_simpleframe

    private[self] = priv
end

---@param self FrameType
function private.get(self)
    return private[self]
end

---@param self FrameType
function private.free(self)
    private[self] = nil
end

return FrameType