--=========
-- Include
--=========

--region Include
local lib_modname = Lib.current().modname
local depencies = Lib.current().depencies

local Class = depencies.Class
---@type UtilsLib
local UtilsLib = depencies.UtilsLib
local Action = UtilsLib.Action
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local Log = UtilsLib.DefaultLogger
local Unit = UtilsLib.Handle.Unit
local Timer = UtilsLib.Handle.Timer

---@type AbilityInfoTypeClass
local AbilityInfoType = require(lib_modname..'.Info.Type')
--endregion

--=======
-- Class
--=======

local AbilityInfo = Class.new('AbilityInfo')
--region Class
---@class AbilityInfo
local public = AbilityInfo.public
---@class AbilityInfoClass
local static = AbilityInfo.static
---@type AbilityInfoClass
local override = AbilityInfo.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param owner Unit
---@param abil_info_type AbilityInfoType
---@param child_instance AbilityInfo | nil
---@return AbilityInfo
function override.new(owner, abil_info_type, child_instance)
    checkTypeErr(owner, Unit, 'owner')
    checkTypeErr(abil_info_type, AbilityInfoType, 'abil_info_type')
    if child_instance then checkTypeErr(child_instance, AbilityInfo, 'child_instance') end

    local instance = child_instance or Class.allocate(AbilityInfo)
    private.newData(instance, abil_info_type, owner)

    return instance
end

---@return number
function static.getScanningPeriod()
    return private.scanning_period
end

---@alias AbilityInfoCallback fun(abil_info:AbilityInfo, name:AbilityInfoName)
---@alias AbilityInfoName string
static.INFO_NAME = {}
---@type AbilityInfoName
static.INFO_NAME.Name = 'Name'
---@type AbilityInfoName
static.INFO_NAME.Range = 'Range'
---@type AbilityInfoName
static.INFO_NAME.Area = 'Area'
---@type AbilityInfoName
static.INFO_NAME.TargetingType = 'TargetingType'
---@type AbilityInfoName
static.INFO_NAME.TargetsAllowed = 'TargetsAllowed'
---@type AbilityInfoName
static.INFO_NAME.ManaCost = 'ManaCost'
---@type AbilityInfoName
static.INFO_NAME.HealthCost = 'HealthCost'
---@type AbilityInfoName
static.INFO_NAME.Icon = 'Icon'
---@type AbilityInfoName
static.INFO_NAME.Tooltip = 'Tooltip'

--========
-- Public
--========

---@param flag boolean
function public:autoUpdate(flag)
    if flag then
        private.scaning_list[self] = private.data[self]
    else
        private.scaning_list[self] = nil
    end
end

function public:update()
    local priv = private.data[self]

    local abil_info_type = priv.abil_info_type
    local owner = priv.owner
    for _, info_name in pairs(static.INFO_NAME) do
        local new_val = private.getInfoFromType(abil_info_type, info_name, owner)
        if new_val ~= priv[info_name] then
            priv[info_name] = new_val
            if priv.changed_action then priv.changed_action:run(self, info_name) end
        end
    end
end

---@param info_name AbilityInfoName
function public:get(info_name)
    local priv = private.data[self]

    local new_val = private.getInfoFromType(priv.abil_info_type, info_name, priv.owner)
    if new_val ~= priv[info_name] then
        priv[info_name] = new_val
        if priv.changed_action then priv.changed_action:run(self, info_name) end
    end

    return new_val
end

--===========
-- Callbacks
--===========

---@param callback AbilityInfoCallback | Action
function public:setInfoChangedAction(callback)
    if type(callback) == 'function' then
        private.data[self].changed_action = Action.new(callback, self)
    elseif callback == nil or Class.type(callback, Action) then
        local action = callback
        private.data[self].changed_action = action
    else
        Log:err('variable \'callback\' is not of type AbilityInfoCallback | Action', 2)
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.scaning_list = setmetatable({}, {__mode = 'k'})

---@param self AbilityInfo
---@param abil_info_type AbilityInfoType
---@param owner Unit
function private.newData(self, abil_info_type, owner)
    local priv = {
        owner = owner,
        abil_info_type = abil_info_type,

        changed_action = nil,
    }
    private.data[self] = priv
end

private.scanning_period = 3
function private.scanningLoop()
    for info_data, _ in pairs(private.scaning_list) do
        info_data:update()
    end
end

---@param abil_info_type AbilityInfoType
---@param info_name AbilityInfoName
---@param owner Unit
function private.getInfoFromType(abil_info_type, info_name, owner)
    local NAME = static.INFO_NAME
    if info_name == NAME.Name then return abil_info_type:getName()
    elseif info_name == NAME.Range then return abil_info_type:getRange(owner)
    elseif info_name == NAME.Area then return abil_info_type:getArea(owner)
    elseif info_name == NAME.TargetingType then return abil_info_type:getTargetingType(owner)
    elseif info_name == NAME.TargetsAllowed then return abil_info_type:getTargetsAllowed(owner)
    elseif info_name == NAME.ManaCost then return abil_info_type:getManaCost(owner)
    elseif info_name == NAME.HealthCost then return abil_info_type:getHealthCost(owner)
    elseif info_name == NAME.Icon then return abil_info_type:getIcon(owner)
    elseif info_name == NAME.Tooltip then return abil_info_type:getTooltip(owner)
    end
end

if not IsCompiletime() then
    private.scanning_timer = Timer.new()
    private.scanning_timer:start(private.scanning_period, true, private.scanningLoop)
end

return static