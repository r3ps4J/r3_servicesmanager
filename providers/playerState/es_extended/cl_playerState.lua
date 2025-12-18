RegisterOnResourceStart("employment", function()
    local ESX = exports["es_extended"]:getSharedObject()

    local playerLoaded = EventEmitter()

    ---@type ClientPlayerStateProvider
    local playerStateProvider = {
        isPlayerLoaded = ESX.IsPlayerLoaded,
        onPlayerLoaded = function(callback)
            return playerLoaded.subscribe(callback)
        end,
    }

    AddEventHandler("esx:playerLoaded", function()
        playerLoaded.emit()
    end)

    return playerStateProvider
end, ServicePriority.Lowest, "es_extended")
