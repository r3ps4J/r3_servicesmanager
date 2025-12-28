# Context menu
The context menu providers provide a service that allows resources to show players a context menu.

## Usage
To retrieve the context menu provider, use the load function with `"contextMenu"` for the `service` parameter.

Lua:
```lua
local contextMenuProvider = exports.r3_servicesmanager:load("contextMenu")
```

JavaScript:
```js
const contextMenuProvider = exports.r3_servicesmanager.load("contextMenu");
```

### Client
On the client side, the following methods are available:

#### openMenu
Opens a context menu for the player.

```lua
contextMenuProvider.openMenu(contextMenuOptions)
```

Parameters:
- contextMenuOptions: [`ContextMenuOptions`](#contextmenuoptions)

Returns:
- `nil`

#### closeMenu
Closes the context menu that is currently open.

```lua
contextMenuProvider.closeMenu()
```

Returns:
- `nil`

## Types
The following types are used within the context menu provider:

### ContextMenuOptions
An object containing the options for a context menu.

Fields:
- id: `string`
- title: `string`
- elements: [`ContextMenuElement[]`](#contextmenuelement)
- onClose: `fun(): nil` (optional, gets called when the menu is closed by the user or using [`closeMenu`](#closemenu), can be called when an element was selected but this is provider dependent and not always the case)

### ContextMenuElement
An object containing the options for a single context menu element.

Fields:
- title: `string`
- description: `string` (optional)
- icon: `string` (optional, full font awesome 5 icon including prefix such as "fas fa-")
- disabled: `boolean` (optional)
- onSelect: `fun(): nil` (optional)

## Registration
To register a menu provider, ensure it implements all methods described above. Check out [`contextMenu.lua`](./definitions/contextMenu.lua) and [`contextMenu.ts`](./definitions/contextMenu.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("contextMenu", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("contextMenu", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
