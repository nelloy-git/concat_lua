---@class AssetLib
local AssetLibAPI = {}
Lib.start('AssetLib', {})
local path = Lib.curPath()

--=====
-- API
--=====

-- TODO exclude unused data

---@type AssetIconDefault
AssetLibAPI.IconDefault = require(path..'IconDefault')

Lib.finish()

return AssetLibAPI