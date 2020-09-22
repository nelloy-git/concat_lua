--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local BuffType = Class.new('BuffType')
---@class BuffType
local public = BuffType.public
---@class BuffTypeClass
local static = BuffType.static
---@type BuffTypeClass
local override = BuffType.override
local private = {}

--========
-- Static
--========

---@param id string
---@param child BuffType | nil
---@return BuffType
function override.new(id, child)
    isTypeErr(id, 'string', 'id')
    if child then isTypeErr(child, BuffType, 'child') end

    if private.instances[id] then
        Log:err(tostring(BuffType)..' with this id already exists.', 2)
    end

    local instance = child or Class.allocate(BuffType)
    private.instances[id] = instance

    return instance
end

--========
-- Public
--========

--- Virtual function.
---@param buff Buff
function public:onStart(buff) end

--- Virtual function
---@param buff Buff
function public:onLoop(buff) end

--- Virtual function
---@param buff Buff
function public:onCancel(buff) end

--- Virtual function
---@param buff Buff
function public:onFinish(buff) end

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