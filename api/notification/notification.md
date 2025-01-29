# Notification
The notification providers provide a service that allows resources to send notifications to players.

## Usage
To retrieve the notification provider, use the load function with `"notification"` for the `service` parameter.

Lua:
```lua
local notification = exports.r3_servicesmanager:load("notification")
```

JavaScript:
```js
const notification = exports.r3_servicesmanager.load("notification");
```

### Client
On the client side, we can send a notification without indicating a player to target.

```lua
notification.sendNotification(message, notificationOptions)
```

### Server
On the server side, we need to include the id of the player to send the notification to as well.

```lua
notification.sendNotification(playerId, message, notificationOptions)
```

See the definition for NotificationOptions [below](#notificationoptions).

## Registration
To register a notification provider, ensure it implements all methods described below. Check out [`notification.lua`](./definitions/notification.lua) and [`notification.ts`](./definitions/notification.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("notification", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("notification", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.

### Client
On the client side, implement the `ClientNotificationProvider` interface which has the following methods:

- `showNotification(message, notificationOptions)`
    - Parameters:
        - message: `string`
        - notificationOptions: [`NotificationOptions`](#notificationoptions)
    - Returns: `void`

### Server
On the server side, implement the `ServerNotificationProvider` interface which has the following methods:

- `showNotification(playerId, message, notificationOptions)`
    - Parameters:
        - playerId: `integer`
        - message: `string`
        - notificationOptions: [`NotificationOptions`](#notificationoptions)
    - Returns: `void`

## NotificationOptions
The `showNotification` methods expect a NotificationOptions object with the following fields:

- style?: `"info" | "success" | "error"`
- duration?: `integer`

Notes:

- All optional fields default to the default values used by the notification resource.
- All values are converted to the corresponding values for the currently registered provider.
