RegisterOnResourceStart("notification", function()
    ---@type table<NotificationStyle, string>
    local styles = {
        info = "inform",
        success = "success",
        error = "error",
    }

    ---@type ClientNotificationProvider
    local notificationProvider = {
        showNotification = function(message, options)
            local style = options and options.style and styles[options.style] or nil
            local duration = options and options.duration or nil
            exports.qbx_core:Notify(message, style, duration)
        end,
    }

    return notificationProvider
end, ServicePriority.Lowest, "qbx_core")
