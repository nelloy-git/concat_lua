--=========
-- Include
--=========

---@type FrameLib
local FrameLib = require(LibList.FrameLib)

---@type ParameterLib
local ParamLib = require(LibList.ParameterLib)
local ParamUnitContainer = ParamLib.UnitContainer
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib)
local Log = UtilsLib.Log
local Unit = UtilsLib.Handle.Unit

---@type InterfaceMinimapClass
local InterfaceMinimap = require('Interface.Minimap')
---@type InterfaceSelection
local InterfaceSelection = require('Interface.Selection')
---@type InterfaceSpellButtonsClass
local InterfaceSpellButtons = require('Interface.SpellButtons')
---@type InterfaceUnitStatusClass
local InterfaceUnitStatus = require('Interface.UnitStatus')

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
FrameLib.Screen.addResolutionChangedAction(function (_, _, _, new_x0, _, _)
    Interface.Minimap:setPos(new_x0, 0)
end)

-----------------
-- ChatEditBox --
-----------------

Interface.ChatEditBox = FrameLib.Origin.ChatEditBox
Interface.ChatEditBox:setPos(0, 0)
Interface.ChatEditBox:setSize(0.3, 0.025)
FrameLib.Screen.addResolutionChangedAction(function (_, _, _, new_x0, _, _)
    local map_w = Interface.Minimap:getWidth()

    local x = new_x0 + map_w > 0 and new_x0 + map_w + 0.005 or 0
    Interface.ChatEditBox:setPos(x, 0)
end)

-------------
-- ChatBox --
-------------

Interface.ChatBox = FrameLib.Origin.ChatBox
Interface.ChatBox:setParent(Interface.ChatEditBox)
Interface.ChatBox:setPos(0, Interface.ChatEditBox:getHeight())
Interface.ChatBox:setSize(0.25, 0.25)

--------------
-- Portrait --
--------------

Interface.UnitStatus = InterfaceUnitStatus.new()
Interface.UnitStatus:setSize(0.3, 0.08)
Interface.UnitStatus:setPos(0, 0.49)
Interface.UnitStatus:setVisible(false)

FrameLib.Screen.addResolutionChangedAction(function (_, _, _, new_x0, _, _)
    Interface.UnitStatus:setPos(new_x0, 0.49)
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

local stats_time = UtilsLib.Handle.Timer.new()
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
FrameLib.Screen.addResolutionChangedAction(function (_, _, _, new_x0, new_width, _)
    Interface.SkillsButtons:setPos(new_x0 + new_width - Interface.SkillsButtons:getWidth(), 0)
end)

--[[
Interface.SkillsButtons = {}
for i = 6, 12 do
    Interface.SkillsButtons[i - 5] = FrameLib.Origin.SkillButton[i]
end

local count = #Interface.SkillsButtons
for i = 1, count do
    local h = 0.04
    local w = 0.04
    Interface.SkillsButtons[i]:setSize(w, h)
    Interface.SkillsButtons[i]:setPos(0.8 - (count - i + 1) * w, 0)
    FrameLib.Screen.addResolutionChangedAction(function (_, _, _, new_x0, new_width, _)
        Interface.SkillsButtons[i]:setPos(new_x0 + new_width - (count - i + 1) * w, 0)
    end)
end
]]

return Interface