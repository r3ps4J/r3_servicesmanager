export interface ServerBankingProvider {
    getAccountBalance(account: string): number | undefined;
    addAccountBalance(account: string, amount: number): boolean;
    removeAccountBalance(account: string, amount: number): boolean;
    accountHasBalance(account: string, amount: number): boolean;
}
