RegisterOnResourceStart("metadata", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })

    ---@type ServerMetadataProvider
    local metadataProvider = {
        getPlayerMetadata = function(playerId, key)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if Player == nil then
                return nil
            end

            return Player.Functions.GetMetaData(key)
        end,
        setPlayerMetadata = function(playerId, key, value)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if Player == nil then
                return false
            end

            Player.Functions.SetMetaData(key, value)
            return true
        end,
    }

    return metadataProvider
end, ServicePriority.Lowest, "qb-core")
