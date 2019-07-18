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

function WeField.new(field_name, we_type, data)
	local field = nil
	if we_type == 'unit' then
		field = WeUnitField[field_name]
		if field == nil then
			print('Unit does not have field', field_name)
			print(utils.getErrorPos())
			return nil
		end
	end

	local data_type_id = 0
	if field.data_type == 'int' then data_type_id = utils.int2byte(0) end
	if field.data_type == 'real' then data_type_id = utils.int2byte(1) end
	if field.data_type == 'unreal' then data_type_id = utils.int2byte(2) end
	if field.data_type == 'string' then data_type_id = utils.int2byte(3) end

    local t = {
        id = field.id,
		data = data2byte(data, field.data_type),
		var_type = data_type_id,
        we_type = we_type
    }
    return t
end

return WeField