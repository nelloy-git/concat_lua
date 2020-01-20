--=========
-- Include
--=========

local Log = require('utils.Log')
local Class = require('utils.Class.Class')

--=======
-- Class
--=======

local CompileDataBase = Class.new('DataBase')
---@class CompileDataBase
local public = CompileDataBase.public
---@class CompileDataBaseClass
local static = CompileDataBase.static
---@type CompileDataBaseClass
local override = CompileDataBase.override
local private = {}

--========
-- Static
--========

function static.new(name, child_instance)

---@param uniq_id number
---@param data any
function static.save(uniq_id, data)
    private.newData(uniq_id, data)
end

function static.load(uniq_id)
    return private.data[uniq_id]
end

--========
-- Public
--========

--=========
-- Private
--=========

private.data = {}
AddCompileFinal(function()
    private.data = Compiletime(private.data)
end)

---@param uniq_id number
---@param data any
function private.newData(uniq_id, data)
    if IsCompiletime() then
        if private.data[uniq_id] then
            Log.error(CompileDataBase, 'id is not unique.', 3)
        end
        private.data[uniq_id] = data
    end
end


return static