--=========
-- Include
--=========

local Class = require('Utils.Class')

local FrameBackdrop = require('Class.Frame.Default.FrameBackdrop')
local FrameText = require('Class.Frame.Default.FrameText')
local FrameSpringColumn = require('Class.Frame.Container.FrameSpringColumn')
local FrameSpringRow = require('Class.Frame.Container.FrameSpringRow')

--=======
-- Class
--=======

---@class FrameTooltipClass : FrameSpringColumnClass
local FrameTooltip = Class.newClass('FrameTooltip', FrameSpringColumn)

---@class FrameTooltip : FrameSpringColumn
local public = FrameTooltip.public
---@type FrameTooltipClass
local static = FrameTooltip.static
---@type table
local override = FrameTooltip.override
---@type table(FrameTooltip, table)
local private = {}

--=========
-- Static
--=========

---@param instance_data table | nil
---@return FrameTooltip
function override.new(instance_data)
    local instance = instance_data or Class.newInstanceData(FrameTooltip)
    instance = FrameSpringColumn.new(private.createHandle(), instance)
    local priv = private.new(instance)

    return instance
end

static.title_height = 0.04
static.space = 0.003

--========
-- Public
--========

function public:free()
    private.free(self)
    FrameSpringColumn.public.free(self)
end

---@param path string
function public:setIcon(path)
    local priv = private.get(self)

    priv.icon:setTexture(path)
    if path then
        priv.first:setColumnAbsWidth(priv.first:getHeight() - 2 * static.space, 1)
        priv.first:setColumnAbsWidth(static.space, 2)
    else
        priv.first:setColumnAbsWidth(0, 1)
        priv.first:setColumnAbsWidth(0, 2)
    end
end

---@param title string
function public:setTitle(title)
    local priv = private.get(self)

    priv.title:setText(title)
end

--- Do not use "\n" in text string.
---@param text string
function public:setText(text)
    local lines = private.split(text, private.getLineLength(self))
    for i = 1, #lines do
        self:addTooltipLine(lines[i])
    end
end

function public:addTooltipLine(line)
    local priv = private.get(self)

    priv.lines = priv.lines + 1
    priv.tooltip:addText(line..'\n')
    self:setHeight(priv.first:getHeight() + priv.second:getHeight() + priv.lines * 0.0093 + 4 * static.space)
end

--=========
-- Private
--=========

local private_data = {}
---@param self FrameTooltip
---@return FrameTooltipPrivate
function private.new(self)
    ---@class FrameTooltipPrivate
    local priv = {
        first = FrameSpringRow.new(private.createHandle()),
        second = FrameSpringRow.new(nil),
        third = FrameSpringRow.new(nil),

        icon = FrameBackdrop.new(),
        title = FrameText.new(0.012),
        slots = {},

        lines = 0,
        tooltip = FrameText.new(0.010)
    }
    private_data[self] = priv

    self:setRows(3)
    self:setCell(priv.third, 1)
    self:setCell(priv.second, 2)
    self:setRowAbsHeight(0, 2)
    self:setCell(priv.first, 3)
    self:setRowAbsHeight(static.title_height, 3)

    priv.first:setColumns(3)
    priv.first:setColumnAbsWidth(0, 1)
    priv.first:setOffsets(static.space, static.space, static.space, static.space)
    priv.first:setCell(priv.icon, 1)
    priv.first:setColumnAbsWidth(static.space, 2)
    priv.first:setCell(priv.title, 3)

    priv.third:setOffsets(3 * static.space, 3 * static.space, static.space, 3 * static.space)
    priv.third:setCell(priv.tooltip, 1)

    return priv
end

---@param self FrameTooltip
---@return FrameTooltipPrivate
function private.get(self)
    return private_data[self]
end

---@param self FrameTooltip
function private.free(self)
    private_data[self] = nil
end

---@return framehandle
function private.createHandle()
    return BlzCreateFrame(private.fdf_data[private.fdf_background_name],
                          private.game_ui_handle,
                          0, 0)
end

local font10_size_per_char = 0.0005
---@param self FrameTooltip
function private.getLineLength(self)
    return self:getWidth() / font10_size_per_char
end

---@param str string
---@param max_line_length number
---@return string[]
function private.split(str, max_line_length)
    local lines = {}
    local line
    str:gsub('(%s*)(%S+)', 
       function(spc, word) 
          if not line or #line + #spc + #word > max_line_length then
             table.insert(lines, line)
             line = word
          else
             line = line..spc..word
          end
       end
    )
    table.insert(lines, line)
    return lines
 end

private.fdf_background_name = 'FrameTooltipBackground'
private.fdf_data = compiletime(function()
    local WeObjEdit = require('compiletime.ObjectEdit.ObjEdit')
    local File = WeObjEdit.Fdf.File
    local Backdrop = WeObjEdit.Fdf.Backdrop

    local background = Backdrop.new(private.fdf_background_name)
    background:setField(Backdrop.DecorateFileNames)
    background:setField(Backdrop.TileBackground)
    background:setField(Backdrop.Background, "ToolTipBackground")
    background:setField(Backdrop.CornerFlags, "UL|UR|BL|BR|T|L|B|R")
    background:setField(Backdrop.CornerSize, 0.008)
    background:setField(Backdrop.BackgroundInsets, {0.0022, 0.0022, 0.0022, 0.0022})
    background:setField(Backdrop.EdgeFile, "ToolTipBorder")
    background:setField(Backdrop.BlendAll)

    local out = File.new(FrameTooltip)
    out:addObject(background)
    return out:toRuntime()
end)

if not is_compiletime then
    private.game_ui_handle = BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
    if not BlzLoadTOCFile(private.fdf_data.toc) then
        Log(Log.Err, FrameTooltip, "can not load toc file.")
    end
end



return FrameTooltip