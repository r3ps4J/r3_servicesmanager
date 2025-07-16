# State
The state providers provide a service that allows resources to check whether players are fully loaded.

## Usage
To retrieve the text UI provider, use the load function with `"state"` for the `service` parameter.

Lua:
```lua
local stateProvider = exports.r3_servicesmanager:load("state")
```

JavaScript:
```js
const stateProvider = exports.r3_servicesmanager.load("state");
```

### Client
On the client side, the following methods are available:

#### isPlayerLoaded
Returns whether the player is fully loaded.

```lua
stateProvider.isPlayerLoaded()
```

Returns:
- `boolean`

#### onPlayerLoaded
Can be used to register a callback which will be invoked when the player loads.

```lua
stateProvider.onPlayerLoaded(callback)
```

Parameters:
- callback: `fun(): nil`

Returns:
- [`Subscription`](#subscription)

## Types
The following types are used within the state provider:

### Subscription
A subscription to an event emitter.

Fields:
- unsubscribe: `fun(): nil`

## Registration
To register a state provider, ensure it implements all methods described above. Check out [`state.lua`](./definitions/state.lua) and [`state.ts`](./definitions/state.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("state", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("state", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
