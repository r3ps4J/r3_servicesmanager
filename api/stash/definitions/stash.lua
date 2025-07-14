---@alias InventoryType "stash" | "trunk" | "glovebox"

---@class InventoryRef
---@field type InventoryType
---@field id integer | string

---@class ServerStashProvider
---@field addItem fun(inventoryRef: InventoryRef, itemName: string, amount: number): boolean
---@field removeItem fun(inventoryRef: InventoryRef, itemName: string, amount: number): boolean
---@field getItemCount fun(inventoryRef: InventoryRef, itemName: string): number
---@field hasItem fun(inventoryRef: InventoryRef, itemName: string, amount: number): boolean
---@field canAddItem fun(inventoryRef: InventoryRef, itemName: string, amount: number): boolean
