RegisterOnResourceStart("economy", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type table<AccountType, string>
    local accounts = {
        cash = "money",
        bank = "bank",
    }

    ---@type ServerEconomyProvider
    local economyProvider = {
        getPlayerBalance = function(playerId, account)
            local xPlayer = ESX.GetPlayerFromId(playerId)

            if xPlayer == nil then
                return nil
            end

            return xPlayer.getAccount(accounts[account]).money
        end,
        setPlayerBalance = function(playerId, account, amount)
            local xPlayer = ESX.GetPlayerFromId(playerId)

            if xPlayer == nil then
                return false
            end

            xPlayer.setAccountMoney(accounts[account], amount)

            return true
        end,
        addPlayerBalance = function(playerId, account, amount)
            local xPlayer = ESX.GetPlayerFromId(playerId)

            if xPlayer == nil then
                return false
            end

            xPlayer.addAccountMoney(accounts[account], amount)

            return true
        end,
        removePlayerBalance = function(playerId, account, amount)
            local xPlayer = ESX.GetPlayerFromId(playerId)

            if xPlayer == nil then
                return false
            end

            if xPlayer.getAccount(accounts[account]).money < amount then
                return false
            end

            xPlayer.removeAccountMoney(accounts[account], amount)

            return true
        end,
        playerHasBalance = function(playerId, account, amount)
            local xPlayer = ESX.GetPlayerFromId(playerId)

            if xPlayer == nil then
                return false
            end

            return xPlayer.getAccount(accounts[account]).money >= amount
        end,
    }

    return economyProvider
end, ServicePriority.Lowest, "es_extended")
