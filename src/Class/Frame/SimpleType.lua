--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

---@type DataBaseClass
local DataBase = require('Class.DataBase')
---@type CompiletimeDataClass
local CompiletimeData = require('Class.CompiletimeData')

--=======
-- Class
--=======

local FrameSimpleType = Class.new('FrameSimpleType')
---@class FrameSimpleType
local public = FrameSimpleType.public
---@class FrameSimpleClassType
local static = FrameSimpleType.static
---@type FrameSimpleClassType
local override = FrameSimpleType.override
local private = {}

--=========
-- Static
--=========

---@alias FrameSimpleTypeBase string
---@type FrameSimpleTypeBase[]
static.Base = {
    FRAME = 1,
    BUTTON = 2,
    TEXT = 3
}

---@param uniq_name string
---@param base_frame FrameSimpleTypeBase
---@param child_instance FrameSimpleType | nil
---@return FrameSimpleType
function static.new(uniq_name, base_frame, child_instance)
    local instance = child_instance or Class.allocate(FrameSimpleType)
    private.newData(instance, uniq_name, base_frame)

    return instance
end

--========
-- Public
--========

function public:free()
    private.freeData(self)
    Class.free(self)
end

--=========
-- Private
--=========

private.DB = DataBase.new('number', FrameSimpleType)
private.CompiletimeData = CompiletimeData.new(FrameSimpleType)
local _ = Compiletime(function()
    local FdfEdit = require('compiletime.FdfEdit')
    private.SimpleFrame = FdfEdit.SimpleFrame
    private.SimpleButton = FdfEdit.SimpleButton
    private.SimpleString = FdfEdit.SimpleString
    private.SimpleTexture = FdfEdit.SimpleTexture
end)

---@param base any
---@return boolean
function private.isSimpleBase(base)
    for _, v in pairs(static.Base) do
        if base == v then
            return true
        end
    end
    return false
end

function private.createWc3Frame(name, base)
    if not private.isSimpleBase(base) then
        Log.error(FrameSimpleType, 'wrong simple frame base.', 3)
    end

    
end

---@param instance FrameSimpleType
function private.newData(instance)
    local priv = {
    }
    private[instance] = priv
end

---@param instance FrameSimpleType
function private.freeData(instance)
    private[instance] = nil
end

return static