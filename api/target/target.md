# Target
The target providers provide a service that allows resources to create targetable interactions.

## Usage
To retrieve the target provider, use the load function with `"target"` for the `service` parameter.

Lua:
```lua
local targetProvider = exports.r3_servicesmanager:load("target")
```

JavaScript:
```js
const targetProvider = exports.r3_servicesmanager.load("target");
```

### Client
On the client side, the following methods are available:

#### addGlobalObject
Adds global options for all objects.

```lua
targetProvider.addGlobalObject(options)
```

Parameters:
- options: [`TargetOption[]`](#targetoption)

Returns:
- `nil`

#### removeGlobalObject
Removes global options for all objects by their names.

```lua
targetProvider.removeGlobalObject(optionNames)
```

Parameters:
- optionNames: `string[]`

Returns:
- `nil`

#### addGlobalPlayer
Adds global options for players.

```lua
targetProvider.addGlobalPlayer(options)
```

Parameters:
- options: [`TargetOption[]`](#targetoption)

Returns:
- `nil`

#### removeGlobalPlayer
Removes global options for players by their names.

```lua
targetProvider.removeGlobalPlayer(optionNames)
```

Parameters:
- optionNames: `string[]`

Returns:
- `nil`

#### addGlobalVehicle
Adds global options for vehicles.

```lua
targetProvider.addGlobalVehicle(options)
```

Parameters:
- options: [`TargetOption[]`](#targetoption)

Returns:
- `nil`

#### removeGlobalVehicle
Removes global options for vehicles by their names.

```lua
targetProvider.removeGlobalVehicle(optionNames)
```

Parameters:
- optionNames: `string[]`

Returns:
- `nil`

#### addModel
Adds options for specific models.

```lua
targetProvider.addModel(models, options)
```

Parameters:
- models: `integer | string | (integer | string)[]`
- options: [`TargetOption[]`](#targetoption)

Returns:
- `nil`

#### removeModel
Removes options for specific models by their names.

```lua
targetProvider.removeModel(models, optionNames)
```

Parameters:
- models: `integer | string | (integer | string)[]`
- optionNames: `string[]`

Returns:
- `nil`

#### addEntity
Adds options for specific entities.

```lua
targetProvider.addEntity(netIds, options)
```

Parameters:
- netIds: `integer | integer[]`
- options: [`TargetOption[]`](#targetoption)

Returns:
- `nil`

#### removeEntity
Removes options for specific entities by their names.

```lua
targetProvider.removeEntity(netIds, optionNames)
```

Parameters:
- netIds: `integer | integer[]`
- optionNames: `string[]`

Returns:
- `nil`

#### addLocalEntity
Adds options for specific local entities.

```lua
targetProvider.addLocalEntity(entities, options)
```

Parameters:
- entities: `integer | integer[]`
- options: [`TargetOption[]`](#targetoption)

Returns:
- `nil`

#### removeLocalEntity
Removes options for specific local entities by their names.

```lua
targetProvider.removeLocalEntity(entities, optionNames)
```

Parameters:
- entities: `integer | integer[]`
- optionNames: `string[]`

Returns:
- `nil`

#### addSphereZone
Creates a new targetable sphere zone with the provided options.

```lua
targetProvider.addSphereZone(parameters)
```

Parameters:
- parameters:
    - name: `string`
    - options: `TargetOption[]`
    - coords: `vector3`
    - radius: `number` (optional)
    - debug: `boolean` (optional)

Returns:
- `string` The name of the zone which can be used to remove it later.

#### addBoxZone
Creates a new targetable box zone with the provided options.

```lua
targetProvider.addBoxZone(parameters)
```

Parameters:
- parameters:
    - name: `string`
    - options: `TargetOption[]`
    - coords: `vector3`
    - size: `number` (optional)
    - debug: `boolean` (optional)

Returns:
- `string` The name of the zone which can be used to remove it later.

#### addPolyZone
Creates a new targetable poly zone with the provided options.

```lua
targetProvider.addPolyZone(parameters)
```

Parameters:
- parameters:
    - name: `string`
    - options: `TargetOption[]`
    - points: `vector3[]`
    - thickness: `number` (optional)
    - debug: `boolean` (optional)

Returns:
- `string` The name of the zone which can be used to remove it later.

#### removeZone
Removes a targetable zone by name.

```lua
targetProvider.removeZone(name)
```

Parameters:
- name: `string`

Returns:
- `nil`

## Types
The following types are used within the target provider:

### TargetOption
An object containing the options for a single target option.

Fields:
- label: `string`
- name: `string` (optional, used to remove an option)
- icon: `string` (optional, full font awesome 5 icon including prefix such as "fas fa-")
- distance: `number` (optional)
- bones: `string[]` (optional)
- groups: `table<string, integer>` (optional, group: minimum grade map)
- canInteract: `fun(entity: number, distance: number, coords: vector3, name: string, bone: string): boolean` (optional)
- onSelect: `fun(data: TargetResponse): nil`

### TargetResponse
An object containing the data that is passed to the onSelect function when an option is selected.

Fields:
- entity: `integer`

## Registration
To register a target provider, ensure it implements all methods described above. Check out [`target.lua`](./definitions/target.lua) and [`target.ts`](./definitions/target.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("target", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("target", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
