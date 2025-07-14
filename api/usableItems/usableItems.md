# Usable items
The usable items providers provide a service that allows resources to register usable items.

## Usage
To retrieve the usable items provider, use the load function with `"usableItems"` for the `service` parameter.

Lua:
```lua
local usableItemsProvider = exports.r3_servicesmanager:load("usableItems")
```

JavaScript:
```js
const usableItemsProvider = exports.r3_servicesmanager.load("usableItems");
```

### Server
On the server side, the following methods are available:

#### registerUsableItem
Registers a usable item.

```lua
usableItemsProvider.registerUsableItem(itemName, cb)
```

Parameters:
- itemName: `string`
- cb: `fun(playerId: integer): nil`

Returns:
- `nil`

## Registration
To register a usable items provider, ensure it implements all methods described above. Check out [`usableItems.lua`](./definitions/usableItems.lua) and [`usableItems.ts`](./definitions/usableItems.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("usableItems", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("usableItems", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
