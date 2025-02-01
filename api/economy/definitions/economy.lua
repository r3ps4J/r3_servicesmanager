---@alias AccountType "cash" | "bank"

---@class ServerEconomyProvider
---@field getPlayerBalance fun(playerId: integer, account: AccountType): number | nil
---@field setPlayerBalance fun(playerId: integer, account: AccountType, amount: number): boolean
---@field addPlayerBalance fun(playerId: integer, account: AccountType, amount: number): boolean
---@field removePlayerBalance fun(playerId: integer, account: AccountType, amount: number): boolean
---@field playerHasBalance fun(playerId: number, account: AccountType, amount: number): boolean
