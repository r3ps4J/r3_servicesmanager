export type NotificationStyle = "info" | "success" | "error";

export interface NotificationOptions {
    style?: NotificationStyle;
    duration?: number;
}

export interface ClientNotificationProvider {
    showNotification(message: string, options?: NotificationOptions): void;
}

export interface ServerNotificationProvider {
    showNotification(playerId: number, message: string, options?: NotificationOptions): void;
}
