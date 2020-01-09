local Class = require('utils.Class.Class')

local A = Class.new('A')
print('\n')
local B = Class.new('B')
print('\n')
local C = Class.new('C', A)
print('\n')
local D = Class.new('D', B, A)
print('\n')
local E = Class.new('E', D, C)
print('\n')

A.static.a = nil
B.static.a = 'bbb'