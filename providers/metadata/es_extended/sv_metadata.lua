RegisterOnResourceStart("metadata", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type ServerMetadataProvider
    local metadataProvider = {
        getPlayerMetadata = function(playerId, key)
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer == nil then
                return nil
            end

            return xPlayer.getMeta(key)
        end,
        setPlayerMetadata = function(playerId, key, value)
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer == nil then
                return false
            end

            xPlayer.setMeta(key, value)
            return true
        end,
    }

    return metadataProvider
end, ServicePriority.Lowest, "es_extended")
