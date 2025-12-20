RegisterOnResourceStart("callback", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type ServerCallbackProvider
    local callbackProvider = {
        registerServerCallback = function(name, cb)
            ESX.RegisterServerCallback(name, function(src, esxCb, ...)
                local result = cb(src, ... and table.unpack(...))
                esxCb(result)
            end)
        end,
    }

    return callbackProvider
end, ServicePriority.Lowest, "es_extended")
