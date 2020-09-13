--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type HandleLib
local HandleLib = lib_dep.Handle or error('')
local Frame = HandleLib.Frame
---@type UtilsLib
local UtilsLib = lib_dep.Utils or error('')
local isTypeErr = UtilsLib.isTypeErr or error('')
local Log = UtilsLib.Log or error('')

---@type FdfBaseClass
local FdfBase = require(lib_path..'Fdf.Base')

--========
-- Module
--========

---@class FrameUtils
local FrameUtils = {}

local console_ui_backdrop
if not IsCompiletime() then
    console_ui_backdrop = BlzGetFrameByName("ConsoleUIBackdrop", 0)
end

---@param fdf FdfBase
---@param child Frame
---@return Frame
function FrameUtils.newFrameFromFdf(fdf, child)
    isTypeErr(fdf, FdfBase, 'fdf')
    isTypeErr(child, Frame, 'child')

    local handle
    if fdf:isSimple() then
        handle = BlzCreateSimpleFrame(fdf:getName(), nil, 0)
        local test_handle = BlzCreateSimpleFrame('', nil, 0)
        if tostring(handle) == tostring(test_handle) then
            Log:err('Can not create framehandle', 2)
        end
    else
        handle = BlzCreateFrame(fdf:getName(), console_ui_backdrop, 0, 0)
        local test_handle = BlzCreateSimpleFrame('', console_ui_backdrop, 0, 0)
        if tostring(handle) == tostring(test_handle) then
            Log:err('Can not create framehandle', 2)
        end
    end

    return Frame.new(handle, fdf:isSimple(), child)
end

return FrameUtils