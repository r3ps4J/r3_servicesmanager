# Identity
The identity providers provide a service that allows resources to retrieve identifying information of a player.

## Usage
To retrieve the identity provider, use the load function with `"identity"` for the `service` parameter.

Lua:
```lua
local identity = exports.r3_servicesmanager:load("identity")
```

JavaScript:
```js
const identity = exports.r3_servicesmanager.load("identity");
```

### Server
On the server side, the following methods are available:

#### getPlayerIdentifier
Retrieves the identifier of a player. Use this identifier to store character-specific information.

```lua
identity.getPlayerIdentifier(playerId)
```

Parameters:
- playerId: `integer`

Returns:
- `string`
- `nil` if the player could not be found.

#### getPlayerName
Retrieves the name of the player's current character.

```lua
identity.getPlayerName(playerId)
```

Parameters:
- playerId: `integer`

Returns:
- `string`
- `nil` if the player could not be found.

## Registration
To register an identity provider, ensure it implements all methods described above. Check out [`identity.lua`](./definitions/identity.lua) and [`identity.ts`](./definitions/identity.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("identity", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("identity", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
