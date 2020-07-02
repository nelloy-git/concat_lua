--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local checkType = UtilsLib.Functions.checkType
local Log = UtilsLib.DefaultLogger
--endregion

--=======
-- Class
--=======

local BuffType = Class.new('BuffType')
--region Class
---@class BuffType
local public = BuffType.public
---@class BuffTypeClass
local static = BuffType.static
---@type BuffTypeClass
local override = BuffType.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param id string
---@param child_instance BuffType | nil
---@return BuffType
function override.new(id, child_instance)
    checkType(id, 'string', 'id')
    if child_instance then
        checkType(child_instance, BuffType, 'child_instance')
    end

    if private.instances[id] then
        Log:err(tostring(BuffType)..' with this id already exists.', 2)
    end

    local instance = child_instance or Class.allocate(BuffType)
    private.instances[id] = instance

    return instance
end

--========
-- Public
--========

--- Virtual function.
--- Return true if started successfully.
---@param buff Buff
function public:onStart(buff) end

--- Virtual function
---@param buff Buff
function public:onTick(buff) end

--- Virtual function
---@param buff Buff
function public:onCancel(buff) end

--- Virtual function
---@param buff Buff
function public:onFinish(buff) end

--- Virtual function
---@param buff Buff
function public:getDuration(buff) end

--- Virtual function
---@param buff Buff
---@return string
function public:getName(buff) end

--- Virtual function
---@param buff Buff
---@return string
function public:getIcon(buff) end

--- Virtual function
---@param buff Buff
---@return string
function public:getTooltip(buff) end

--=========
-- Private
--=========

private.instances = {}

CompileFinal(function()
    for id, instance in pairs(private.instances) do
        for field, value in pairs(public) do
            if value == instance[field] then
                Log:err(id..': virtual function \"'..field..'\" must be overriden.', 1)
            end
        end
    end
end)

return static