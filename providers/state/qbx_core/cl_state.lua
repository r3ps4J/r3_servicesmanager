local isPlayerLoaded = false

AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    isPlayerLoaded = true
end)

RegisterNetEvent("qbx_core:client:playerLoggedOut", function()
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
end, ServicePriority.Low, "qbx_core")
