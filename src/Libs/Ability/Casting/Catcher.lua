--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger
--endregion

--=======
-- Class
--=======

local AbilityCastingCatcher = Class.new('AbilityCastingCatcher')
--region Class
---@class AbilityCastingCatcher
local public = AbilityCastingCatcher.public
---@class AbilityCastingCatcherClass
local static = AbilityCastingCatcher.static
---@type AbilityCastingCatcherClass
local override = AbilityCastingCatcher.override
local private = {}
--endregion

--========
-- Static
--========

---@param child_instance AbilityCastingCatcher | nil
---@return AbilityCastingCatcher
function override.new(child_instance)
    if child_instance then checkTypeErr(child_instance, AbilityCastingCatcher, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilityCastingCatcher)
    return instance
end

--========
-- Public
--========

--- Virtual function.
---@param casting_data AbilityCastingInstance
function public:onCastingStart(casting_data) end

--- Virtual function
---@param casting_data AbilityCastingInstance
function public:onCastingLoop(casting_data) end

--- Virtual function
---@param casting_data AbilityCastingInstance
function public:onCastingCancel(casting_data) end

--- Virtual function
---@param casting_data AbilityCastingInstance
function public:onCastingInterrupt(casting_data) end

--- Virtual function
---@param casting_data AbilityCastingInstance
function public:onCastingFinish(casting_data) end

--=========
-- Private
--=========

return static