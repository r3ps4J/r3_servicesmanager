# TextUI
The text UI providers provide a service that allows resources to show a text UI to players.

## Usage
To retrieve the text UI provider, use the load function with `"textUI"` for the `service` parameter.

Lua:
```lua
local textUIProvider = exports.r3_servicesmanager:load("textUI")
```

JavaScript:
```js
const textUIProvider = exports.r3_servicesmanager.load("textUI");
```

### Client
On the client side, the following methods are available:

#### showTextUI
Shows a new text UI to the player.

```lua
textUIProvider.showTextUI(text)
```

Parameters:
- text: `string`

Returns:
- `nil`

#### hideTextUI
Hides the currently active text UI.

```lua
textUIProvider.hideTextUI()
```

Returns:
- `nil`

## Registration
To register a text UI provider, ensure it implements all methods described above. Check out [`textUI.lua`](./definitions/textUI.lua) and [`textUI.ts`](./definitions/textUI.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("textUI", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("textUI", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
