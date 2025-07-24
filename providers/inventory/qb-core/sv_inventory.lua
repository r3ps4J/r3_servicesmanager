RegisterOnResourceStart("inventory", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })

    ---@type ServerInventoryProvider
    local inventoryProvider
    inventoryProvider = {
        addItem = function(playerId, itemName, amount)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if not Player then
                return false
            end

            return Player.Functions.AddItem(itemName, amount)
        end,
        removeItem = function(playerId, itemName, amount)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if not Player then
                return false
            end

            return Player.Functions.RemoveItem(itemName, amount)
        end,
        getItemCount = function(playerId, itemName)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if not Player then
                return 0
            end

            local items = Player.Functions.GetItemsByName(itemName)
            local count = 0
            for _, item in pairs(items) do
                if itemName == item.name then
                    count = count + item.amount
                end
            end
            return count
        end,
        hasItem = function(playerId, itemName, amount)
            return inventoryProvider.getItemCount(playerId, itemName) >= amount
        end,
    }

    return inventoryProvider
end, ServicePriority.Lowest, "qb-core")
