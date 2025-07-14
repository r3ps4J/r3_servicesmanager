RegisterOnResourceStart("stash", function()
    ---@param inventoryRef InventoryRef
    local function getInventory(inventoryRef)
        if inventoryRef.type == "trunk" then
            return "trunk" .. inventoryRef.id
        elseif inventoryRef.type == "glovebox" then
            return "glove" .. inventoryRef.id
        end
        return inventoryRef.id
    end

    ---@type ServerStashProvider
    local stashProvider = {
        addItem = function(inventoryRef, itemName, amount)
            local inv = getInventory(inventoryRef)
            local success, _response = exports.ox_inventory:AddItem(inv, itemName, amount)
            return success
        end,
        removeItem = function(inventoryRef, itemName, amount)
            local inv = getInventory(inventoryRef)
            local success, _response = exports.ox_inventory:RemoveItem(inv, itemName, amount)
            return success
        end,
        getItemCount = function(inventoryRef, itemName)
            local inv = getInventory(inventoryRef)
            return exports.ox_inventory:GetItemCount(inv, itemName)
        end,
        hasItem = function(inventoryRef, itemName, amount)
            local inv = getInventory(inventoryRef)
            return exports.ox_inventory:GetItemCount(inv, itemName) >= amount
        end,
        canAddItem = function(inventoryRef, itemName, amount)
            local inv = getInventory(inventoryRef)
            return exports.ox_inventory:CanCarryItem(inv, itemName, amount)
        end,
    }

    return stashProvider
end, ServicePriority.Low, "ox_inventory")
