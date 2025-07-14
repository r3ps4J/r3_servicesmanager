RegisterOnResourceStart("inventory", function()
    ---@type ServerInventoryProvider
    local inventoryProvider = {
        addItem = function(playerId, itemName, amount)
            local success, _response = exports.ox_inventory:AddItem(playerId, itemName, amount)
            return success
        end,
        removeItem = function(playerId, itemName, amount)
            local success, _response = exports.ox_inventory:RemoveItem(playerId, itemName, amount)
            return success
        end,
        getItemCount = function(playerId, itemName)
            return exports.ox_inventory:GetItemCount(playerId, itemName)
        end,
        hasItem = function(playerId, itemName, amount)
            return exports.ox_inventory:GetItemCount(playerId, itemName) >= amount
        end,
    }

    return inventoryProvider
end, ServicePriority.Low, "ox_inventory")
