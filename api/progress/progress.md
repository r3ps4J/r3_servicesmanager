# Progress
The progress providers provide a service that allows resources to show a progress bar to players.

## Usage
To retrieve the progress provider, use the load function with `"progress"` for the `service` parameter.

Lua:
```lua
local progressProvider = exports.r3_servicesmanager:load("progress")
```

JavaScript:
```js
const progressProvider = exports.r3_servicesmanager.load("progress");
```

### Client
On the client side, the following methods are available:

#### startProgress
Starts a new progress bar for the player.

```lua
progressProvider.startProgress(label, duration, progressOptions)
```

Parameters:
- label: `string`
- duration: `integer`
- progressOptions: [`ProgressOptions`](#progressoptions) (optional)

Returns:
- `nil`

#### cancelProgress
Cancels the currently active progress bar.

```lua
progressProvider.cancelProgress()
```

Returns:
- `nil`

## Types
The following types are used within the employment provider:

### ProgressOptions
An object containing the options for a progress bar.

Fields:
- disable: (optional)
    - movement: `boolean` (optional)
    - vehicleMovement: `boolean` (optional)
    - mouse: `boolean` (optional)
    - combat: `boolean` (optional)
- animation: (optional)
    - dict: `string`
    - clip: `string`
- scenario: `string` (optional)
- onFinish: `fun(): nil` (optional)
- onCancel: `fun(): nil` (optional)

## Registration
To register a progress provider, ensure it implements all methods described above. Check out [`progress.lua`](./definitions/progress.lua) and [`progress.ts`](./definitions/progress.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("progress", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("progress", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
