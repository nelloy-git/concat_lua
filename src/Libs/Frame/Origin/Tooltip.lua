--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame or error('')
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local Log = UtilsLib.Log or error('')

--========
-- Module
--========

if IsCompiletime() then
    return
end

local handle = BlzGetOriginFrame(ORIGIN_FRAME_UBERTOOLTIP, 0)
BlzFrameClearAllPoints(handle)

---@class FrameOriginTooltip
local Tooltip = Frame.link(handle, false)
Tooltip:setParent(nil)

---@param width number
---@param height number
function Tooltip:setSize(width, height)
    Log:wrn('Tooltip size can not be changed.')
end

return Tooltip