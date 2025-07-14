# Notification
The notification providers provide a service that allows resources to send notifications to players.

## Usage
To retrieve the notification provider, use the load function with `"notification"` for the `service` parameter.

Lua:
```lua
local notificationProvider = exports.r3_servicesmanager:load("notification")
```

JavaScript:
```js
const notificationProvider = exports.r3_servicesmanager.load("notification");
```

### Client
On the client side, the following methods are available:

#### showNotification
Shows a notification to the player.

```lua
notificationProvider.showNotification(message, notificationOptions)
```

Parameters:
- message: `string`
- notificationOptions: [`NotificationOptions`](#notificationoptions) (optional)

Returns:
- `nil`

### Server
On the server side, the following methods are available:

#### showNotification
Shows a notification to a player specified by their player ID.

```lua
notificationProvider.showNotification(playerId, message, notificationOptions)
```

Parameters:
- playerId: `integer`
- message: `string`
- notificationOptions: [`NotificationOptions`](#notificationoptions) (optional)

Returns:
- `nil`

## Types
The following types are used within the employment provider:

### NotificationOptions
An object containing the options for a notification.

Fields:
- style: `"info" | "success" | "error"` (optional)
- duration: `integer` (optional)

Notes:

- All optional fields default to the default values used by the notification resource.
- All values are converted to the corresponding values for the currently registered provider.

## Registration
To register a notification provider, ensure it implements all methods described above. Check out [`notification.lua`](./definitions/notification.lua) and [`notification.ts`](./definitions/notification.ts) for type definitions.

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
