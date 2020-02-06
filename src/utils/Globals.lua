local Globals = {}

Log = require('utils.Log')
--require('utils.Class.Class')

local savety_run_enable = true
---@param func fun
function savetyRun(func, ...)
    if savety_run_enable then
        local success, result = pcall(func, ...)
        if success then
            return result
        else
            Log.error('savetyRun', result, 2)
            return nil
        end
    else
        return func(...)
    end
end

---Converts integer or string id to integer.
---@param id integer|string
---@return integer|nil
function ID(id)
    if type(id) == 'string' then
        return string.unpack(">I4", id)
    elseif type(id) == 'number' and math.fmod(id, 1) == 0 then
        return id
    end
    Log(Log.Err, "ID function", string.format("got %s", id))
    return nil
end

---Converts integer id to string id.
---@param id integer
---@return string
function ID2str(id)
    if type(id) == 'number' or type(id) == 'integer' then
        return string.pack(">I4", id)
    elseif type(id) == 'string' and string.len(id) == 4 then
        return id
    end
    Log(Log.Err, "ID2str function", string.format("got %s", id))
    return nil
end

---@param orig any
---@param copies any
---@return any
function deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = _G.type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            setmetatable(copy, deepcopy(getmetatable(orig), copies))
            for orig_key, orig_value in next, orig, nil do
                copy[deepcopy(orig_key, copies)] = deepcopy(orig_value, copies)
            end
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
