--=========
-- Include
--=========

local Class = require('Utils.Class.Class')

---@type Import
local Import = require('Resources.Import')
---@type FrameAPI
local FrameAPI = require('Frame.API')
local SimpleFrameType = FrameAPI.SimpleFrameType
local SimpleFrame = FrameAPI.SimpleFrame
local FramePublic = Class.getPublic(FrameAPI.Frame)
---@type InterfaceAbilitySlotClass
local AbilitySlot = require('Interface.Ability.Slot')

--=======
-- Class
--=======

local InterfaceAbilityBar = Class.new('InterfaceAbilityBar', SimpleFrame)
---@class InterfaceAbilityBar
local public = InterfaceAbilityBar.public
---@class InterfaceAbilityBarClass
local static = InterfaceAbilityBar.static
---@type InterfaceAbilityBarClass
local override = InterfaceAbilityBar.override
local private = {}

--=========
-- Static
--=========

---@param cols number
---@param rows number
---@param child_instance InterfaceAbilityBar | nil
---@return InterfaceAbilityBar
function override.new(cols, rows, child_instance)
    local instance = child_instance or Class.allocate(InterfaceAbilityBar)
    instance = SimpleFrame.new(private.background_type, instance)

    private.newData(instance, cols, rows)

    return instance
end

--========
-- Public
--========

---@param width number
function public:setWidth(width)
    FramePublic.setWidth(self, width)
    private.update(self)
end

---@param height number
function public:setHeight(height)
    FramePublic.setHeight(self, height)
    private.update(self)
end

---@param unit Unit | nil
function public:load(unit)
    local priv = private.data[self]
    priv.loaded = unit

    if not unit then
        for i = 1, priv.size do
            priv.slot[i]:setVisible(false)
        end
        return
    end

    local unit_abils = unit:getAbilities()

    for i = 1, priv.size do
        local abil = unit_abils:get(i)

        priv.slot[i]:setAbility(abil)
        priv.slot[i]:setVisible(true)
        --priv.tooltip[i]:setItem(item, unit)
    end
end

function public:updateCooldown()
    local priv = private.data[self]
    for i = 1, priv.size do
        priv.slot[i]:updateCooldown()
    end
end

---@return Unit
function public:getLoaded()
    return private.data[self].loaded
end

---@return number
function public:getSize()
    return private.data[self].size
end


--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.background_type = SimpleFrameType.new('InterfaceAbilityBarBackground', true)
private.background_type:setWidth(0.3)
private.background_type:setHeight(0.04)
private.background_type:setTexture(Import.InventoryBackground)

private.empty_icon = Import.TransparentTexture
private.icon_background_texture = Import.Icon.Empty

private.border_ratio = 1 / 16
private.space_ratio = 1 / 64
--private.tooltip_width = 0.2

---@param self InterfaceAbilityBar
function private.update(self)
    local priv = private.data[self]
    local width = self:getWidth()
    local height = self:getHeight()
    local border_x = private.border_ratio * width
    local border_y = private.border_ratio * height
    local space_x = private.space_ratio * width
    local space_y = private.space_ratio * height
    local cols = priv.cols
    local rows = priv.rows
    local slot_width = (width - 2 * border_x - (cols - 1) * space_x) / cols
    local slot_height = (height - 2 * border_y - (rows - 1) * space_y) / rows

    local i = 0
    for x = 1, priv.cols do
        for y = 1, priv.rows do
            i = i + 1
            local slot = priv.slot[i]
            slot:setX(border_x + (x - 1) * (slot_width + space_x))
            slot:setY(height - border_y - y * (slot_height + space_y) + space_y)
            slot:setWidth(slot_width)
            slot:setHeight(slot_height)

            --local tooltip = priv.tooltip[i]
            --tooltip:setX(-private.tooltip_width)
            --tooltip:setY(0)
            --tooltip:setWidth(private.tooltip_width)
            --tooltip:setHeight(height)
        end
    end
end

---@param self InterfaceAbilityBar
function private.newData(self, cols, rows)
    local priv = {
        loaded = nil,
        cols = cols,
        rows = rows,
        size = cols * rows,

        slot = {},
        --tooltip = {}
    }
    private.data[self] = priv

    for i = 1, priv.size do
        priv.slot[i] = AbilitySlot.new()
        priv.slot[i]:setParent(self)
        priv.slot[i]:setLevel(self:getLevel() + 2)

        --priv.tooltip[i] = ItemTooltip.new()
        --priv.tooltip[i]:setParent(self)

        --priv.slot[i]:setTooltip(priv.tooltip[i])
    end
end


return static