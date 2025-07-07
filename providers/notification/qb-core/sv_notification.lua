RegisterOnResourceStart("notification", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })

    ---@type table<NotificationStyle, string>
    local styles = {
        info = "primary",
        success = "success",
        error = "error",
    }

    ---@type ServerNotificationProvider
    local notificationProvider = {
        showNotification = function(playerId, message, options)
            local style = options and options.style and styles[options.style] or nil
            local duration = options and options.duration or nil
            QBCore.Functions.Notify(playerId, message, style, duration)
        end,
    }

    return notificationProvider
end, ServicePriority.Lowest, "qb-core")
