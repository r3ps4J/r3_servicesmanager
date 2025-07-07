RegisterOnResourceStart("economy", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })

    ---@type table<AccountType, string>
    local accounts = {
        cash = "cash",
        bank = "bank",
    }

    ---@type ServerEconomyProvider
    local economyProvider = {
        getPlayerBalance = function(playerId, account)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if not Player then
                return
            end

            return Player.Functions.GetMoney(accounts[account])
        end,
        setPlayerBalance = function(playerId, account, amount)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if not Player then
                return false
            end

            return Player.Functions.SetMoney(accounts[account], amount)
        end,
        addPlayerBalance = function(playerId, account, amount)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if not Player then
                return false
            end

            return Player.Functions.AddMoney(accounts[account], amount)
        end,
        removePlayerBalance = function(playerId, account, amount)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if not Player then
                return false
            end

            return Player.Functions.RemoveMoney(accounts[account], amount)
        end,
        playerHasBalance = function(playerId, account, amount)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if not Player then
                return false
            end

            return Player.Functions.GetMoney(accounts[account]) >= amount
        end,
    }

    return economyProvider
end, ServicePriority.Lowest, "qb-core")
