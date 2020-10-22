--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type AbilityLib
local AbilLib = require(LibList.AbilityExtLib) or error('')
local AbilContainer = AbilLib.Container or error('')
--local AbilEvent = AbilLib.Event or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local FdfNormalImage = FrameLib.Fdf.Normal.Backdrop or error('')
local NormalImage = FrameLib.Normal.Image or error('')
local NormalImagePublic = Class.getPublic(NormalImage) or error('')
---@type InputLib
local InputLib = require(LibList.InputLib) or error('')
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type InterfaceSkillButtonClass
local SkillButton = require('Interface.Skill.Button') or error('')
---@type InterfaceSkillHotkeyClass
local SkillHotkey = require('Interface.Skill.Hotkey') or error('')

--=======
-- Class
--=======

local InterfaceSkillPanel = Class.new('InterfaceSkillPanel', NormalImage)
---@class InterfaceSkillPanel : FrameNormalImage
local public = InterfaceSkillPanel.public
---@class InterfaceSkillPanelClass : FrameNormalImageClass
local static = InterfaceSkillPanel.static
---@type InterfaceSkillPanelClass
local override = InterfaceSkillPanel.override
local private = {}

--=========
-- Static
--=========

local static_instance = nil

---@param max_abils number
---@return InterfaceSkillPanel
function override.new(max_abils)
    isTypeErr(max_abils, 'number', 'max_abils')
    if static_instance then
        Log:wrn(tostring(InterfaceSkillPanel)..': can not get new instance. It is static class.')
        return static_instance
    end

    local instance = Class.allocate(InterfaceSkillPanel)
    instance = NormalImage.new(nil, instance)

    private.newData(instance, max_abils)

    static_instance = instance
    return instance
end

--========
-- Public
--========

---@param width number
---@param height number
function public:setSize(width, height)
    NormalImagePublic.setSize(self, width, height)
    private.updateSize(self)
end

---@param container AbilityExtContainer
function public:setAbilContainer(container)
    if container then isTypeErr(container, AbilContainer, 'container') end
    local priv = private.data[self]

    local abil_list = container and container:getAll() or {}

    for i = 1, priv.max_abils do
        ---@type AbilityExt
        local abil = abil_list[i]
        priv.buttons[i]:setAbility(abil)

        if i <= 9 then
            priv.hotkeys[i]:setHotkey(tostring(i), abil, true)
        end
    end
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.button2panel = setmetatable({}, {__mode = 'kv'})
private.container2interface = setmetatable({}, {__mode = 'kv'})

---@param self InterfaceSkillPanel
---@param max_abils number
function private.newData(self, max_abils)
    local priv = {
        fast_cast = false,
        max_abils = max_abils,
        per_line = 10,

        backgrouds = {},
        buttons = {},
        hotkeys = {},
    }
    private.data[self] = priv

    for i = 1, max_abils do
        local back = NormalImage.new(private.fdf)
        back:setParent(self)
        priv.backgrouds[i] = back

        local btn = SkillButton.new()
        btn:setParent(back)
        btn:setVisible(false)
        priv.buttons[i] = btn

        local hotkey = SkillHotkey.new()
        hotkey:setParent(back)
        hotkey:setVisible(true)
        priv.hotkeys[i] = hotkey
    end

    private.updateSize(self)
end

---@param height number
---@param max_frames number
---@param per_line number
---@return number
function private.getLineHeight(height, max_frames, per_line)
    local i, f = math.modf(max_frames / per_line)
    if f ~= 0 then i = i + 1 end
    return height / i
end

function private.updateSize(self)
    local priv = private.data[self]

    local count = #priv.buttons
    local w = self:getWidth() / priv.per_line
    local h = private.getLineHeight(self:getHeight(),
                                    priv.max_abils, priv.per_line)

    local p = 0
    local l = 1
    for i = 1, count do
        p = p + 1
        if p > priv.per_line then
            p = 1
            l = l + 1
        end

        local x = (p - 1) * w
        local y = self:getHeight() - l * h

        priv.backgrouds[i]:setPos(x, y)
        priv.backgrouds[i]:setSize(w, h)

        priv.buttons[i]:setPos(0.1 * w, 0.1 * h)
        priv.buttons[i]:setSize(0.8 * w, 0.8 * h)

        priv.hotkeys[i]:setSize(0.3 * w, 0.25 * h)
    end
end

private.fdf = FdfNormalImage.new('InterfaceSkillPanel')
private.fdf:setWidth(0.01)
private.fdf:setHeight(0.01)
private.fdf:setBackgroundTileMode(true)
private.fdf:setBackgroundTileSize(0.2)
private.fdf:setBackground('UI\\Widgets\\ToolTips\\Human\\human-tooltip-background')
private.fdf:setBlendAll(true)
private.fdf:setInsets(0.01, 0.01, 0.01, 0.01)
private.fdf:setCornerFlags('UL|UR|BL|BR|T|L|B|R')
private.fdf:setCornerSize(0.0125)
private.fdf:setEdgeFile('UI\\Widgets\\ToolTips\\Human\\human-tooltip-border')

return static