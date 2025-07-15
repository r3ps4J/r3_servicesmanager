RegisterOnResourceStart("callback", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })

    ---@type ServerCallbackProvider
    local callbackProvider = {
        registerServerCallback = QBCore.Functions.CreateCallback,
    }

    return callbackProvider
end, ServicePriority.Lowest, "qb-core")
