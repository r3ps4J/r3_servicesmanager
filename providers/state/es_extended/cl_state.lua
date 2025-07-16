RegisterOnResourceStart("employment", function()
    local ESX = exports["es_extended"]:getSharedObject()

    local playerLoaded = EventEmitter()

    ---@type ClientStateProvider
    local stateProvider = {
        isPlayerLoaded = ESX.IsPlayerLoaded,
        onPlayerLoaded = function(callback)
            return playerLoaded.subscribe(callback)
        end,
    }

    AddEventHandler("esx:playerLoaded", function()
        playerLoaded.emit()
    end)

    return stateProvider
end, ServicePriority.Lowest, "es_extended")
