# Player state
The player state providers provide a service that allows resources to check whether players are fully loaded.

## Usage
To retrieve the player state provider, use the load function with `"playerState"` for the `service` parameter.

Lua:
```lua
local playerStateProvider = exports.r3_servicesmanager:load("playerState")
```

JavaScript:
```js
const playerStateProvider = exports.r3_servicesmanager.load("playerState");
```

### Client
On the client side, the following methods are available:

#### isPlayerLoaded
Returns whether the player is fully loaded.

```lua
playerStateProvider.isPlayerLoaded()
```

Returns:
- `boolean`

#### onPlayerLoaded
Can be used to register a callback which will be invoked when the player loads.

```lua
playerStateProvider.onPlayerLoaded(callback)
```

Parameters:
- callback: `fun(): nil`

Returns:
- [`Subscription`](#subscription)

## Types
The following types are used within the player state provider:

### Subscription
A subscription to an event emitter.

Fields:
- unsubscribe: `fun(): nil`

## Registration
To register a player state provider, ensure it implements all methods described above. Check out [`playerState.lua`](./definitions/playerState.lua) and [`playerState.ts`](./definitions/playerState.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("playerState", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("playerState", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
