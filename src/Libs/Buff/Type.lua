--=========
-- Include
--=========

--region Include
local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_depss
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local isTypeErr = UtilsLib.isTypeErr
local Log = UtilsLib.Log
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
---@param child BuffType | nil
---@return BuffType
function override.new(id, child)
    isTypeErr(id, 'string', 'id')
    if child then
        isTypeErr(child, BuffType, 'child')
    end

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
--- Return true if check is successfull.
---@param buff Buff
---@return boolean
function public:checkConditions(buff) end

--- Virtual function.
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