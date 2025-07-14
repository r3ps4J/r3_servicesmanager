RegisterOnResourceStart("inventory", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@param playerId integer
    ---@param itemName string
    local function getItemCount(playerId, itemName)
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer == nil then
            return 0
        end
        return xPlayer.getInventoryItem(itemName)?.count or 0
    end

    ---@type ServerInventoryProvider
    local inventoryProvider = {
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

            if getItemCount(playerId, itemName) < amount then
                return false
            end

            xPlayer.removeInventoryItem(itemName, amount)
            return true
        end,
        getItemCount = getItemCount,
        hasItem = function(playerId, itemName, amount)
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer == nil then
                return false
            end

            local item, count = xPlayer.hasItem(itemName)
            return item ~= false and count >= amount
        end,
        canCarryItem = function (playerId, itemName, amount)
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer == nil then
                return false
            end

            return xPlayer.canCarryItem(itemName, amount)
        end
    }

    return inventoryProvider
end, ServicePriority.Lowest, "es_extended")
