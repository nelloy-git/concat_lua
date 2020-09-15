--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class or error('')
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Unit = HandleLib.Unit or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local ActionList = UtilsLib.ActionList or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')

---@type AbilityDataClass
local AbilityData = require(lib_path..'.Data.Base')
---@type AbilityDataTypeClass
local AbilityDataType = require(lib_path..'.Data.Type')

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
---@param child AbilitiesContainer | nil
---@return AbilitiesContainer
function override.new(owner, child)
    isTypeErr(owner, Unit, 'owner')
    if child then isTypeErr(child, AbilitiesContainer, 'child') end

    local instance = child or Class.allocate(AbilitiesContainer)
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
function public:set(hotkey, abil_type)
    isTypeErr(hotkey, 'string', 'hotkey')
    if abil_type then isTypeErr(abil_type, AbilityDataType, 'abil_type') end

    local priv = private.data[self]

    local data = AbilityData.new(priv.owner, abil_type, hotkey)
    local prev = priv.abil_data_list[hotkey]
    if prev then prev:destroy() end
    priv.abil_data_list[hotkey] = data
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
private.owners = setmetatable({}, {__mode = 'k'})

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