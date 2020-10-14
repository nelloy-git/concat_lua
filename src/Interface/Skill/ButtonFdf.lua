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
local InterfaceSkillButtonFdf = FdfGlueTextButton.new('InterfaceSkillButton')

InterfaceSkillButtonFdf:setWidth(0.04)
InterfaceSkillButtonFdf:setHeight(0.04)
InterfaceSkillButtonFdf:setControlStyle(true, false, true)

local img_normal = InterfaceSkillButtonFdf:getControlNormal()
img_normal:setBackground(default_texture)

local img_disabled = InterfaceSkillButtonFdf:getControlDisabled()
img_disabled:setBackground(default_texture)

local img_pushed = InterfaceSkillButtonFdf:getControlPushed()
img_pushed:setBackground(default_texture)
-- TODO color

local highlight = InterfaceSkillButtonFdf:getControlMouse()
highlight:setHighlightType('FILETEXTURE')
highlight:setAlphaFile(default_highlight)
highlight:setAlphaMode('ADD')

return InterfaceSkillButtonFdf