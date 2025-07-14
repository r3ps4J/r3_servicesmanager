# Economy
The economy providers provide a service that allows resources to interact with the economy, specifically players their money.

## Usage
To retrieve the economy provider, use the load function with `"economy"` for the `service` parameter.

Lua:
```lua
local economyProvider = exports.r3_servicesmanager:load("economy")
```

JavaScript:
```js
const economyProvider = exports.r3_servicesmanager.load("economy");
```

### Server
On the server side, the following methods are available:

#### getPlayerBalance
Retrieves the balance of a player for the specified account.

```lua
economyProvider.getPlayerBalance(playerId, account)
```

Parameters:
- playerId: `integer`
- account: [`AccountType`](#accounttype)

Returns:
- `number`
- `nil` if the player could not be found.

#### setPlayerBalance
Sets the player's balance to the specified amount for the given account, and returns whether or not it was succesful.

```lua
economyProvider.setPlayerBalance(playerId, account, amount)
```

Parameters:
- playerId: `integer`
- account: [`AccountType`](#accounttype)
- amount: `number`

Returns:
- `true` if the balance was successfully set.
- `false` if the balance wasn't successfully set (i.e. the player could not be found).

#### addPlayerBalance
Adds money to the player's balance in the given account, and returns whether or not it was succesful.

```lua
economyProvider.addPlayerBalance(playerId, account, amount)
```

Parameters:
- playerId: `integer`
- account: [`AccountType`](#accounttype)
- amount: `number`

Returns:
- `true` if the balance was successfully added.
- `false` if the balance wasn't successfully added (i.e. the player could not be found).

#### removePlayerBalance
Removes money from the player's balance in the given account, and returns whether or not it was succesful.

```lua
economyProvider.removePlayerBalance(playerId, account, amount)
```

Parameters:
- playerId: `integer`
- account: [`AccountType`](#accounttype)
- amount: `number`

Returns:
- `true` if the balance was successfully removed.
- `false` if the balance wasn't successfully removed (i.e. the player could not be found or does not have enough money in the account).

#### playerHasBalance
Checks whether a player's balance in the given account is bigger than or equal to the specified amount.

```lua
economyProvider.playerHasBalance(playerId, account, amount)
```

Parameters:
- playerId: `integer`
- account: [`AccountType`](#accounttype)
- amount: `number`

Returns:
- `true` if the player's balance is bigger than or equal to the specified amount.
- `false` if the player's balance is less than the specified amount, or if the player could not be found.

## Types
The following types are used within the economy provider:

### AccountType
A union type of the possible account types within the economy provider.

Possible values:
- `"cash"`
- `"bank"`

*These values get mapped to the actual accounts for each provider.*

## Registration
To register an economy provider, ensure it implements all methods described above. Check out [`economy.lua`](./definitions/economy.lua) and [`economy.ts`](./definitions/economy.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("economy", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("economy", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
