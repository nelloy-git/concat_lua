local data = {}

local data_a
function data.set(val)
    data_a = val
end

AddCompileFinal(function()
    data.a = Compiletime(data_a)
end)

return data