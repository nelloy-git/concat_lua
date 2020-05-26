require('Libs.Lib')

require(LibList.Parameter)
require(LibList.Ability)

---@type ObjectLib
local ObjectLib = require(LibList.Object)
if not IsCompiletime() then
    glTimer = ObjectLib.SmartTimer.new(0.03125)
end