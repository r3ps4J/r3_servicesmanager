RegisterOnResourceStart("stash", function()
    ---@param inventoryRef InventoryRef
    local function getInventory(inventoryRef)
        if inventoryRef.type == "trunk" then
            return "trunk-" .. inventoryRef.id
        elseif inventoryRef.type == "glovebox" then
            return "glovebox-" .. inventoryRef.id
        end
        return inventoryRef.id
    end

    ---@type ServerStashProvider
    local stashProvider
    stashProvider = {
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
            local inventory = exports["qb-inventory"]:GetInventory(inv)
            local count = 0
            for _, item in pairs(inventory) do
                if itemName == item.name then
                    count = count + item.amount
                end
            end
            return count
        end,
        hasItem = function(inventoryRef, itemName, amount)
            return stashProvider.getItemCount(inventoryRef, itemName) >= amount
        end,
    }

    return stashProvider
end, ServicePriority.Low, "qb-inventory")
