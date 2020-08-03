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

local AbilityCooldownCatcher = Class.new('AbilityCooldownCatcher')
--region Class
---@class AbilityCooldownCatcher
local public = AbilityCooldownCatcher.public
---@class AbilityCooldownCatcherClass
local static = AbilityCooldownCatcher.static
---@type AbilityCooldownCatcherClass
local override = AbilityCooldownCatcher.override
local private = {}
--endregion

--========
-- Static
--========

---@param child_instance AbilityCooldownCatcher | nil
---@return AbilityCooldownCatcher
function override.new(child_instance)
    if child_instance then checkTypeErr(child_instance, AbilityCooldownCatcher, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilityCooldownCatcher)
    return instance
end

--========
-- Public
--========

function public:onCooldownStart() end

function public:onCooldownLoop() end

function public:onCooldownFinish() end

--=========
-- Private
--=========

return static