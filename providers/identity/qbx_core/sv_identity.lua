RegisterOnResourceStart("identity", function()
    ---@type ServerIdentityProvider
    local identityProvider = {
        getPlayerIdentifier = function(playerId)
            local player = exports.qbx_core:GetPlayer(playerId)

            if player == nil then
                return nil
            end

            return player.PlayerData.citizenid
        end,
        getPlayerName = function(playerId)
            local player = exports.qbx_core:GetPlayer(playerId)

            if player == nil then
                return nil
            end

            return ("%s %s"):format(player.PlayerData.charinfo.firstname, player.PlayerData.charinfo.lastname)
        end,
    }

    return identityProvider
end, ServicePriority.Low, "qbx_core")
