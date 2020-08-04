--=========
-- Include
--=========

--region Include
local lib_modename = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local ActionList = UtilsLib.ActionList
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Unit = UtilsLib.Handle.Unit

---@type AbilityDataClass
local AbilityData = require(lib_modename..'.Data.Base')
---@type AbilityDataTypeClass
local AbilityDataType = require(lib_modename..'.Data.Type')
--endregion

--=======
-- Class
--=======

local AbilitiesContainer = Class.new('AbilitiesContainer')
---@class AbilitiesContainer
local public = AbilitiesContainer.public
---@class AbilitiesContainerClass
local static = AbilitiesContainer.static
---@type AbilitiesContainerClass
local override = AbilitiesContainer.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child_instance AbilitiesContainer | nil
---@return AbilitiesContainer
function override.new(owner, child_instance)
    checkTypeErr(owner, Unit, 'owner')
    if child_instance then checkTypeErr(child_instance, AbilitiesContainer, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilitiesContainer)
    private.newData(instance, owner)

    return instance
end

function static.get(owner)
    return private.owners[owner]
end

--========
-- Public
--========

---@return Unit
function public:getOwner()
    return private.data[self].owner
end

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@param abil_type AbilityDataType | nil
---@return AbilityData | nil
function public:set(hotkey, abil_type)
    checkTypeErr(hotkey, 'string', 'hotkey')
    if abil_type then checkTypeErr(abil_type, AbilityDataType, 'abil_type') end

    local priv = private.data[self]

    local data = AbilityData.new(priv.owner, abil_type, hotkey)
    local prev = priv.abil_data_list[hotkey]
    priv.abil_data_list[hotkey] = data

    return prev
end

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@return AbilityData | nil
function public:get(hotkey)
    return private.data[self].abil_data_list[hotkey]
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owners = setmetatable({}, {__mode = 'kv'})

---@param self AbilitiesContainer
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        abil_data_list = {}
    }

    private.data[self] = priv
    private.owners[owner] = self
end

return static