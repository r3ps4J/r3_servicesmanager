RegisterOnResourceStart("callback", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })

    ---@type ServerCallbackProvider
    local callbackProvider = {
        registerServerCallback = function(name, cb)
            QBCore.Functions.CreateCallback(name, function(source, qbCb, ...)
                local result = cb(source, ... and table.unpack(...))
                qbCb(result)
            end)
        end,
    }

    return callbackProvider
end, ServicePriority.Lowest, "qb-core")
