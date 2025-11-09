# Menu
The menu providers provide a service that allows resources to show players a menu.

## Usage
To retrieve the menu provider, use the load function with `"menu"` for the `service` parameter.

Lua:
```lua
local menuProvider = exports.r3_servicesmanager:load("menu")
```

JavaScript:
```js
const menuProvider = exports.r3_servicesmanager.load("menu");
```

### Client
On the client side, the following methods are available:

#### openMenu
Opens a menu for the player.

```lua
menuProvider.openMenu(menuOptions)
```

Parameters:
- menuOptions: [`MenuOptions`](#menuoptions)

Returns:
- `nil`

#### closeMenu
Closes the menu that is currently open.

```lua
menuProvider.closeMenu()
```

Returns:
- `nil`

## Types
The following types are used within the menu provider:

### MenuOptions
An object containing the options for a menu.

Fields:
- id: `string`
- title: `string`
- elements: [`MenuElement[]`](#menuelement)

### MenuElement
An object containing the options for a single menu element.

Fields:
- title: `string`
- description: `string` (optional)
- icon: `string` (optional, full font awesome 5 icon including prefix such as "fas fa-")
- disabled: `boolean` (optional)
- onSelect: `fun(): nil` (optional)

## Registration
To register a menu provider, ensure it implements all methods described above. Check out [`menu.lua`](./definitions/menu.lua) and [`menu.ts`](./definitions/menu.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("menu", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("menu", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
