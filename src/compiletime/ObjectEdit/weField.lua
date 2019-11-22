---@type WeUtils
local utils = require('compiletime.objEdit.weUtils')

---Object modification container
---@class WeField2
local WeField = {}

---@class bytes : string

---data_type = 'bool'|'int'|'real'|'unreal'|'string'
---@param data boolean|integer|number|string
---@param data_type string
---@return bytes|nil
local function data2byte(data, data_type)
	if data_type == 'bool' then
		if data == true then
			return utils.int2byte(1)
		else
			return utils.int2byte(0)
		end
	elseif data_type == 'int' then
		return utils.int2byte(data)
	elseif data_type == 'real' or data_type == 'unreal' then
		return utils.float2byte(data)
	elseif data_type == 'string' then
		return utils.str2byte(data)
	else
		print('Wrong data type')
		print(utils.getErrorPos())
		return nil
	end
end

---data type = 'bool'|'int'|'real'|'unreal'|'string'
---@param data_type string
---@return bytes
local function type2bytes(data_type)
	if data_type == 'bool' then return utils.int2byte(0) end
	if data_type == 'int' then return utils.int2byte(0) end
	if data_type == 'real' then return utils.int2byte(1) end
	if data_type == 'unreal' then return utils.int2byte(2) end
	if data_type == 'string' then return utils.int2byte(3) end
end

---@param var bytes
---@return bytes
local function getBytes(var)
    if var == nil then
        return ''
    end
    return var
end

---data type = 'bool'|'int'|'real'|'unreal'|'string'
---@param id string
---@param data_type string
---@param lvl_or_variation integer|nil
---@param abil_data_id integer|nil
---@param data string|boolean|integer|number
---@return WeField
function WeField.new(id, data_type, lvl_or_variation, abil_data_id, data)
	if lvl_or_variation ~= nil then
		lvl_or_variation = utils.int2byte(lvl_or_variation)
	end

	if abil_data_id ~= nil then
		abil_data_id = utils.int2byte(abil_data_id)
	end

    local field_table = {
        id = id,
		data_type = type2bytes(data_type),
		lvl = getBytes(lvl_or_variation),
		abil_data_id = getBytes(abil_data_id),
		data = getBytes(data2byte(data, data_type)),
	}
	setmetatable(field_table, {__index = WeField})
    return field_table
end

---@return bytes
function WeField:serialize()
	local str = self.id .. self.data_type .. self.lvl .. self.abil_data_id .. self.data
	return str
end

return WeField