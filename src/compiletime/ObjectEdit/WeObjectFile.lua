--=========
-- Include
--=========

--=======
-- Class
--=======

---@type WeObjectFileClass
local WeObjectFile = newClass('WeObjectFile')

---@class WeObjectFile
local public = WeObjectFile.public
---@class WeObjectFileClass
local static = WeObjectFile.static
---@type table
local override = WeObjectFile.override
---@type table(WeObjectFile, table)
local private = {}

--=========
-- Methods
--=========

---@param instance_data table | nil
---@return WeObjectFile
function static.new(instance_data)
    local instance = instance_data or newInstanceData(WeObjectFile)
    local priv = {
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
end

return WeObjectFile