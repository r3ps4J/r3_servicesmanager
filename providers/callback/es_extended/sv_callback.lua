RegisterOnResourceStart("callback", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type ServerCallbackProvider
    local callbackProvider = {
        registerServerCallback = ESX.RegisterServerCallback,
    }

    return callbackProvider
end, ServicePriority.Lowest, "es_extended")
