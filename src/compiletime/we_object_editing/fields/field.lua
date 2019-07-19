local WeField = {}

local utils = require('compiletime.we_object_editing.utils')
local WeUnitField = require('compiletime.we_object_editing.fields.unit')

local function data2byte(data, data_type)
	if data_type == 'int' then
		return utils.int2byte(data)
	else if data_type == 'real' or data_type == 'unreal' then
		return utils.float2byte(data)
		end
	end
	return utils.str2byte(data)
end

local function getBytes(var)
    if var == nil then
        return ''
    end
    return var
end

function WeField.new(fields_table, field_name, data)
	local we_type = fields_table.we_type()
	local field_data = fields_table[field_name]
	if we_type == 'unit' then
		field = fields_table[field_name]
		if field == nil then
			print('Unit does not have field', field_name)
			print(utils.getErrorPos())
			return nil
		end
	end
	if we_type == 'ability' then
		field = fields_table[field_name]
		if field == nil then
			print('Ability does not have field', field_name)
			print(utils.getErrorPos())
			return nil
		end
	end

	local data_type_id = 0
	if field.data_type == 'int' then data_type_id = utils.int2byte(0) end
	if field.data_type == 'real' then data_type_id = utils.int2byte(1) end
	if field.data_type == 'unreal' then data_type_id = utils.int2byte(2) end
	if field.data_type == 'string' then data_type_id = utils.int2byte(3) end

    local field_table = {
        id = getBytes(field.id),
		data_type = getBytes(data_type_id),
		lvl = getBytes(field.lvl),
		abil_data_id = getBytes(utils.int2byte(field.abil_data_id)),
		data = getBytes(data2byte(data, field.data_type)),
        we_type = we_type
	}
	setmetatable(field_table, {__index = WeField})
    return field_table
end

function WeField:serialize()
	local str = self.id .. self.data_type .. self.lvl .. self.abil_data_id .. self.data
	return str
end

return WeField