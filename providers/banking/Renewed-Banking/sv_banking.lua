RegisterOnResourceStart("banking", function()
    ---@type ServerBankingProvider
    local bankingProvider = {
        getAccountBalance = function(account)
            return exports["Renewed-Banking"]:getAccountMoney(account)
        end,
        addAccountBalance = function(account, amount)
            return exports["Renewed-Banking"]:addAccountMoney(account, amount)
        end,
        removeAccountBalance = function(account, amount)
            return exports["Renewed-Banking"]:removeAccountMoney(account, amount)
        end,
        accountHasBalance = function(account, amount)
            return exports["Renewed-Banking"]:getAccountMoney(account) >= amount
        end,
    }

    return bankingProvider
end, ServicePriority.Low, "Renewed-Banking")
