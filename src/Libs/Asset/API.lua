---@class AssetLib
local AssetLibAPI = {}
Lib.start('AssetLib', {
    Utils = Lib.load(LibList.UtilsLib) or error('')
})
local path = Lib.curPath()

--=====
-- API
--=====

---@type AssetLoader
AssetLibAPI.Loader = require(path..'Loader')

---@type AssetIconDefault
AssetLibAPI.IconDefault = {}
AssetLibAPI.Loader.load(path..'IconDefault', AssetLibAPI.IconDefault)

Lib.finish()

return AssetLibAPI