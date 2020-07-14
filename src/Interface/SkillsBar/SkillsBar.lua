--=========
-- Include
--=========

--region Include
local Class = require(LibList.ClassLib)

---@type FrameLib
local FrameLib = require(LibList.FrameLib)
local FdfFrame = FrameLib.FdfFrame
local SimpleBase = FrameLib.SimpleBase
local SimpleBasePublic = Class.getPublic(FrameLib.SimpleBase)
local SimpleButton = FrameLib.SimpleButton
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local checkTypeErr = UtilsLib.Functions.checkTypeErr
local DataSync = UtilsLib.DataSync
local Log = UtilsLib.DefaultLogger

---@type InterfaceSkillTooltipClass
local SkillTootip = require('Interface.SkillsBar.SkillTooltip')
--endregion

--=======
-- Class
--=======

local InterfaceSkillsBar = Class.new('InterfaceSkillsBar', SimpleBase)
--region Class
---@class InterfaceSkillsBar : SimpleBaseFrame
local public = InterfaceSkillsBar.public
---@class InterfaceSkillsBarClass : SimpleBaseFrameClass
local static = InterfaceSkillsBar.static
---@type InterfaceSkillsBarClass
local override = InterfaceSkillsBar.override
local private = {}
--endregion

--=========
-- Static
--=========

---@param count number
---@param child_instance InterfaceSkillsBar | nil
---@return InterfaceSkillsBar
function override.new(count, child_instance)
    if child_instance then
        checkTypeErr(child_instance, InterfaceSkillsBar, 'child_instance')
    end

    local instance = child_instance or Class.allocate(InterfaceSkillsBar)
    instance = SimpleBase.new(private.default_fdf, instance)
    private.newData(instance, count)

    return instance
end

--========
-- Public
--========

---@param width number
function public:setWidth(width)
    SimpleBasePublic.setWidth(self, width)
    private.updateSize(self)
end

---@param height number
function public:setHeight(height)
    SimpleBasePublic.setHeight(self, height)
    private.updateSize(self)
end

---@param i number
---@param abil Ability
function public:setSkill(i, abil)
    local priv = private.data[self]

    if i > priv.count then
        Log:wrn('InterfaceSkillsBar:setSkill i is greater then bar\'s size.')
        return
    end

    priv.abils[i] = abil
    private.updateData(self, i)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

private.default_fdf = FdfFrame.new('InterfaceSkillsBar', 'SIMPLEFRAME')
do
    local fdf = private.default_fdf
    fdf:setParameter('Width', '0.25')
    fdf:setParameter('Height', '0.05')
end

---@param self InterfaceSkillsBar
function private.newData(self, count)
    local priv = {
        count = count,

        buttons = {},
        tooltips = {},
        abils = {}
    }
    private.data[self] = priv

    for i = 1, count do
        local button = SimpleButton.new()
        local tooltip = SkillTootip.new()

        tooltip:setParent(button)

        button:setParent(self)
        button:setTooltip(tooltip)

        priv.buttons[i] = button
        priv.tooltips[i] = tooltip
    end

    private.updateSize(self)
end

---@param self InterfaceSkillsBar
function private.updateSize(self)
    local priv = private.data[self]

    local count = priv.count
    local w = self:getWidth()
    local h = self:getHeight()
    local dist = (w - h) / (count - 1)

    for i = 1, count do
        local button = priv.buttons[i]
        local tooltip = priv.tooltips[i]
        button:setSize(h, h)
        button:setX((i - 1) * dist)
        button:setY(0)

        tooltip:setX(0)
        tooltip:setY(button:getHeight())
    end
end

---@param self InterfaceSkillsBar
---@param prev_w number
---@param prev_h number
---@param new_w number
---@param new_h number
function private.autoPositioning(self, prev_w, prev_h, new_w, new_h)
    self:setX(new_w - self:getWidth()/2)
    self:setY(0)
    print(self:getX(), self:getY())
end

private.color_name = '|cFFC0C000'
private.color_health = '|cFFC00000'
private.color_mana = '|cFF5050FF'
private.color_charges = '|cFFC0C000'
private.color_end = '|r'

---@param self InterfaceSkillsBar
---@param i number
function private.updateData(self, i)
    local priv = private.data[self]
    ---@type Ability
    local abil = priv.abils[i]
    ---@type AbilityType
    local abil_type = abil:getType()

    priv.buttons[i]:setTextureFile(abil_type:getIcon(abil), 0, true)
    local name = private.color_name..abil_type:getName(abil)..private.color_end
    local description = abil_type:getTooltip(abil)
    local hp = private.color_health..tostring(abil_type:getHealthCost(abil))..private.color_end
    local mp = private.color_mana..tostring(abil_type:getManaCost(abil))..private.color_end
    local ch = private.color_charges..tostring(abil_type:getChargesForUse(abil))..private.color_end
    local resources = tostring(hp..'/'..mp..'/'..ch)
    priv.tooltips[i]:set(name, description, resources)
end

return static