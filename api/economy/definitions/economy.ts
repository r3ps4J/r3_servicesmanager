export type AccountType = "cash" | "bank";

export interface ServerEconomyProvider {
    getPlayerBalance(playerId: number, account: AccountType): number | undefined;
    setPlayerBalance(playerId: number, account: AccountType, amount: number): boolean;
    addPlayerBalance(playerId: number, account: AccountType, amount: number): boolean;
    removePlayerBalance(playerId: number, account: AccountType, amount: number): boolean;
    playerHasBalance(playerId: number, account: AccountType): boolean;
}
