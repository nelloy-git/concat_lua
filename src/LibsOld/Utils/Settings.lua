--=========
-- Include
--=========

local lib_path = Lib.curPath()
local lib_dep = Lib.curDepencies()

---@type LoggerClass
local Logger = require(lib_path..'Logger') or error('')

--=======
-- Module
--========

---@class UtilsSettings
local Settings = {}

local debug = true
function Settings.isDebug()
    return debug
end
Settings.default_logger = Logger.new(true, true, true,
                                     true, true, true, true,
                                     'log.txt', 'log.txt')

return Settings