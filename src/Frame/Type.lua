--=========
-- Include
--=========

local Log = require('Utils.Log')
local Class = require('Utils.Class.Class')
local fmt = string.format

---@type CompiletimeDataClass
local CompiletimeData = require('Utils.CompiletimeData')

--=======
-- Class
--=======

local FrameType = Class.new('FrameType')
---@class FrameType
local public = FrameType.public
---@class FrameTypeClass
local static = FrameType.static
local override = FrameType.override
local private = {}

--=========
-- Static
--=========

---@param uniq_name string
---@param create_fdf fun(name:string):FdfObject
---@param separate_file boolean
---@param child_instance FrameType
---@return FrameType
function override.new(uniq_name, create_fdf, separate_file, child_instance)
    if IsCompiletime() and private.compiletime_data:get(uniq_name) then
        Log.error(FrameType, '\"uniq_name\" must be unique.', 2)
    end

    if type(create_fdf) ~= 'function' then
        Log.error(FrameType, '\"create_fdf\" must be function.', 2)
    end

    if type(separate_file) ~= 'boolean' then
        Log.error(FrameType, '\"separate_file\" must be boolean.', 2)
    end

    if not Class.type(child_instance, FrameType) then
        Log.error(FrameType, '\"child_instance\" must be FrameType.', 2)
    end

    local instance = child_instance
    private.newData(instance, uniq_name, create_fdf, separate_file)

    return instance
end

---@param uniq_name string
---@return boolean
function static.isExist(uniq_name)
    if not IsCompiletime() then
        return false
    end
    if private.compiletime_data:get(uniq_name) then
        return true
    end
    return false
end

--========
-- Public
--========

---@return string
function public:getName()
    return private.data[self].name
end

---@return FdfObject
function public:getFdf()
    return private.data[self].fdf
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.compiletime_data = CompiletimeData.new(FrameType)

local _ = Compiletime(function()
    ---@type FdfEdit
    private.FdfEdit = require('compiletime.FdfEdit')
    private.FdfFile = private.FdfEdit.File
end)

---@param self FrameType
---@param uniq_name string
---@param create_fdf function
---@param separate_file boolean
function private.newData(self, uniq_name, create_fdf, separate_file)
    local priv = {
        name = uniq_name
    }
    private.data[self] = priv

    if IsCompiletime() then
        priv.fdf = create_fdf(uniq_name)
    end

    if separate_file then
        if IsCompiletime() then
            local file = private.FdfFile.new(uniq_name)
            file:addObject(priv.fdf)
            private.compiletime_data:set(uniq_name, file:toRuntime().toc)
        else
            local toc = private.compiletime_data:get(uniq_name)

            if not toc then
                Log.error(self, 'can not find toc file path.', 3)
            end

            if not BlzLoadTOCFile(toc) then
                Log.error(self, 'error in toc file loading.', 3)
            end
        end
    end
end


return static