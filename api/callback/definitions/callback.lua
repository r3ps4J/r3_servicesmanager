---@class ClientCallbackProvider
---@field triggerServerCallback fun(name: string, cb: fun(result: any): nil, ...): nil
---@field awaitServerCallback fun(name: string, ...): any

---@class ServerCallbackProvider
---@field registerServerCallback fun(name: string, cb: fun(playerId: integer, ...): any): nil
