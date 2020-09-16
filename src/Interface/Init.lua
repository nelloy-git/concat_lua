--=========
-- Include
--=========

---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
---@type HandleLib
local HandleLib = require(LibList.HandleLib) or error('')
local Timer = HandleLib.Timer
local Unit = HandleLib.Unit
---@type ParameterLib
local ParamLib = require(LibList.ParameterLib) or error('')
local ParamUnitContainer = ParamLib.UnitContainer or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local Log = UtilsLib.Log or error('')

---@type InterfaceMinimapClass
local InterfaceMinimap = require('Interface.Minimap') or error('')
---@type InterfaceSelection
local InterfaceSelection = require('Interface.Selection') or error('')
---@type InterfaceSpellButtonsClass
local InterfaceSpellButtons = require('Interface.SpellButtons') or error('')
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

---------------
-- Inventory --
---------------

FrameLib.Origin.Inventory:setVisible(false)

-------------
-- Minimap --
-------------

Interface.Minimap = InterfaceMinimap.new()
Interface.Minimap:setSize(0.15, 0.15)
Interface.Minimap:setPos(0, 0)
FrameLib.Screen.addChangedAction(function (x0, y0, w, h)
    Interface.Minimap:setPos(x0, y0 + h - Interface.Minimap:getHeight())
end)

-----------------
-- ChatEditBox --
-----------------

Interface.ChatEditBox = FrameLib.Origin.ChatEditBox
Interface.ChatEditBox:setPos(0, 0)
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
InterfaceSelection.addAction(function(group)
    if #group == 1 then
        local target = Unit.getLinked(group[1])
        if not target then
            Log:err('Can not find linked Unit')
        end

        Interface.UnitStatus:setVisible(true)
        selected = target
    else
        Interface.UnitStatus:setVisible(false)
        selected = nil
    end
end)

local stats_time = Timer.new()
stats_time:start(0.05, true, function()
    if selected then
        if selected:getHealth() > 0.5 then
            Interface.UnitStatus:setHealth(selected:getHealth(), selected:getMaxHealth())
            Interface.UnitStatus:setMana(selected:getMana(), selected:getMaxMana())

            local params = ParamUnitContainer.get(selected)
            if not params then Log:err('Can not find linked ParameterContainerUnit') end
            Interface.UnitStatus:setParameters(params)
        else
            Interface.UnitStatus:setVisible(false)
        end
    end
end)

-------------------
-- Skill buttons --
-------------------

Interface.SkillsButtons = InterfaceSpellButtons.new()
Interface.SkillsButtons:setSize(0.3, 0.045)
Interface.SkillsButtons:setPos(0.5, 0)
FrameLib.Screen.addChangedAction(function (x0, y0, w, h)
    Interface.SkillsButtons:setPos(x0 + w - Interface.SkillsButtons:getWidth(), 
                                   y0 + h - Interface.SkillsButtons:getHeight())
end)

--------------------------
-- Damage Floating Text --
--------------------------

return Interface