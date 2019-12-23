--=========
-- Include
--=========

---@type FrameBackdropClass
local FrameBackdrop = require('Class.Frame.Default.FrameBackdrop')
---@type FrameHoverClass
local FrameHover = require('Class.Frame.Default.FrameHover')
---@type FrameSpringRowClass
local FrameSpringRow = require('Class.Frame.Container.FrameSpringRow')
---@type FrameSpringTableClass
local FrameSpringTable = require('Class.Frame.Container.FrameSpringTable')
---@type FrameTextClass
local FrameText = require('Class.Frame.Default.FrameText')
---@type FrameTooltipClass
local FrameTooltip = require('Class.Frame.Custom.FrameTooltip')
---@type ParameterTypeClass
local ParameterType = require('Class.ParameterType')

--=======
-- Class
--=======

---@type FrameStatsTableClass
local FrameStatsTable = newClass('FrameStatsTable', FrameSpringTable)

---@class FrameStatsTable : FrameSpringTable
local public = FrameStatsTable.public
---@class FrameStatsTableClass : FrameSpringTableClass
local static = FrameStatsTable.static
---@type table
local override = FrameStatsTable.override
---@type table(FrameStatsTable, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FrameStatsTable
function override.new(instance_data)
    local instance = instance_data or newInstanceData(FrameStatsTable)
    instance = FrameSpringTable(nil, instance)
    local priv = private.new(instance)

    return instance
end

--========
-- Public
--========

function public:free()
    private.free(self)
    freeInstanceData(self)
end

---@param param ParameterType
function public:setValue(param, text)
    private.get(self).subframes[param]:getCell(3):setText(text)
end

--=========
-- Private
--=========

private.tooltip_width = 0.1

local private_data = {}
---@param self FrameStatsTable
---@return FrameStatsTablePrivate
function private.new(self)
    ---@class FrameStatsTablePrivate
    local priv = {
        subframes = {},
    }
    private_data[self] = priv

    self:setRows(14)
    self:setColumns(2)

    priv.subframes[ParameterType.PDmg] = private.newParameterFrame(self, ParameterType.PDmg, 1, 1)
    priv.subframes[ParameterType.ASpd] = private.newParameterFrame(self, ParameterType.ASpd, 1, 2)
    priv.subframes[ParameterType.Armor] = private.newParameterFrame(self, ParameterType.Armor, 1, 3)
    priv.subframes[ParameterType.PDmgReduc] = private.newParameterFrame(self, ParameterType.PDmgReduc, 1, 4)

    priv.subframes[ParameterType.MDmg] = private.newParameterFrame(self, ParameterType.MDmg, 2, 1)
    priv.subframes[ParameterType.CSpd] = private.newParameterFrame(self, ParameterType.CSpd, 2, 2)
    priv.subframes[ParameterType.Resist] = private.newParameterFrame(self, ParameterType.Resist, 2, 3)
    priv.subframes[ParameterType.MDmgReduc] = private.newParameterFrame(self, ParameterType.MDmgReduc, 2, 4)

    priv.subframes[ParameterType.Health] = private.newParameterFrame(self, ParameterType.Health, 1, 6)
    priv.subframes[ParameterType.Regen] = private.newParameterFrame(self, ParameterType.Regen, 1, 7)
    priv.subframes[ParameterType.Mana] = private.newParameterFrame(self, ParameterType.Mana, 2, 6)
    priv.subframes[ParameterType.Recov] = private.newParameterFrame(self, ParameterType.Recov, 2, 7)

    priv.subframes[ParameterType.CritCh] = private.newParameterFrame(self, ParameterType.CritCh, 1, 9)
    priv.subframes[ParameterType.CritDmg] = private.newParameterFrame(self, ParameterType.CritDmg, 1, 10)
    priv.subframes[ParameterType.Dodge] = private.newParameterFrame(self, ParameterType.Dodge, 2, 9)
    priv.subframes[ParameterType.CdReduc] = private.newParameterFrame(self, ParameterType.CdReduc, 2, 10)

    priv.subframes[ParameterType.Str] = private.newParameterFrame(self, ParameterType.Str, 1, 12)
    priv.subframes[ParameterType.Agi] = private.newParameterFrame(self, ParameterType.Agi, 1, 13)
    priv.subframes[ParameterType.Int] = private.newParameterFrame(self, ParameterType.Int, 1, 14)
    priv.subframes[ParameterType.MS] = private.newParameterFrame(self, ParameterType.MS, 2, 14)

    return priv
end

---@param self FrameStatsTable
---@return FrameStatsTablePrivate
function private.get(self)
    return private_data[self]
end

---@param self FrameStatsTable
function private.free(self)
    private_data[self] = nil
end

---@param self FrameStatsTable
---@param param ParameterType
function private.newParameterFrame(self, param, column, row)
    local frame = FrameSpringRow.new(private.createBackgroundHandle())
    local offset = 0.05 * frame:getHeight()
    self:setCell(frame, column, row)
    frame:setColumns(3)
    frame:setOffsets(offset, offset, offset, offset)
    frame:setColumnAbsWidth(frame:getHeight() - 2 * offset, 1)
    frame:setColumnAbsWidth(offset, 2)

    local icon = FrameBackdrop.new()
    icon:setTexture(param:getIcon())
    frame:setCell(icon, 1)

    local value = FrameText.new(0.93 * (self:getHeight()  - 2 * offset))
    value:setText('0')
    frame:setCell(value, 3)

    local hover = FrameHover.new()
    frame:setFollower(hover)

    local tooltip = private.createParameterTooltipFrame(param)
    hover:setTooltip(tooltip)
    tooltip:setParent(hover)
    hover.onPositionChange = function(hover) private.onHoverPositionChange(hover, tooltip) end
    hover.onSizeChange = function(hover) private.onHoverPositionChange(hover, tooltip) end
end

---@param hover FrameHover
---@param tooltip Frame
function private.onHoverPositionChange(hover, tooltip)
    local x = hover:getX()
    local y = hover:getY()
    if x < 0.4 then
        tooltip:setX(hover:getWidth())
    else
        tooltip:setX(-tooltip:getWidth())
    end

    if y < 0.3 then
        tooltip:setY(hover:getHeight())
    else
        tooltip:setY(-tooltip:getHeight())
    end
end

---@return framehandle
function private.createBackgroundHandle()
    return BlzCreateFrame(private.fdf_data[private.fdf_background_name],
                          private.game_ui_handle,
                          0, 0)
end

---@param param ParameterType
---@return FrameTooltip
function private.createParameterTooltipFrame(param)
    local tooltip = FrameTooltip.new()
    tooltip:setWidth(private.tooltip_width)
    tooltip:setIcon(param:getIcon())
    tooltip:setTitle(param:getFullName())
    tooltip:setText(param:getTooltip())
    return tooltip
end

return FrameStatsTable