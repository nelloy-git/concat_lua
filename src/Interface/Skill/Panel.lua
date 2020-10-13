--=========
-- Include
--=========

local Class = require(LibList.ClassLib) or error('')
---@type AbilityLib
local AbilLib = require(LibList.AbilityExtLib) or error('')
local AbilContainer = AbilLib.Container or error('')
local AbilEvent = AbilLib.Event or error('')
---@type FrameLib
local FrameLib = require(LibList.FrameLib) or error('')
local Image = FrameLib.Normal.Image or error('')
local ImagePublic = Class.getPublic(Image) or error('')
local OriginTooltip = FrameLib.Origin.Tooltip or error('')
local SimpleBar = FrameLib.Simple.StatusBar or error('')
---@type TypesLib
local TypesLib = require(LibList.TypesLib) or error('')
local FrameEvent = TypesLib.FrameEventTypeEnum
---@type UtilsLib
local UtilsLib = require(LibList.UtilsLib) or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type InterfaceSkillButtonClass
local SkillButton = require('Interface.Skill.Button') or error('')


--=======
-- Class
--=======

local InterfaceSkillPanel = Class.new('InterfaceSkillPanel', Image)
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
    instance = Image.new(nil, instance)

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
    ImagePublic.setSize(self, width, height)
    private.updatePos(self)
end

---@param container AbilityExtContainer
function public:setAbilContainer(container)
    if container then isTypeErr(container, AbilContainer, 'container') end
    local priv = private.data[self]

    local abil_list = container and container:getAll() or {}

    for i = 1, priv.max_abils do
        ---@type AbilityExt
        local abil = abil_list[i]

        if abil then
            priv.buttons[i]:setTexture(abil:getIcon(), '')
            priv.buttons[i]:setButtonAlpha(1)
            priv.buttons[i]:setCharges(abil:getCurrentChargesLeft(),
                                       abil:getCurrentChargesMax())
            priv.buttons[i]:setCooldown(abil:getCurrentCooldownLeft(),
                                        abil:getCurrentCooldownFull())

            if (priv.fast_cast) then
                -- TODO fast cast
            else
                priv.buttons[i]:addAction(FrameEvent.MOUSE_CLICK, function() abil:targetingStart() end)
                -- TODO
            end
        else
            priv.buttons[i]:setButtonAlpha(0)
            priv.buttons[i]:setCharges(0, 0)
        end
    end
    --[[
    local priv = private.data[self]

    local previous = priv.container
    if previous then
        private.container2interface[previous] = nil
        if not previous:removeAction(priv.changed_action) then
            Log:err(tostring(InterfaceSkillPanel)..': сan clear previous AbilityExtContainer', 2)
        end
    end

    priv.container = container
    if container then
        private.container2interface[container] = self
        priv.changed_action = container:addAction(AbilEvent.CHARGES_CHANGED, private.chargesChanged)
        priv.start_action = container:addAction(AbilEvent.CASTING_START, private.castingStart)
        priv.loop_action = 0
        priv.end_action = 0
    end

    for i = 1, #private.hotkeys do
        local abil = container:get(private.hotkeys[i])
        if abil and IsUnitAlly(container:getOwner():getData(), GetLocalPlayer()) then
            priv.buttons[i]:setCharges(abil:getCharges(), abil:getMaxCharges())
        else
            priv.buttons[i]:setCharges(0, 0)
        end
    end
    --]]
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.container2interface = setmetatable({}, {__mode = 'kv'})

---@param self InterfaceSkillPanel
---@param max_abils number
function private.newData(self, max_abils)
    local priv = {
        fast_cast = false,
        max_abils = max_abils,
        per_line = 10,

        buttons = {},
        --tooltip = OriginTooltip,
        --cast_bar = SimpleBar.new()
    }
    private.data[self] = priv
    self:setAlpha(0)

    for i = 1, max_abils do
        local btn = SkillButton.new()
        btn:setParent(self)
        btn:setAlpha(1)

        priv.buttons[i] = btn
    end

    --priv.cast_bar:setBar('Replaceabletextures\\Teamcolor\\Teamcolor16.blp')
    --priv.cast_bar:setSize(self:getWidth(), priv.buttons[1]:getHeight() / 4)
    --priv.cast_bar:setPos(self:getAbsX(), self:getAbsY())
    --priv.cast_bar:setVisible(false)

    --priv.tooltip:setParent(self)
    -- Native bind with bottom center point
    --BlzFrameSetPoint(priv.tooltip:getData(), FRAMEPOINT_BOTTOM,
    --                 self:getData(), FRAMEPOINT_TOP, 0, 0)
    --priv.tooltip:setVisible(true)

    private.updatePos(self)
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

function private.updatePos(self)
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

        priv.buttons[i]:setPos((p - 1) * w, self:getHeight() - l * h)
        priv.buttons[i]:setSize(w, h)
    end
end

return static