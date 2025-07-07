RegisterOnResourceStart("identity", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type ServerIdentityProvider
    local identityProvider = {
        getPlayerIdentifier = function(playerId)
            local xPlayer = ESX.GetPlayerFromId(playerId)

            if xPlayer == nil then
                return nil
            end

            return xPlayer.getIdentifier()
        end,
        getPlayerName = function(playerId)
            local xPlayer = ESX.GetPlayerFromId(playerId)

            if xPlayer == nil then
                return nil
            end

            return xPlayer.getName()
        end,
    }

    return identityProvider
end, ServicePriority.Lowest, "es_extended")
