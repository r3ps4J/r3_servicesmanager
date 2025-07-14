RegisterOnResourceStart("metadata", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type ServerMetadataProvider
    local metadataProvider = {
        getPlayerMetadata = function(playerId, key)
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer == nil then
                return nil
            end

            return xPlayer.get(key)
        end,
        setPlayerMetadata = function(playerId, key, value)
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer == nil then
                return false
            end

            return xPlayer.set(key, value)
        end,
    }

    return metadataProvider
end, ServicePriority.Lowest, "es_extended")
