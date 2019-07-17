local Field = {}

function Field.new(id, data, var_type)
	local var_type_id = 0
	if var_type == 'int' then var_type_id = utils.int2byte(0) end
	if var_type == 'real' then var_type_id = utils.int2byte(1) end
	if var_type == 'unreal' then var_type_id = utils.int2byte(2) end
	if var_type == 'string' then var_type_id = utils.int2byte(3) end
    local t = {
        id = id,
		data = data,
		var_type = var_type_id,
        we_type = 'unit'
    }
    return t
end

return Field