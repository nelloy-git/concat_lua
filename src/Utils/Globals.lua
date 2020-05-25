require('Libs.Libs')

require(Lib.Parameter)

---@type ObjectLib
local ObjectLib = require(Lib.Object)
if not IsCompiletime() then
    glTimer = ObjectLib.SmartTimer.new(0.03125)
end