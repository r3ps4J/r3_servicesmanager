export interface ServerInventoryProvider {
    addItem(playerId: number, itemName: string, amount: number): boolean;
    removeItem(playerId: number, itemName: string, amount: number): boolean;
    getItemCount(playerId: number, itemName: string): number;
    hasItem(playerId: number, itemName: string, amount: number): boolean;
}
