RegisterOnResourceStart("inventory", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type ServerInventoryProvider
    local inventoryProvider
    inventoryProvider = {
        addItem = function(playerId, itemName, amount)
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer == nil then
                return false
            end

            if not xPlayer.canCarryItem(itemName, amount) then
                return false
            end

            xPlayer.addInventoryItem(itemName, amount)
            return true
        end,
        removeItem = function(playerId, itemName, amount)
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer == nil then
                return false
            end

            if not inventoryProvider.hasItem(playerId, itemName, amount) then
                return false
            end

            xPlayer.removeInventoryItem(itemName, amount)
            return true
        end,
        getItemCount = function(playerId, itemName)
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer == nil then
                return 0
            end
            return xPlayer.getInventoryItem(itemName)?.count or 0
        end,
        hasItem = function(playerId, itemName, amount)
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer == nil then
                return false
            end

            local item, count = xPlayer.hasItem(itemName)
            return item ~= false and count >= amount
        end,
    }

    return inventoryProvider
end, ServicePriority.Lowest, "es_extended")
