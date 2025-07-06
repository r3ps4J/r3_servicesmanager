export type InventoryType = "player" | "stash" | "trunk" | "glovebox";

export interface InventoryRef {
    type: InventoryType;
    id: number | string;
}

export interface ServerInventoryProvider {
    addItem(inventoryRef: InventoryRef, itemName: string, amount: number): boolean;
    removeItem(inventoryRef: InventoryRef, itemName: string, amount: number): boolean;
    getItemCount(inventoryRef: InventoryRef, itemName: string): number;
    hasItem(inventoryRef: InventoryRef, itemName: string, amount: number): boolean;
    canCarryItem(inventoryRef: InventoryRef, itemName: string, amount: number): boolean;
}
