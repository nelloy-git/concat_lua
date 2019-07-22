local WeField = {}

local utils = require(CurrentLib..'.utils')

local function data2byte(data, data_type)
	if data_type == 'bool' then
		if data == true then
			return utils.int2byte(1)
		else
			return utils.int2byte(0)
		end
	if data_type == 'int' then
		return utils.int2byte(data)
	end
	else if data_type == 'real' or data_type == 'unreal' then
		return utils.float2byte(data)
		end
	end
	return utils.str2byte(data)
end

local function type2bytes(data_type)
	if data_type == 'bool' then return utils.int2byte(0) end
	if data_type == 'int' then return utils.int2byte(0) end
	if data_type == 'real' then return utils.int2byte(1) end
	if data_type == 'unreal' then return utils.int2byte(2) end
	if data_type == 'string' then return utils.int2byte(3) end
end

local function getBytes(var)
    if var == nil then
        return ''
    end
    return var
end

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

function WeField:serialize()
	local str = self.id .. self.data_type .. self.lvl .. self.abil_data_id .. self.data
	return str
end

return WeField