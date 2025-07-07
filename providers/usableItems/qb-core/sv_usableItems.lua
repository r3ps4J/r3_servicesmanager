RegisterOnResourceStart("usableItems", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })

    ---@type ServerUsableItemsProvider
    local usableItemsProvider = {
        registerUsableItem = function(itemName, cb)
            QBCore.Functions.CreateUseableItem(itemName, cb)
        end,
    }

    return usableItemsProvider
end, ServicePriority.Lowest, "qb-core")
