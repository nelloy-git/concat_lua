--[[
    ClassAPI.new(name, parents)
    Создание нового класса. Для созданного класса доступны для редактирования
    только поля public, static и override. Для скрытия полей public и override рекомендуется
    возвращать из области do-end поле static полученного класса.
    name : string - имя нового класса.
    parents : vararg - список родителей класса в порядке приоритетности.
    return table

    ClassAPI.allocate(class)
    Создание инстанса класса.
    class : table - класс созданный с помощью функции ClassAPI.new.
    return table

    ClassAPI.isClass(var)
    Проверяет является ли переменная классом.
    var : any
    return boolean

    ClassAPI.isInstance(var)
    Проверяет является ли переменная инстансом любого класса.
    var : any
    return boolean

    ClassAPI.getClass(instance)
    Возвращает класс инстанса.
    instance : table - инстанс класса созданный с помощью ClassAPI.allocate.
    return table

    ClassAPI.isChild(class1, class2)
    Проверяет является ли класс наследником.
    class1 : table - класс созданный с помощью функции ClassAPI.new.
    class2 : table - класс созданный с помощью функции ClassAPI.new.
    return boolean

    ClassAPI.getPublic(static)
    Позволяет получить поле public того же класса. Необходимо для реализации виртуальных функций.
    static : table - поле класса "static"
    return table - поле класс "public"

    ClassAPI.getOverride(static)
    Позволяет получить поле override того же класса. Необходимо для реализации статических
    виртуальных функций.
    static : table - поле класса "static"
    return table - поле класс "override"

    ClassAPI.type = ClassDeclare.type
]]

do
    ClassAPI = {}

    local ClassStatic = {}
    local class2static = {}
    local static2class = {}

    local ClassPublic = {}
    local class2public = {}
    local public2class = {}

    local ClassParent = {}
    local class2parents_list = {}
    local class2parents = {}

    local ClassOverride = {}
    local override2class = {}
    local override2static = {}
    local class2override = {}

    local ClassName = {}
    local class2name = {}
    local name2class = {}

    local ClassInstance = {}
    local instance2class = {}
    setmetatable(instance2class, {__mode = 'kv'})

    local ClassDeclare = {}

    local rawget = rawget
    local rawset = rawset
    local fmt = string.format
    local type = type

    local function deepcopy(orig, copies)
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

    local function isInList(elem, list)
        for i = 1, #list do
            if elem == list[i] then 
                return true
            end
        end
        return false
    end
    
    ---@param class table
    function ClassParent.register(class, ...)
        local vararg = {...}
    
        local parents_list = {}
        for i = 1, #vararg do
            vararg[i] = ClassStatic.getClass(vararg[i]) or vararg[i]
            if not ClassName.isClass(vararg[i]) then
                error(fmt('%d-th parent is not class', i), 3)
            end
    
            if not isInList(vararg[i], parents_list) then
                table.insert(parents_list, vararg[i])
            end
    
            local vararg_parents = class2parents_list[vararg[i]]
            for j = 1, #vararg_parents do
                if not isInList(vararg_parents[j], parents_list) then
                    table.insert(parents_list, vararg_parents[j])
                end
            end
        end
    
        local parents = {}
        for i = 1, #parents_list do
            parents[parents_list[i]] = true
        end
    
        class2parents_list[class] = parents_list
        class2parents[class] = parents
    end
    
    ---@param class table
    ---@return table[]
    function ClassParent.getList(class)
        return class2parents_list[class]
    end
    
    ---@param child table
    ---@param parent table
    ---@return boolean
    function ClassParent.isChild(child, parent)
        return child == parent or class2parents[child][parent] or false
    end

    local static_meta = {
        __index = function(self, key)
            local parents = ClassParent.getList(static2class[self])
            for i = 1, #parents do
                local cur = class2static[parents[i]]
                local value = rawget(cur, key)
                if value then
                    return value
                end
            end
            error(fmt(tostring(self)..': static field \'%s\' does not exist.', key), 2)
        end,

        __newindex = function(self, key, value)
            local parents = ClassParent.getList(static2class[self])
            for i = 1, #parents do
                local cur = class2static[parents[i]]
                if rawget(cur, key) then
                    rawset(cur, key, value)
                    return
                end
            end
            rawset(self, key, value)
        end,

        __tostring = function(self)
            return tostring(static2class[self])
        end,

        __pairs = function(self)
            local class = static2class[self]
            local parents = ClassParent.getList(class)

            local k, v
            local cur_pos = 0
            local cur_table = self
            local list = {}
            local function getKeyValue()
                k, v = next(cur_table, k)
                if k ~= nil then
                    if list[k] ~= nil then
                        getKeyValue()
                    end

                    if k ~= nil then
                        list[k] = v
                    end

                    return k, v
                else
                    cur_pos = cur_pos + 1
                    if cur_pos > #parents then
                        return
                    end

                    cur_table = class2static[parents[cur_pos]]
                    return getKeyValue()
                end
            end

            return getKeyValue
        end
    }

    ---@param class table
    ---@return table
    function ClassStatic.register(class)
        local static = {}
        setmetatable(static, static_meta)

        class2static[class] = static
        static2class[static] = class
        return static
    end

    ---@param class table
    ---@return table
    function ClassStatic.getStatic(class)
        return class2static[class]
    end

    ---@param static table
    ---@return table
    function ClassStatic.getClass(static)
        return static2class[static]
    end

    local NIL = '__RESERVED__'

    local public_meta = {
        __newindex = function(self, key, value)
            if value == nil then
                value = NIL
            end
            rawset(self, key, value)
        end,

        __tostring = function(self)
            return tostring(public2class[self])
        end,

        __pairs = function(self)
            local class = public2class[self]
            local parents = ClassParent.getList(class)

            local k, v
            local cur_pos = 0
            local cur_table = self
            local list = {}
            local function getKeyValue()
                k, v = next(cur_table, k)
                if k ~= nil then
                    if list[k] ~= nil then
                        getKeyValue()
                    end

                    if k ~= nil then
                        list[k] = v
                    end

                    return k, v
                else
                    cur_pos = cur_pos + 1
                    if cur_pos > #parents then
                        return
                    end

                    cur_table = class2public[parents[cur_pos]]
                    return getKeyValue()
                end
            end

            return getKeyValue
        end
    }

    ---@param class table
    ---@return table
    function ClassPublic.register(class)
        local public = {}
        setmetatable(public, public_meta)

        class2public[class] = public
        public2class[public] = class
        return public
    end

    ---@param class table
    ---@return table
    function ClassPublic.get(class)
        class = ClassStatic.getClass(class) or class
        return class2public[class]
    end
    
    local override_meta = {
        __index = function(self, key)
            rawget(override2static[self], key)
        end,
    
        __newindex = function(self, key, value)
            rawset(override2static[self], key, value)
        end,
    
        __tostring = function(self)
            return tostring(override2class[self])
        end
    }
    
    function ClassOverride.register(class)
        local override = {}
        setmetatable(override, override_meta)
    
        override2class[override] = class
        override2static[override] = ClassStatic.getStatic(class)
        class2override[class] = override
        return override
    end
    
    ---@param class table
    ---@return table
    function ClassOverride.get(class)
        class = ClassStatic.getClass(class) or class
        return class2override[class]
    end
    
    ---@param class table
    ---@param name string
    function ClassName.register(class, name)
        if name2class[name] then
            error('Class name must be unique.', 3)
        end
    
        class2name[class] = name
        name2class[name] = class
    end
    
    ---@param class table
    ---@return string
    function ClassName.getName(class)
        return class2name[class]
    end
    
    ---@param name string
    ---@return table
    function ClassName.getClass(name)
        return name2class[name]
    end
    
    ---@param any any
    ---@return boolean
    function ClassName.isClass(any)
        if class2name[any] then
            return true
        end
        return false
    end
    
    local instance_metatable
    instance_metatable = {
        __index = function(self, key)
            error(fmt('%s: public field \'%s\' does not exist.', self, key), 2)
        end,
    
        __newindex = function(self, key, value)
            error(fmt('%s: public field \'%s\' does not exist.', self, key), 2)
        end,
    
        __tostring = function(self)
            setmetatable(self, nil)
            local def = tostring(self)
            setmetatable(self, instance_metatable)
            local class = instance2class[self]
            return ClassName.getName(class)..'_'..string.sub(def, 10)
        end,
    }
    
    ---@param class table
    ---@return table
    function ClassInstance.allocate(class)
        local instance = {}
        local parents = ClassParent.getList(class)
    
        --for i = 1, #parents do
        --    local cur = parents[#parents + 1 - i]
        --    local cur_public = ClassPublic.get(cur)
        --    local copy = deepcopy(cur_public)
        --    for k,v in pairs(copy) do
        --        instance[k] = v
        --    end
        --end
    
        local public = ClassPublic.get(class)
        local copy = deepcopy(public)
        for k,v in pairs(public) do
            instance[k] = v
        end
    
        setmetatable(instance, instance_metatable)
        instance2class[instance] = class
        return instance
    end
    
    ---@param instance table
    ---@rettrn table
    function ClassInstance.getClass(instance)
        return instance2class[instance]
    end
    
    
    ---@param instance table
    ---@rettrn boolean
    function ClassInstance.isInstance(instance)
        if instance2class[instance] then
            return true
        end
        return false
    end

    local class_metatable = {
        __index = function(self, key)
            error('static, override, public are allowed only.', 2)
        end,
    
        __newindex = function(self, key)
            error('static, override, public are allowed only.', 2)
        end,
    
        __tostring = ClassName.getName
    }
    
    ---@param name string
    ---@return any
    function ClassDeclare.register(name, ...)
        if type(name) ~= 'string' then
            error('class name can be string only.', 2)
        end
    
        local class = {}
        ClassName.register(class, name)
        ClassParent.register(class, ...)
        class.static = ClassStatic.register(class)
        class.public = ClassPublic.register(class)
        class.override = ClassOverride.register(class)
    
        setmetatable(class, class_metatable)
        return class
    end
    
    ---@param value1 any
    ---@param value2 any
    ---@return boolean
    ---@overload fun(value:any):string
    ---@overload fun(child_class:any, parent_class:any):boolean
    ---@overload fun(child_instance:any, parent_class:any):boolean
    ---@overload fun(child_instance:any, parent_instance:any):boolean
    function ClassDeclare.type(value1, value2)
        if not value2 then
            if ClassName.isClass(value1) or ClassInstance.isInstance(value1) then
                return ClassName.getName(ClassStatic.getClass(value1) or value1)
            end
            return type(value1)
        end
    
        local is_class1 = ClassName.isClass(ClassStatic.getClass(value1) or value1)
        local is_class2 = ClassName.isClass(ClassStatic.getClass(value2) or value2)
        local is_instance1 = ClassInstance.isInstance(value1)
        local is_instance2 = ClassInstance.isInstance(value2)
    
        if not (is_class1 or is_class2 or is_instance1 or is_instance2) then
            return type(value1) == value2
        end
    
        if (is_class1 or is_instance1) ~= (is_class2 or is_instance2) then
            return false
        end
    
        local class1 = ClassStatic.getClass(value1) or value1
        local class2 = ClassStatic.getClass(value2) or value2
    
        if is_instance1 then
            class1 = ClassInstance.getClass(value1)
        end
    
        if is_instance2 then
            class2 = ClassInstance.getClass(value2)
        end

        return ClassParent.isChild(class1, class2)
    end

    ClassAPI.new = ClassDeclare.register
    ClassAPI.allocate = ClassInstance.allocate
    ClassAPI.isClass = ClassName.isClass
    ClassAPI.isInstance = ClassInstance.isInstance
    ClassAPI.getClass = ClassInstance.getClass
    ClassAPI.isChild = ClassParent.isChild
    ClassAPI.getPublic = ClassPublic.get
    ClassAPI.getOverride = ClassOverride.get
    ClassAPI.type = ClassDeclare.type
end