require('Libs.Lib')

---@type ObjectLib
local ObjectLib = require(LibList.Object)
if not IsCompiletime() then
    GTimer = ObjectLib.SmartTimer.new(0.03125)
end