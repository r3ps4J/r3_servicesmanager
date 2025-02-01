RegisterOnResourceStart("economy", function()
    ---@type table<AccountType, string>
    local accounts = {
        cash = "cash",
        bank = "bank",
    }

    ---@type ServerEconomyProvider
    local economyProvider = {
        getPlayerBalance = function(playerId, account)
            return exports.qbx_core:GetMoney(playerId, accounts[account])
        end,
        setPlayerBalance = function(playerId, account, amount)
            return exports.qbx_core:SetMoney(playerId, accounts[account], amount)
        end,
        addPlayerBalance = function(playerId, account, amount)
            return exports.qbx_core:AddMoney(playerId, accounts[account], amount)
        end,
        removePlayerBalance = function(playerId, account, amount)
            return exports.qbx_core:RemoveMoney(playerId, accounts[account], amount)
        end,
        playerHasBalance = function(playerId, account, amount)
            return exports.qbx_core:GetMoney(playerId, accounts[account]) >= amount
        end,
    }

    return economyProvider
end, ServicePriority.Lowest, "qbx_core")
