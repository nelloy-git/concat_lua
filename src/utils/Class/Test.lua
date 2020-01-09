local Class = require('utils.Class.Class')

local A = Class.new('A')
A.public.a = 'a'
A.protected.aa = 'aa'

local B = Class.new('B')
B.public.b = 'b'
A.protected.bb = 'bb'

local C = Class.new('C', A)

local D = Class.new('D', B, A)

local E = Class.new('E', D, C)
E.public.e = 'e'
E.protected.ee = 'ee'

local e = Class.allocate(E)


return E