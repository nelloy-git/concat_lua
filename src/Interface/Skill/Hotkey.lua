--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local FdfNormalImage = FrameLib.Fdf.Normal.Backdrop or error('')
local NormalImage = FrameLib.Normal.Image or error('')
local NormalImagePublic = Class.getPublic(NormalImage) or error('')
local SimpleText = FrameLib.Simple.Text or error('')
---@type InputLib
local InputLib = require(LibList.InputLib) or error('')
local addKeyboardAction = InputLib.addKeyboardAction or error('')
local removeKeyboardAction = InputLib.removeKeyboardAction or error('')
---@type TypesLib
local TypesLib = require(LibList.TypesLib) or error('')
local FrameEvemt = TypesLib.FrameEventTypeEnum
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

--=======
-- Class
--=======

local InterfaceSkillHotkey = Class.new('InterfaceSkillHotkey', NormalImage)
---@class InterfaceSkillHotkey : FrameNormalImage
local public = InterfaceSkillHotkey.public
---@class InterfaceSkillHotkeyClass : FrameNormalImageClass
local static = InterfaceSkillHotkey.static
---@type InterfaceSkillHotkeyClass
local override = InterfaceSkillHotkey.override
local private = {}

--=========
-- Static
--=========

---@return InterfaceSkillHotkey
function override.new(child)
    if child then isTypeErr(child, InterfaceSkillHotkey, 'child') end

    local instance = child or Class.allocate(InterfaceSkillHotkey)
    instance = NormalImage.new(private.fdf, instance)

    private.newData(instance)

    return instance
end

--========
-- Public
--========

---@param width number
---@param height number
function public:setSize(width, height)
    NormalImagePublic.setSize(self, width, height)
    local priv = private.data[self]

    priv.text:setSize(width, height)
    priv.text:setFont('fonts\\nim_____.ttf', 0.8 * height)
end

---@param key string
---@param abil AbilityExt
---@param is_fast boolean
function public:setHotkey(key, abil, is_fast)
    local priv = private.data[self]

    priv.key = key
    priv.text:setText(key)
    priv.abil = abil
    priv.is_fast = is_fast
    if priv.action then
        removeKeyboardAction(priv.action)
    end
    priv.action = addKeyboardAction(key, function(key, is_down, pl)
        private.keyPressedCallback(self, key, is_down, pl)
    end)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self InterfaceSkillHotkey
function private.newData(self)
    local priv = {
        key = nil,
        abil = nil,
        is_fast = false,
        action = nil,

        text = SimpleText.new(),
    }
    private.data[self] = priv

    priv.text:setParent(self)

    self:setSize(self:getWidth(), self:getHeight())
end

---@param self InterfaceSkillHotkey
---@param key string
---@param is_down boolean
function private.keyPressedCallback(self, key, is_down, pl)
    local priv = private.data[self]
    if pl ~= GetLocalPlayer() or not self:isVisible() then
        return
    end

    if priv.key ~= key then
        Log:err(tostring(self)..': called with wrong key.')
    end

    if not priv.abil then
        return
    end

    if priv.is_fast then
        if priv.abil:isTargeting() and not is_down then
            priv.abil:targetingFinish()
        elseif not priv.abil:isTargeting() and is_down then
            priv.abil:targetingStart()
        end
    else
        if is_down then
            if priv.abil:isTargeting() then
                priv.abil:targetingFinish()
            else
                priv.abil:targetingStart()
            end
        end
    end
end

private.fdf = FdfNormalImage.new('InterfaceSkillHotkey')
private.fdf:setWidth(0.01)
private.fdf:setHeight(0.01)
private.fdf:setBackground('Replaceabletextures\\Teamcolor\\Teamcolor27.blp')
private.fdf:setBlendAll(true)
private.fdf:setInsets(0, 0, 0, 0)
private.fdf:setCornerFlags('UL|UR|BL|BR|T|L|B|R')
private.fdf:setCornerSize(0.00125)
private.fdf:setEdgeFile('UI\\Widgets\\ToolTips\\Human\\human-tooltip-border')

return static