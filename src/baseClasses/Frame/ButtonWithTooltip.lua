---@class FrameButtonWithTooltip
local ButtonWithTooltip = {
    __type = "TooltipButtonClass"
}

local ButtonWithTooltip_meta = {
    __type = "TooltipButton",
    __index = ButtonWithTooltip
}

local initialized = false
function ButtonWithTooltip.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\TooltipButton\\TooltipButton.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end

    initialized = true
end

function ButtonWithTooltip.new()
    local btn_img = BlzCreateFrameByType("BACKDROP", "ButtonImage", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "", 0)
    local btn_hover = BlzCreateFrameByType("FRAME", "ButtonHover", btn_img, "", 0)
    local tooltip = BlzCreateFrame("ItemInfo", btn_img, 0, 0)
    local tooltip_title = BlzGetFrameByName("ItemInfoTitle", 0)
    local tooltip_main_icon = BlzGetFrameByName("ItemInfoMainIcon", 0)
    local tooltip_text = BlzGetFrameByName("ItemInfoText", 0)
    local tooltip_slot_icon = {
        [1] = BlzGetFrameByName("ItemInfoSlotIcon1", 0),
        [2] = BlzGetFrameByName("ItemInfoSlotIcon2", 0),
        [3] = BlzGetFrameByName("ItemInfoSlotIcon3", 0),
        [4] = BlzGetFrameByName("ItemInfoSlotIcon4", 0),
        [5] = BlzGetFrameByName("ItemInfoSlotIcon5", 0),
    }

    BlzFrameSetTexture(btn_img, "ReplaceableTextures\\CommandButtons\\BTNBelt.blp", 0, true)
    BlzFrameSetAllPoints(btn_hover, btn_img)    -- btn_hover copies size and position of btn_img.
    BlzFrameSetTooltip(btn_hover, tooltip)  -- when btn_hover is hovered with the mouse frame tooltip becomes visible.
    BlzFrameSetPoint(tooltip, FRAMEPOINT_TOPLEFT, btn_img, FRAMEPOINT_TOPRIGHT, 0, 0)   -- set position of tooltip.

    BlzFrameSetSize(btn_img, 0.04, 0.04)
    BlzFrameSetAbsPoint(btn_img, FRAMEPOINT_CENTER, 0.4, 0.3)
    BlzFrameSetSize(tooltip, 0.15, 0.08)

    BlzFrameSetText(tooltip_title, "No title")
    BlzFrameSetText(tooltip_text, "No text")

    local frame = {
        __btn_img = btn_img,
        __btn_hover = btn_hover,
        __tooltip = tooltip,
        __tooltip_title = tooltip_title,
        __tooltip_main_icon = tooltip_main_icon,
        __tooltip_text = tooltip_text,
        __tooltip_slot_icon = tooltip_slot_icon,
    }
    setmetatable(frame, ButtonWithTooltip_meta)

    return frame
end

---@param pos Vec2
function ButtonWithTooltip:setPosition(pos)
    self.__pos = pos
    if pos.x >= 0.4 and pos.y >= 0.3 then
        self:moveTooltipBottomLeft()
    elseif pos.x >= 0.4 and pos.y < 0.3 then
        self:moveTooltipTopLeft()
    elseif pos.x < 0.4 and pos.y >=0.3 then
        self:moveTooltipBottomRight()
    else
        self:moveTooltipTopRight()
    end
    --BlzFrameSetAbsPoint(self.__btn_img, FRAMEPOINT_TOPLEFT, 0.4, 0.3)
    BlzFrameSetAbsPoint(self.__btn_img, FRAMEPOINT_CENTER, pos.x, pos.y)
end

---@param width number
---@param height number
function ButtonWithTooltip:setButtonSize(width, height)
    self.__btn_width = width
    self.__btn_height = height
    BlzFrameSetSize(self.__btn_img, width, height)
end

---@param width number
---@param height number
function ButtonWithTooltip:setTooltipSize(width, height)
    BlzFrameSetSize(self.__tooltip, width, height)
end

function ButtonWithTooltip:moveTooltipTopLeft()
    BlzFrameClearAllPoints(self.__tooltip)
    BlzFrameSetPoint(self.__tooltip, FRAMEPOINT_BOTTOMRIGHT, self.__btn_img, FRAMEPOINT_BOTTOMLEFT, 0, 0)
end

function ButtonWithTooltip:moveTooltipTopRight()
    BlzFrameClearAllPoints(self.__tooltip)
    BlzFrameSetPoint(self.__tooltip, FRAMEPOINT_BOTTOMLEFT, self.__btn_img, FRAMEPOINT_BOTTOMRIGHT, 0, 0)
end

function ButtonWithTooltip:moveTooltipBottomLeft()
    BlzFrameClearAllPoints(self.__tooltip)
    BlzFrameSetPoint(self.__tooltip, FRAMEPOINT_TOPRIGHT, self.__btn_img, FRAMEPOINT_TOPLEFT, 0, 0)
end

function ButtonWithTooltip:moveTooltipBottomRight()
    BlzFrameClearAllPoints(self.__tooltip)
    BlzFrameSetPoint(self.__tooltip, FRAMEPOINT_TOPLEFT, self.__btn_img, FRAMEPOINT_TOPRIGHT, 0, 0)
end

return ButtonWithTooltip