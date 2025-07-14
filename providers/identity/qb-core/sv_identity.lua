RegisterOnResourceStart("identity", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })

    ---@type ServerIdentityProvider
    local identityProvider = {
        getPlayerIdentifier = function(playerId)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if Player == nil then
                return nil
            end

            return Player.PlayerData.citizenid
        end,
        getPlayerName = function(playerId)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if Player == nil then
                return nil
            end

            return ("%s %s"):format(Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname)
        end,
    }

    return identityProvider
end, ServicePriority.Lowest, "qb-core")
