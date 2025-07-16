local isPlayerLoaded = false

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    isPlayerLoaded = true
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnloaded", function()
    isPlayerLoaded = false
end)

RegisterOnResourceStart("state", function()
    local playerLoaded = EventEmitter()

    ---@type ClientStateProvider
    local stateProvider = {
        isPlayerLoaded = function()
            return isPlayerLoaded
        end,
        onPlayerLoaded = function(callback)
            return playerLoaded.subscribe(callback)
        end,
    }

    RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
        playerLoaded.emit()
    end)

    return stateProvider
end, ServicePriority.Lowest, "qb-core")
