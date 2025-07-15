RegisterOnResourceStart("callback", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type ClientCallbackProvider
    local callbackProvider = {
        triggerServerCallback = ESX.TriggerServerCallback,
        awaitServerCallback = function(name, ...)
            local p = promise.new()
            ESX.TriggerServerCallback(name, function(result)
                p:resolve(result)
            end, table.unpack(...))
            return Citizen.Await(p)
        end,
    }

    return callbackProvider
end, ServicePriority.Lowest, "es_extended")
