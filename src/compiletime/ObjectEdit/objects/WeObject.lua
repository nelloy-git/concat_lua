--=========
-- Include
--=========

require('utils.Globals')

--=======
-- Class
--=======

---@type WeObjectClass
local WeObject = newClass('WeObject')

---@class WeObject
local public = WeObject.public
---@class WeObjectClass
local static = WeObject.static
---@type table
local override = WeObject.override
---@type table(WeObject, table)
local private = {}

--=========
-- Methods
--=========

---@param id number | string
---@param base_id number | string
---@param instance_data table | nil
---@return WeObject
function static.new(id, base_id, instance_data)
    local instance = instance_data or newInstanceData(WeObject)
    local priv = {
        id = ID2str(id),
        base_id = ID2str(base_id),
        changes = {}
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
end

local utils = require('compiletime.objEdit.weUtils')

---@class WeObject
local WeObject = {}

---@param id number | string
---@param base_id number | string
---@param we_type string|''
---@return WeObject
function WeObject.new(id, base_id, we_type)
    local obj = {
        id = id,
        base_id = base_id,
        we_type = we_type,
        changes = {},
        verbouse = true,
    }
    setmetatable(obj, {__index = WeObject})
    return obj
end

---@param flag boolean
function WeObject:showCompiletimeMsg(flag)
    self.verbouse = flag
end

---@param we_field WeField
function WeObject:addField(we_field)
    for i = 1, #self.changes do
        if self.changes.id == we_field.id then
            table.remove(self.changes, i)
        end
    end
    table.insert(self.changes, we_field)
end

function WeObject:serialize()
    local serial = self.base_id .. self.id .. utils.int2byte(#(self.changes))
    for _, field in pairs(self.changes) do
        serial = serial .. field:serialize() .. '\0\0\0\0'
    end
    return serial
end


return WeObject