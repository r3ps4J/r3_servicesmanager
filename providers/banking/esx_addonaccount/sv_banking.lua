RegisterOnResourceStart("banking", function()
    ---@type ServerBankingProvider
    local bankingProvider = {
        getAccountBalance = function(account)
            local p = promise.new()
            TriggerEvent("esx_addonaccount:getSharedAccount", account, function(accountObj)
                p:resolve(accountObj?.money)
            end)
            return Citizen.Await(p)
        end,
        addAccountBalance = function(account, amount)
            local p = promise.new()
            TriggerEvent("esx_addonaccount:getSharedAccount", account, function(accountObj)
                if accountObj == nil then
                    p:resolve(false)
                    return
                end
                accountObj.addMoney(amount)
                p:resolve(true)
            end)
            return Citizen.Await(p)
        end,
        removeAccountBalance = function(account, amount)
            local p = promise.new()
            TriggerEvent("esx_addonaccount:getSharedAccount", account, function(accountObj)
                if accountObj == nil then
                    p:resolve(false)
                    return
                end
                if accountObj.money < amount then
                    p:resolve(false)
                    return
                end
                accountObj.removeMoney(amount)
                p:resolve(true)
            end)
            return Citizen.Await(p)
        end,
        accountHasBalance = function(account, amount)
            local p = promise.new()
            TriggerEvent("esx_addonaccount:getSharedAccount", account, function(accountObj)
                if accountObj == nil then
                    p:resolve(false)
                    return
                end
                p:resolve(accountObj.money >= amount)
            end)
            return Citizen.Await(p)
        end,
    }

    return bankingProvider
end, ServicePriority.Lowest, "esx_addonaccount")
