RegisterOnResourceStart("target", function()
    ---@type table<string, table<string, string> | table<any, table<string, string>>>
    local nameLabelMaps = {
        globalObject = {},
        globalPlayer = {},
        globalVehicle = {},
        model = {},
        entity = {},
    }

    ---Converts options to qb-target format
    ---@param options TargetOption[]
    ---@param nameLabelMap table<string, string> | table<any, table<string, string>> | nil
    ---@param target any
    ---@return table
    local function convertOptions(options, nameLabelMap, target)
        local qbOptions = {
            options = {},
            distance = nil,
        }

        -- Create either a name label map for the target or use the provided one (for global options)
        if nameLabelMap ~= nil and target ~= nil then
            if nameLabelMap[target] == nil then
                ---@type table<string, string>
                nameLabelMap[target] = {}
            end
            nameLabelMap = nameLabelMap[target] --[[@as table<string, string>]]
        end

        for i, option in ipairs(options) do
            qbOptions.options[#qbOptions + 1] = {
                icon = option.icon,
                label = option.label,
                action = function(entity)
                    option.onSelect({ entity = entity })
                end,
                canInteract = function(entity, distance, data)
                    if distance > option.distance then
                        return false
                    end
                    return option.canInteract(entity, distance)
                end,
                job = option.groups,
                gang = option.groups,
            }
            if nameLabelMap ~= nil and option.name then
                ---@cast nameLabelMap table<string, string>
                nameLabelMap[option.name] = option.label
            end
            -- Use the maximum distance of all provided options, if none is found it uses qb-target's default max distance
            if option.distance ~= nil then
                if qbOptions.distance == nil or option.distance > qbOptions.distance then
                    qbOptions.distance = option.distance
                end
            end
        end

        return qbOptions
    end

    ---Converts option names to labels since qb-target uses labels for removal of options
    ---@param optionNames string[]
    ---@param nameLabelMap table<string, string> | table<any, table<string, string>> | nil
    ---@param target any
    ---@return string[]
    local function convertOptionNames(optionNames, nameLabelMap, target)
        local qbOptionNames = {}

        -- Use either a name label map for the target or the provided one (for global options)
        if nameLabelMap ~= nil and target ~= nil then
            nameLabelMap = nameLabelMap[target] --[[@as table<string, string>]]
        end

        if nameLabelMap ~= nil then
            ---@cast nameLabelMap table<string, string>
            for i, name in ipairs(optionNames) do
                qbOptionNames[#qbOptionNames + 1] = nameLabelMap[name]
            end
        end

        return qbOptionNames
    end

    ---@type ClientTargetProvider
    local targetProvider = {
        enableTargeting = function(bool)
            exports["qb-target"]:AllowTargeting(bool)
        end,
        addGlobalObject = function(options)
            exports["qb-target"]:AddGlobalObject(convertOptions(options, nameLabelMaps.globalObject))
        end,
        removeGlobalObject = function(optionNames)
            exports["qb-target"]:RemoveGlobalObject(convertOptionNames(optionNames, nameLabelMaps.globalObject))
        end,
        addGlobalPlayer = function(options)
            exports["qb-target"]:AddGlobalPlayer(convertOptions(options, nameLabelMaps.globalPlayer))
        end,
        removeGlobalPlayer = function(optionNames)
            exports["qb-target"]:RemoveGlobalPlayer(convertOptionNames(optionNames, nameLabelMaps.globalPlayer))
        end,
        addGlobalVehicle = function(options)
            exports["qb-target"]:AddGlobalVehicle(convertOptions(options, nameLabelMaps.globalVehicle))
        end,
        removeGlobalVehicle = function(optionNames)
            exports["qb-target"]:RemoveGlobalVehicle(convertOptionNames(optionNames, nameLabelMaps.globalVehicle))
        end,
        addModel = function(models, options)
            exports["qb-target"]:AddTargetModel(models, convertOptions(options, nameLabelMaps.model))
        end,
        removeModel = function(models, optionNames)
            exports["qb-target"]:RemoveTargetModel(models, convertOptionNames(optionNames, nameLabelMaps.model))
        end,
        -- It seems qb-target makes no distinction between networked and local entities
        addEntity = function(netIds, options)
            exports["qb-target"]:AddTargetEntity(netIds, convertOptions(options, nameLabelMaps.entity))
        end,
        removeEntity = function(netIds, optionNames)
            exports["qb-target"]:AddTargetEntity(netIds, convertOptionNames(optionNames, nameLabelMaps.entity))
        end,
        addLocalEntity = function(entities, options)
            exports["qb-target"]:AddTargetEntity(entities, convertOptions(options, nameLabelMaps.entity))
        end,
        removeLocalEntity = function(entities, optionNames)
            exports["qb-target"]:AddTargetEntity(entities, convertOptionNames(optionNames, nameLabelMaps.entity))
        end,
        addSphereZone = function(parameters)
            exports["qb-target"]:AddCircleZone(
                parameters.name,
                parameters.coords,
                parameters.radius,
                { name = parameters.name, debugPoly = parameters.debug, useZ = true },
                convertOptions(parameters.options)
            )
            return parameters.name
        end,
        addBoxZone = function(parameters)
            -- Calculate min and max z
            local minZ = parameters.coords.z - parameters.size.z / 2
            local maxZ = parameters.coords.z + parameters.size.z / 2

            exports["qb-target"]:AddBoxZone(
                parameters.name,
                parameters.coords,
                parameters.size.x,
                parameters.size.y,
                { name = parameters.name, heading = 0.0, debugPoly = parameters.debug, minZ = minZ, maxZ = maxZ },
                convertOptions(parameters.options)
            )

            return parameters.name
        end,
        addPolyZone = function(parameters)
            -- Calculate min and max z
            local minZ, maxZ
            for i, point in ipairs(parameters.points) do
                if minZ == nil or point.z < minZ then
                    minZ = point.z
                end
                if maxZ == nil or point.z > maxZ then
                    maxZ = point.z
                end
            end
            -- Add thickness
            minZ -= parameters.thickness / 2
            maxZ += parameters.thickness / 2

            exports["qb-target"]:AddPolyZone(parameters.name, parameters.points)
            return parameters.name
        end,
        removeZone = function(name)
            exports.ox_target:removeZone(name)
        end,
    }

    return targetProvider
end, ServicePriority.Lowest, "qb-target")
