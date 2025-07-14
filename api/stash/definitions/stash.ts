export type InventoryType = "stash" | "trunk" | "glovebox";

export interface InventoryRef {
    type: InventoryType;
    id: number | string;
}

export interface ServerStashProvider {
    addItem(inventoryRef: InventoryRef, itemName: string, amount: number): boolean;
    removeItem(inventoryRef: InventoryRef, itemName: string, amount: number): boolean;
    getItemCount(inventoryRef: InventoryRef, itemName: string): number;
    hasItem(inventoryRef: InventoryRef, itemName: string, amount: number): boolean;
}
