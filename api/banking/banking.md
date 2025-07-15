# Banking
The banking providers provide a service that allows resources to interact with bank accounts.

## Usage
To retrieve the banking provider, use the load function with `"banking"` for the `service` parameter.

Lua:
```lua
local bankingProvider = exports.r3_servicesmanager:load("banking")
```

JavaScript:
```js
const bankingProvider = exports.r3_servicesmanager.load("banking");
```

### Server
On the server side, the following methods are available:

#### getAccountBalance
Retrieves the balance of the specified bank account.

```lua
bankingProvider.getAccountBalance(account)
```

Parameters:
- account: `string`

Returns:
- `number`
- `nil` if the account could not be found.

#### addAccountBalance
Adds money to the given account, and returns whether or not it was succesful.

```lua
bankingProvider.addAccountBalance(account, amount)
```

Parameters:
- account: `string`
- amount: `number`

Returns:
- `true` if the balance was successfully added.
- `false` if the balance wasn't successfully added (i.e. the account could not be found).

#### removeAccountBalance
Removes money from the given account, and returns whether or not it was succesful.

```lua
bankingProvider.removeAccountBalance(account, amount)
```

Parameters:
- account: `string`
- amount: `number`

Returns:
- `true` if the balance was successfully removed.
- `false` if the balance wasn't successfully removed (i.e. the account could not be found or there is not enough money in the account).

#### accountHasBalance
Checks whether the given account's balance is bigger than or equal to the specified amount.

```lua
bankingProvider.accountHasBalance(account, amount)
```

Parameters:
- account: `string`
- amount: `number`

Returns:
- `true` if the account's balance is bigger than or equal to the specified amount.
- `false` if the account's balance is less than the specified amount, or if the account could not be found.

## Registration
To register a banking provider, ensure it implements all methods described above. Check out [`banking.lua`](./definitions/banking.lua) and [`banking.ts`](./definitions/banking.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("banking", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("banking", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
