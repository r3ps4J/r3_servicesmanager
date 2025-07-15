RegisterOnResourceStart("callback", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })

    ---@type ClientCallbackProvider
    local callbackProvider = {
        triggerServerCallback = QBCore.Functions.TriggerCallback,
        awaitServerCallback = function(name, ...)
            local p = promise.new()
            QBCore.Functions.TriggerCallback(name, function(result)
                p:resolve(result)
            end, table.unpack(...))
            return Citizen.Await(p)
        end,
    }

    return callbackProvider
end, ServicePriority.Lowest, "qb-core")
