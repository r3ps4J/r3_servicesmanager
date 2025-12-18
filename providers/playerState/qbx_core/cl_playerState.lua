local isPlayerLoaded = false

AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    isPlayerLoaded = true
end)

RegisterNetEvent("qbx_core:client:playerLoggedOut", function()
    isPlayerLoaded = false
end)

RegisterOnResourceStart("state", function()
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
end, ServicePriority.Low, "qbx_core")
