RegisterOnResourceStart("usableItems", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type ServerUsableItemsProvider
    local usableItemsProvider = {
        registerUsableItem = function(itemName, cb)
            ESX.RegisterUsableItem(itemName, cb)
        end,
    }

    return usableItemsProvider
end, ServicePriority.Lowest, "es_extended")
