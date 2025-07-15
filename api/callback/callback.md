# Callback
The callback providers provide a service that allows resources to register and trigger callbacks.

## Usage
To retrieve the callback provider, use the load function with `"callback"` for the `service` parameter.

Lua:
```lua
local callbackProvider = exports.r3_servicesmanager:load("callback")
```

JavaScript:
```js
const callbackProvider = exports.r3_servicesmanager.load("callback");
```

### Client
On the client side, the following methods are available:

#### triggerServerCallback
Triggers a server callback and calls the provided callback function with the result.

```lua
callbackProvider.triggerServerCallback(name, cb, ...)
```

Parameters:
- name: `string`
- cb: `fun(result: any): nil`
- ...: `any[]` (parameters of the callback)

Returns:
- `nil`

#### awaitServerCallback
Triggers a server callback and awaits the result which then gets returned.

```lua
local result = callbackProvider.awaitServerCallback(name, ...)
```

Parameters:
- name: `string`
- ...: `any[]` (parameters of the callback)

Returns:
- `any`

### Server
On the server side, the following methods are available:

#### registerServerCallback
Registers a server callback with the given name.

```lua
callbackProvider.registerServerCallback(name, cb)
```

Parameters:
- name: `string`
- cb: `fun(playerId: integer, ...): any`

Returns:
- `nil`

## Registration
To register a callback provider, ensure it implements all methods described above. Check out [`callback.lua`](./definitions/callback.lua) and [`callback.ts`](./definitions/callback.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("callback", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("callback", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
