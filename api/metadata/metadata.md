# Metadata
The metadata providers provide a service that allows resources to store metadata specific to a player.

## Usage
To retrieve the metadata provider, use the load function with `"metadata"` for the `service` parameter.

Lua:
```lua
local metadataProvider = exports.r3_servicesmanager:load("metadata")
```

JavaScript:
```js
const metadataProvider = exports.r3_servicesmanager.load("metadata");
```

### Server
On the server side, the following methods are available:

#### getPlayerMetadata
Retrieves the metadata of a player with a specified key.

```lua
metadataProvider.getPlayerMetadata(playerId, key)
```

Parameters:
- playerId: `integer`
- key: `string`

Returns:
- `any` (whatever the type of the metadata is)
- `nil` if the player or metadata could not be found.

#### setPlayerMetadata
Sets the metadata of a player with a specified key.

```lua
metadataProvider.setPlayerMetadata(playerId, key, value)
```

Parameters:
- playerId: `integer`
- key: `string`
- value: `any` (whatever the type of the metadata is)

Returns:
- `true` if the metadata was sucessfully set.
- `false` if the player could not be found.

## Registration
To register an metadata provider, ensure it implements all methods described above. Check out [`metadata.lua`](./definitions/metadata.lua) and [`metadata.ts`](./definitions/metadata.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("metadata", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("metadata", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
