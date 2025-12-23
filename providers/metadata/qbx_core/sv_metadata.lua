RegisterOnResourceStart("metadata", function()
    ---@type ServerMetadataProvider
    local metadataProvider = {
        getPlayerMetadata = function(playerId, key)
            return exports.qbx_core:GetMetadata(playerId, key)
        end,
        setPlayerMetadata = function(playerId, key, value)
            local player = exports.qbx_core:GetPlayer(playerId)
            if player == nil then
                return false
            end

            exports.qbx_core:SetMetadata(playerId, key, value)
            return true
        end,
    }

    return metadataProvider
end, ServicePriority.Low, "qbx_core")
