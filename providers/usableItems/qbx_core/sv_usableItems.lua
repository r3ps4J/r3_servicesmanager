RegisterOnResourceStart("usableItems", function()
    ---@type ServerUsableItemsProvider
    local usableItemsProvider = {
        registerUsableItem = function(itemName, cb)
            exports.qbx_core:CreateUseableItem(itemName, cb)
        end,
    }

    return usableItemsProvider
end, ServicePriority.Low, "qbx_core")
