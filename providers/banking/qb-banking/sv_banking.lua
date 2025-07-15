RegisterOnResourceStart("banking", function()
    ---@type ServerBankingProvider
    local bankingProvider = {
        getAccountBalance = function(account)
            return exports["qb-banking"]:GetAccountBalance(account)
        end,
        addAccountBalance = function(account, amount)
            return exports["qb-banking"]:AddMoney(account, amount)
        end,
        removeAccountBalance = function(account, amount)
            return exports["qb-banking"]:RemoveMoney(account, amount)
        end,
        accountHasBalance = function(account, amount)
            return exports["qb-banking"]:GetAccountBalance(account) >= amount
        end,
    }

    return bankingProvider
end, ServicePriority.Low, "qb-banking")
