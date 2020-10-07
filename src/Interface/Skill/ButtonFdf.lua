--=========
-- Include
--=========

---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local FdfBackdrop = FrameLib.Fdf.Normal.Backdrop or error('')
local FdfGlueTextButton = FrameLib.Fdf.Normal.GlueTextButton or error('')
local FdfHighlight = FrameLib.Fdf.Normal.Highlight or error('')
local FdfText = FrameLib.Fdf.Normal.Text or error('')

--==========
-- Settings
--==========

local default_texture = ''
local default_highlight = 'UI\\Glues\\ScoreScreen\\scorescreen-tab-hilight.blp'
local font = 'fonts\\nim_____.ttf'
local font_size = 0.014

--========
-- Module
--========

---@class InterfaceSkillButtonFdf
local InterfaceSkillButtonFdf = {}

local background = FdfBackdrop.new('InterfaceSkillButtonBackground')
background:setWidth(0.04)
background:setHeight(0.04)
background:setBackgroundTileMode(true)
background:setBackgroundTileSize(0.2)
background:setBackground('UI\\Widgets\\ToolTips\\Human\\human-tooltip-background')
background:setBlendAll(true)
background:setInsets(0.005, 0.005, 0.005, 0.005)
background:setCornerFlags('UL|UR|BL|BR|T|L|B|R')
background:setCornerSize(0.0125)
background:setEdgeFile('UI\\Widgets\\ToolTips\\Human\\human-tooltip-border')

local button = FdfGlueTextButton.new('InterfaceSkillButton')
button:setWidth(0.04)
button:setHeight(0.04)
button:setControlStyle(true, false, true)

local img_normal = button:getControlNormal()
img_normal:setBackground(default_texture)

local img_disabled = button:getControlDisabled()
img_disabled:setBackground(default_texture)

local img_pushed = button:getControlPushed()
img_pushed:setBackground(default_texture)
-- TODO color

local highlight = button:getControlMouse()
highlight:setHighlightType('FILETEXTURE')
highlight:setAlphaFile(default_highlight)
highlight:setAlphaMode('ADD')

---@type FdfGlueTextButton
InterfaceSkillButtonFdf.button = button
---@type FdfBackdrop
InterfaceSkillButtonFdf.main = background

return InterfaceSkillButtonFdf