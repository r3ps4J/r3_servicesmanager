# Stash
The stash providers provide a service that allows resources to interact with the inventory of objects (i.e. stashes, vehicles).

## Usage
To retrieve the inventory provider, use the load function with `"stash"` for the `service` parameter.

Lua:
```lua
local stashProvider = exports.r3_servicesmanager:load("stash")
```

JavaScript:
```js
const stashProvider = exports.r3_servicesmanager.load("stash");
```

### Server
On the server side, the following methods are available:

#### addItem
Adds an item to the specified inventory.

```lua
stashProvider.addItem(inventoryRef, itemName, amount)
```

Parameters:
- inventoryRef: [`InventoryRef`](#inventoryref)
- itemName: `string`
- amount: `integer`

Returns:
- `true` if the item was successfully added.
- `false` if the item wasn't successfully added (i.e. the player could not carry it).

#### getItemCount
Returns the count of an item in the specified inventory.

```lua
stashProvider.getItemCount(inventoryRef, itemName)
```

Parameters:
- inventoryRef: [`InventoryRef`](#inventoryref)
- itemName: `string`

Returns:
- `integer`

#### hasItem
Checks whether an inventory has a certain item and if the amount of the given item is bigger than or equal to the specified amount.

```lua
stashProvider.hasItem(inventoryRef, itemName, amount)
```

Parameters:
- inventoryRef: [`InventoryRef`](#inventoryref)
- itemName: `string`
- amount: `integer`

Returns:
- `true` if the inventory has the given item and the amount of the given item is bigger than or equal to the specified amount.
- `false` if the the inventory doesn't have the given item or the amount of the given item is less than the specified amount.

## Types
The following types are used within the inventory provider:

### InventoryRef
An object that acts as a reference for the target inventory.

Fields:
- type: `"stash" | "trunk" | "glovebox"`
- id: `integer` or `string`

## Registration
To register an inventory provider, ensure it implements all methods described above. Check out [`stash.lua`](./definitions/stash.lua) and [`stash.ts`](./definitions/stash.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("stash", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("stash", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
