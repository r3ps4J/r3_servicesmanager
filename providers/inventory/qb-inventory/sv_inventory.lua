RegisterOnResourceStart("inventory", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })

    ---@param inventoryRef InventoryRef
    local function getInventory(inventoryRef)
        if inventoryRef.type == "trunk" then
            return "trunk-" .. inventoryRef.id
        elseif inventoryRef.type == "glovebox" then
            return "glovebox-" .. inventoryRef.id
        end
        return inventoryRef.id
    end

    ---@param inv integer | string
    ---@param itemName string
    local function getItemCount(inv, itemName)
        local inventory
        local Player = QBCore.Functions.GetPlayer(inv)
        if Player then
            inventory = Player.PlayerData.items
        else
            inventory = exports["qb-inventory"]:GetInventory(inv)
        end

        local count = 0
        for _, item in pairs(inventory) do
            if itemName == item.name then
                count = count + item.amount
            end
        end
        return count
    end

    ---@type ServerInventoryProvider
    local inventoryProvider = {
        addItem = function(inventoryRef, itemName, amount)
            local inv = getInventory(inventoryRef)
            return exports["qb-inventory"]:AddItem(inv, itemName, amount)
        end,
        removeItem = function(inventoryRef, itemName, amount)
            local inv = getInventory(inventoryRef)
            return exports["qb-inventory"]:RemoveItem(inv, itemName, amount)
        end,
        getItemCount = function(inventoryRef, itemName)
            local inv = getInventory(inventoryRef)
            return getItemCount(inv, itemName)
        end,
        hasItem = function(inventoryRef, itemName, amount)
            local inv = getInventory(inventoryRef)
            return getItemCount(inv, itemName) > amount
        end,
        canCarryItem = function(inventoryRef, itemName, amount)
            local inv = getInventory(inventoryRef)
            return exports["qb-inventory"]:CanAddItem(inv, itemName, amount)
        end,
    }

    return inventoryProvider
end, ServicePriority.Low, "qb-inventory")
