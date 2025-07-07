export interface ServerUsableItemsProvider {
    registerUsableItem(itemName: string, cb: (playerId: number) => void): void;
}
