--=========
-- Include
--=========

---@type AbilityLib
local AbilLib = require(LibList.AbilityExtLib) or error('')
---@type BuffLib
local BuffLib = require(LibList.BuffLib) or error('')
local BuffContainer = BuffLib.Container or error('')
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

---@type InterfaceBuffPanelClass
local InterfaceBuffPanel = require('Interface.Buff.Panel') or error('')
---@type InterfaceMinimapClass
local InterfaceMinimap = require('Interface.Minimap') or error('')
---@type InterfaceSkillPanelClass
local InterfaceSkillPanel = require('Interface.Skill.Panel') or error('')
---@type InterfaceUnitBarsClass
local InterfaceUnitBars = require('Interface.UnitBars') or error('')
---@type InterfaceUnitPortraitClass
local InterfaceUnitPortrait = require('Interface.UnitPortrait') or error('')

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

-----------------
-- ChatEditBox --
-----------------

Interface.ChatEditBox = FrameLib.Origin.ChatEditBox
Interface.ChatEditBox:setVisible(false)
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

-------------
-- Minimap --
-------------

Interface.Minimap = InterfaceMinimap.new()
Interface.Minimap:setSize(0.12, 0.12)
FrameLib.Screen.addChangedAction(function (x0, y0, w, h)
    Interface.Minimap:setPos(x0, y0 + h - Interface.Minimap:getHeight())
end)

--------------
-- Portrait --
--------------

Interface.UnitPortrait = InterfaceUnitPortrait.new()
Interface.UnitPortrait:setPos(0, 0.03)
Interface.UnitPortrait:setSize(0.075, 0.075)
Interface.UnitPortrait:setVisible(false)

FrameLib.Screen.addChangedAction(function (x0, y0, w, h)
    Interface.UnitPortrait:setPos(x0, 0.03)
end)

InputLib.addSelectionAction(function(group, pl)
    if pl ~= GetLocalPlayer() then
        return
    end

    Interface.UnitPortrait:setVisible(#group == 1)
end)

---------------
-- Unit bars --
---------------

Interface.UnitBars = InterfaceUnitBars.new()
Interface.UnitBars:setParent(Interface.UnitPortrait)
Interface.UnitBars:setVisible(false)

FrameLib.Screen.addChangedAction(function (x0, y0, w, h)
    Interface.UnitBars:setPos(Interface.UnitPortrait:getWidth(), 0)
    Interface.UnitBars:setSize(2 * Interface.UnitPortrait:getWidth(),
                               Interface.UnitPortrait:getHeight() / 3)
end)

InputLib.addSelectionAction(function(group, pl)
    if pl ~= GetLocalPlayer() then
        return
    end

    Interface.UnitBars:setVisible(#group == 1)
    Interface.UnitBars:setTarget(#group == 1 and group[1] or nil)
end)

----------------
-- Unit buffs --
----------------

Interface.UnitBuffs = InterfaceBuffPanel.new(20)
Interface.UnitBuffs:setParent(Interface.UnitBars)
Interface.UnitBuffs:setVisible(false)

FrameLib.Screen.addChangedAction(function (x0, y0, w, h)
    Interface.UnitBuffs:setPos(0, Interface.UnitBars:getHeight())
    Interface.UnitBuffs:setSize(Interface.UnitBars:getWidth(),
                                Interface.UnitBars:getWidth() / 5)
end)

InputLib.addSelectionAction(function(group, pl)
    if pl ~= GetLocalPlayer() then
        return
    end

    Interface.UnitBuffs:setVisible(#group == 1)
    Interface.UnitBuffs:setBuffContainer(#group == 1 and BuffContainer.get(group[1]) or nil)
end)


-------------------
-- Skill buttons --
-------------------

Interface.SkillsPanel = InterfaceSkillPanel.new(10)
Interface.SkillsPanel:setSize(10 * 0.05, 1 * 0.05)
Interface.SkillsPanel:setVisible(false)

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