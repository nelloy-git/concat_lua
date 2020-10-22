--=========
-- Include
--=========

---@type AbilityLib
local AbilLib = require(LibList.AbilityExtLib) or error('')
---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Timer = HandleLib.Timer or error('')
local Unit = HandleLib.Unit or error('')
---@type InputLib
local InputLib = require(LibList.InputLib) or error('')
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local ParamUnitContainer = ParamLib.UnitContainer or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local Log = UtilsLib.Log or error('')

---@type InterfaceMinimapClass
local InterfaceMinimap = require('Interface.Minimap') or error('')
---@type InterfaceSkillPanelClass
local InterfaceSkillPanel = require('Interface.Skill.Panel') or error('')
---@type InterfaceUnitStatusClass
local InterfaceUnitStatus = require('Interface.UnitStatus') or error('')

local DamageText = require('Interface.ShowDamage') or error('')


--========
-- Module
--========

---@class Interface
local Interface = {}

if IsCompiletime() then
    return
end

----------------
-- Hide origins
----------------

FrameLib.Origin.Inventory:setVisible(false)
for pos, btn in pairs(FrameLib.Origin.SkillButton) do
    btn:setVisible(false)
end

-------------
-- Minimap --
-------------

Interface.Minimap = InterfaceMinimap.new()
Interface.Minimap:setSize(0.15, 0.15)
--Interface.Minimap:setPos(0.4, 0.3)
FrameLib.Screen.addChangedAction(function (x0, y0, w, h)
    --Interface.Minimap:setPos(0.4, 0.3)
    Interface.Minimap:setPos(x0, y0 + h - Interface.Minimap:getHeight())
end)

-----------------
-- ChatEditBox --
-----------------

Interface.ChatEditBox = FrameLib.Origin.ChatEditBox
Interface.ChatEditBox:setVisible(false)
--Interface.ChatEditBox:setPos(0, 0)
Interface.ChatEditBox:setSize(0.3, 0.025)
FrameLib.Screen.addChangedAction(function (x0, y0, w, h)
    local map_w = Interface.Minimap:getWidth()

    local x = x0 + map_w > 0 and x0 + map_w + 0.005 or 0
    Interface.ChatEditBox:setPos(x, y0 + h - Interface.ChatEditBox:getHeight())
end)

-------------
-- ChatBox --
-------------

Interface.ChatBox = FrameLib.Origin.ChatBox
Interface.ChatBox:setVisible(false)
Interface.ChatBox:setParent(Interface.ChatEditBox)
Interface.ChatBox:setPos(0, Interface.ChatEditBox:getHeight() + Interface.ChatBox:getHeight())
Interface.ChatBox:setSize(0.3, 0.25)

--------------
-- Portrait --
--------------

Interface.UnitStatus = InterfaceUnitStatus.new()
Interface.UnitStatus:setSize(0.3, 0.08)
Interface.UnitStatus:setPos(0, 0)
Interface.UnitStatus:setVisible(false)

FrameLib.Screen.addChangedAction(function (x0, y0, w, h)
    Interface.UnitStatus:setPos(x0, 0.03)
end)

---@type Unit
local selected = nil
InputLib.addSelectionAction(function(group, pl)
    if pl ~= GetLocalPlayer() then
        return
    end

    if #group == 1 then
        local target = group[1]
        if not target then Log:err('Can not find linked Unit') end
        selected = target

        Interface.UnitStatus:setVisible(true)

        local buffs = BuffLib.Container.get(selected)
        Interface.UnitStatus:setBuffContainer(buffs)

        local params = ParamLib.UnitContainer.get(selected)
        Interface.UnitStatus:setParameters(params)
    else
        selected = nil
        Interface.UnitStatus:setVisible(false)
    end
end)

local stats_time = Timer.new()
stats_time:start(0.01, true, function()
    if selected then
        if selected:getHealth() > 0.5 then
            Interface.UnitStatus:setShield(BuffLib.getShield(selected), BuffLib.getMaxShield(selected))
            Interface.UnitStatus:setHealth(selected:getHealth(), selected:getMaxHealth())
            Interface.UnitStatus:setMana(selected:getMana(), selected:getMaxMana())
        else
            Interface.UnitStatus:setVisible(false)
        end
    end
end)

-------------------
-- Skill buttons --
-------------------

Interface.SkillsPanel = InterfaceSkillPanel.new(10)
Interface.SkillsPanel:setSize(10 * 0.05, 1 * 0.05)

FrameLib.Screen.addChangedAction(function (x0, y0, w, h)
    Interface.SkillsPanel:setPos(x0 + (w - Interface.SkillsPanel:getWidth()) / 2,
                                 y0 + h - Interface.SkillsPanel:getHeight())
end)

InputLib.addSelectionAction(function(group, pl)
    if pl ~= GetLocalPlayer() then
        return
    end

    if #group == 1 then
        local target = group[1]
        if not target then Log:err('Can not find linked Unit') end
        selected = target

        Interface.SkillsPanel:setVisible(true)

        local abils = AbilLib.Container.get(selected)
        Interface.SkillsPanel:setAbilContainer(abils)
    else
        selected = nil
        Interface.SkillsPanel:setVisible(false)
    end
end)

--------------------------
-- Damage Floating Text --
--------------------------

return Interface