---@alias NotificationStyle "info" | "success" | "error"

---@class NotificationOptions
---@field style? NotificationStyle
---@field duration? integer

---@class ClientNotificationProvider
---@field showNotification fun(message: string, options?: NotificationOptions): nil

---@class ServerNotificationProvider
---@field showNotification fun(playerId: integer, message: string, options?: NotificationOptions): nil
