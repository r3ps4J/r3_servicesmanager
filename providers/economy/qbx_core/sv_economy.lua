RegisterOnResourceStart("economy", function()
    ---@type table<AccountType, string>
    local accounts = {
        cash = "cash",
        bank = "bank",
    }

    ---@type ServerEconomyProvider
    local economyProvider = {
        getPlayerBalance = function(playerId, account)
            local player = exports.qbx_core:GetPlayer(playerId)
            if player == nil then
                return nil
            end
            return player.Functions.GetMoney(accounts[account])
        end,
        setPlayerBalance = function(playerId, account, amount)
            local player = exports.qbx_core:GetPlayer(playerId)
            if player == nil then
                return false
            end
            return player.Functions.SetMoney(accounts[account], amount)
        end,
        addPlayerBalance = function(playerId, account, amount)
            local player = exports.qbx_core:GetPlayer(playerId)
            if player == nil then
                return false
            end
            return player.Functions.AddMoney(accounts[account], amount)
        end,
        removePlayerBalance = function(playerId, account, amount)
            local player = exports.qbx_core:GetPlayer(playerId)
            if player == nil then
                return false
            end
            return player.Functions.RemoveMoney(accounts[account], amount)
        end,
        playerHasBalance = function(playerId, account, amount)
            local player = exports.qbx_core:GetPlayer(playerId)
            if player == nil then
                return false
            end
            return player.Functions.GetMoney(accounts[account]) >= amount
        end,
    }

    return economyProvider
end, ServicePriority.Low, "qbx_core")
