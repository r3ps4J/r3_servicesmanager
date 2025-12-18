RegisterOnResourceStart("target", function()
    ---@param options TargetOption[]
    ---@return table
    local function convertOptions(options)
        local targetOptions = {}

        for i, option in ipairs(options) do
            targetOptions[#targetOptions + 1] = {
                label = option.label,
                name = option.name,
                icon = option.icon,
                distance = option.distance,
                bones = option.bones,
                groups = option.groups,
                canInteract = option.canInteract,
                onSelect = option.onSelect,
            }
        end

        return targetOptions
    end

    ---@type ClientTargetProvider
    local targetProvider = {
        enableTargeting = function(enabled)
            exports.ox_target:disableTargeting(not enabled)
        end,
        addGlobalObject = function(options)
            exports.ox_target:addGlobalObject(convertOptions(options))
        end,
        removeGlobalObject = function(optionNames)
            exports.ox_target:removeGlobalObject(optionNames)
        end,
        addGlobalPlayer = function(options)
            exports.ox_target:addGlobalPlayer(convertOptions(options))
        end,
        removeGlobalPlayer = function(optionNames)
            exports.ox_target:removeGlobalPlayer(optionNames)
        end,
        addGlobalVehicle = function(options)
            exports.ox_target:addGlobalVehicle(convertOptions(options))
        end,
        removeGlobalVehicle = function(optionNames)
            exports.ox_target:removeGlobalVehicle(optionNames)
        end,
        addModel = function(models, options)
            exports.ox_target:addModel(models, convertOptions(options))
        end,
        removeModel = function(models, optionNames)
            exports.ox_target:removeModel(models, optionNames)
        end,
        addEntity = function(netIds, options)
            exports.ox_target:addEntity(netIds, convertOptions(options))
        end,
        removeEntity = function(netIds, optionNames)
            exports.ox_target:removeEntity(netIds, optionNames)
        end,
        addLocalEntity = function(entities, options)
            exports.ox_target:addLocalEntity(entities, convertOptions(options))
        end,
        removeLocalEntity = function(entities, optionNames)
            exports.ox_target:removeLocalEntity(entities, optionNames)
        end,
        addSphereZone = function(parameters)
            exports.ox_target:addSphereZone({
                coords = parameters.coords,
                name = parameters.name,
                radius = parameters.radius,
                debug = parameters.debug,
                options = convertOptions(parameters.options),
            })
            return parameters.name
        end,
        addBoxZone = function(parameters)
            exports.ox_target:addBoxZone({
                coords = parameters.coords,
                name = parameters.name,
                size = parameters.size,
                debug = parameters.debug,
                options = convertOptions(parameters.options),
            })
            return parameters.name
        end,
        addPolyZone = function(parameters)
            exports.ox_target:addPolyZone({
                points = parameters.points,
                name = parameters.name,
                thickness = parameters.thickness,
                debug = parameters.debug,
                options = convertOptions(parameters.options),
            })
            return parameters.name
        end,
        removeZone = function(name)
            exports.ox_target:removeZone(name)
        end,
    }

    return targetProvider
end, ServicePriority.Lowest, "ox_target")
