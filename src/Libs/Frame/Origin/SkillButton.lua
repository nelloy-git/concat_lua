--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

local Class = lib_dep.Class
---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame or error('')
local FramePublic = Class.getPublic(Frame) or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Log = UtilsLib.Log or error('')

--========
-- Module
--========

if IsCompiletime() then
    return
end

local SkillButton = {}

for i = 0, 11 do
    local handle = BlzGetFrameByName("CommandButton_"..tonumber(i), 0)
    BlzFrameClearAllPoints(handle)

    ---@class FrameOriginSkillButton
    local btn = Frame.link(handle, false)
    SkillButton[i + 1] = btn
    btn:setParent(nil)

    ---@param x number
    ---@param y number
    function btn:setPos(x, y)
        local parent = self:getParent()

        local p_abs_x = parent and parent:getAbsX() or 0
        local p_abs_y = parent and parent:getAbsY() or 0

        local abs_x = p_abs_x + x
        local abs_y = p_abs_y + y

        if (abs_x < 0) or (abs_x + self:getWidth() > 0.8) or
           (abs_y < 0) or (abs_y + self:getHeight() > 0.6) then
            Log:wrn('CommandButton can not be moved correctly outside of [[0, 0], [0.8, 0.6]] rectangle because of cooldown sprite.')
        end

        FramePublic.setPos(self, x, y)
    end

    ---@param width number
    ---@param height number
    function btn:setSize(width, height)
        FramePublic.setSize(self, width, height)
        Log:wrn('CommandButton can not be resized correctly because of cooldown sprite.')
    end

    function btn:addAction(event, callback)
        Log:wrn('CommandButton can not activate events.')
    end
end

return SkillButton