RegisterOnResourceStart("notification", function()
    local ESX = exports["es_extended"].getSharedObject()

    ---@type table<NotificationStyle, string>
    local styles = {
        info = "info",
        success = "success",
        error = "error",
    }

    ---@type ClientNotificationProvider
    local notificationProvider = {
        showNotification = function(message, options)
            local style = options and options.style and styles[options.style] or nil
            ESX.ShowNotification(message, style, options and options.duration or nil)
        end,
    }

    return notificationProvider
end, ServicePriority.Lowest, "es_extended")
