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

---@type AbilityExtClass
local AbilityExt = require(lib_path..'Ability')
---@type AbilityExtTypeClass
local AbilityExtType = require(lib_path..'Type')

--=======
-- Class
--=======

local AbilityExtContainer = Class.new('AbilityExtContainer')
---@class AbilityExtContainer
local public = AbilityExtContainer.public
---@class AbilityExtContainerClass
local static = AbilityExtContainer.static
---@type AbilityExtContainerClass
local override = AbilityExtContainer.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child AbilityExtContainer | nil
---@return AbilityExtContainer
function override.new(owner, child)
    isTypeErr(owner, Unit, 'owner')
    if child then isTypeErr(child, AbilityExtContainer, 'child') end

    local instance = child or Class.allocate(AbilityExtContainer)
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
---@param abil_type AbilityExtType | nil
function public:set(hotkey, abil_type)
    isTypeErr(hotkey, 'string', 'hotkey')
    if abil_type then isTypeErr(abil_type, AbilityExtType, 'abil_type') end

    local priv = private.data[self]

    local data = AbilityExt.new(priv.owner, abil_type, hotkey)
    local prev = priv.abil_data_list[hotkey]
    if prev then prev:destroy() end
    priv.abil_data_list[hotkey] = data
end

---@param hotkey string | "'Q'" | "'W'" | "'E'" | "'R'" | "'T'" | "'D'" | "'F'"
---@return AbilityExt | nil
function public:get(hotkey)
    return private.data[self].abil_data_list[hotkey]
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owners = setmetatable({}, {__mode = 'k'})

---@param self AbilityExtContainer
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