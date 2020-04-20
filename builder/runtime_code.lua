package_files = {}
do
    local is_compiletime = false

    function IsCompiletime()
        return is_compiletime
    end

    local loaded_packages = {}
    local loading_packages = {}
    function require(package_name)
        if loading_packages[package_name] then
            print('Recursive require detected.')
            return nil
        end

        if not loaded_packages[package_name] then
            loading_packages[package_name] = true
            loaded_packages[package_name] = package_files[package_name]() or true
            loading_packages[package_name] = nil
        end
        return loaded_packages[package_name]
    end

    function CompiletimeFinalToRuntime(func)
        return func()
    end
end