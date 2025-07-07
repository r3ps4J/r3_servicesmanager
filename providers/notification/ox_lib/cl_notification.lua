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
            exports.ox_lib:notify({
                title = message,
                duration = options and options.duration or nil,
                type = options and options.style and styles[options.style] or nil,
            })
        end,
    }

    return notificationProvider
end, ServicePriority.Low, "ox_lib")
