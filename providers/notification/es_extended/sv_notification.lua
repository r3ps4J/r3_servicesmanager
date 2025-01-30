RegisterOnResourceStart("notification", function()
    ---@type table<NotificationStyle, string>
    local styles = {
        info = "info",
        success = "success",
        error = "error",
    }

    ---@type ServerNotificationProvider
    local notificationProvider = {
        showNotification = function(playerId, message, options)
            local style = options and options.style and styles[options.style] or nil
            local duration = options and options.duration or nil
            TriggerClientEvent("esx:showNotification", playerId, message, style, duration)
        end,
    }

    return notificationProvider
end, ServicePriority.Lowest, "es_extended")
