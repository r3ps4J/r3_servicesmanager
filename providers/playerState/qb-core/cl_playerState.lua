local isPlayerLoaded = false

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    isPlayerLoaded = true
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnloaded", function()
    isPlayerLoaded = false
end)

RegisterOnResourceStart("playerState", function()
    local playerLoaded = EventEmitter()

    ---@type ClientPlayerStateProvider
    local playerStateProvider = {
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

    return playerStateProvider
end, ServicePriority.Lowest, "qb-core")
