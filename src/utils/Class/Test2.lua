local Class = require('utils.Class.Class')

--print(Class.getPackage('E'))
local E = require('utils.Class.Test')

local F = Class.new('F', E)

local f = Class.allocate(F)

print(f.a)
print(f.b)
print(f.e)
print(f.aa)
print(f.bb)
print(f.ee)